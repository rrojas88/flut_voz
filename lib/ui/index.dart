import 'package:flutter/material.dart';
import 'dart:async';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:flutter_tts/flutter_tts.dart';

import 'package:flut_voz/ui/setting.dart';
import 'package:flut_voz/ui/Yobi.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  String _strLogg = '';
  String _estado = 'Inicial';
  String _texto = '..nada aún';

  TextEditingController _textoCTRL = new TextEditingController();

  // ************************
  bool _finalResult = true;
  double level = 0.0;
  String lastStatus = "";
  String _currentLocaleId = "es_ES";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  final FlutterTts flutterTts = FlutterTts();

  final Yobi yb = new Yobi();


  double _rate = 0.5;
  double _pitch = 1.0;
  double _volume = 1.0;
  bool _debugger = false;
  Setting _setting = new Setting(configGeneral: (){}  );

  @override
  void initState() {
    super.initState();
    initTodo();
  }

  void configGeneral(double rate, double pitch, double volume, bool debugger){
    print('config => debugger:$debugger');
    _rate = rate;
    _pitch = pitch;
    _volume = volume;
    _debugger = debugger;
    setState(() {   });
  }

  Future<void> initTodo() async {

    _setting.configGeneral = configGeneral;

    bool hasSpeech = await speech.initialize(
        onError: errorListener, 
        onStatus: statusListener
    );

    flutterTts.setCompletionHandler(() {
      statusListener('No hablando');

      _continuarDespuesDeHablar();
    });

    init( yb, _speak, startOir, log );

    setState(() {  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voz'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: _crearSetting(),
      backgroundColor: Color.fromRGBO(231, 250, 230, 1.0),
      body: SingleChildScrollView( // Corrige Error que no quepa en Pantalla !!!!!
        child: Container(
          padding: EdgeInsets.only( top: 40.0 ),
          child: Column(
            children: <Widget>[
              _crearBotonesPrincipales(),
              SizedBox( height: 16.0 ),
              Text(
                'Estado: $_estado',
                style: TextStyle( fontWeight: FontWeight.bold )
              ),
              Divider( height: 30.0 ),
              _crearBotonesSecundarios(),
              SizedBox( height: 16.0 ),
              Text('Nivel voz: $level'),
              //Text('finalResult: $_finalResult'),
              _crearCampoTexto(),
              Divider(),
              //_crearBotonInicializar(),
              Text(_strLogg )
            ],
          ),  
        ),
      ),
    );
  }

  Widget _crearSetting(){
    return Drawer(
      child: _setting,
    );
  }

  void log( String info ){
    if ( _debugger ){
      setState(() {
        _strLogg += "\n"+info;
      });
    }
  }


  Widget _crearBotonesPrincipales(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _crearBotonPlay(),
        _crearBotonCancelar()
      ],
    );
  }
  Widget _crearBotonesSecundarios(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _crearBotonReproducir(),
        _crearBotonLimpiar(),
      ],
    );
  }

  Widget _crearBotonPlay() {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 12.0 ),
        child: Icon(
          Icons.mic, 
          color: Colors.white,
          size: 40.0,
        )
      ),
      color: Colors.green, 
      onPressed: (){ 
        startOir(); 
      },
      shape: StadiumBorder(),
      textColor: Colors.white,
    );
  }
  Widget _crearBotonCancelar() {
    return IconButton(
      icon: Icon( Icons.mic_off ),
      iconSize: 30.0, 
      color: Colors.green,
      tooltip: 'Parar de Oir',
      onPressed: () {
        cancelListening();
      }
    );
  }
  
  Widget _crearBotonReproducir() {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 12.0 ),
        child: Icon(
          Icons.play_arrow, 
          color: Colors.white,
          size: 40.0,
        )
      ),
      color: Colors.green, 
      onPressed: (){
        _texto = _textoCTRL.text;
        _speak( _texto, null );
      },
      shape: StadiumBorder(),
      textColor: Colors.white,
    );
  }
  Widget _crearBotonLimpiar() {
    return IconButton(
      icon: Icon( Icons.clear ),
      iconSize: 30.0, 
      color: Colors.green,
      tooltip: 'Empezar a Oir',
      onPressed: () {
        _texto = '';
        _textoCTRL.text = _texto;
        _strLogg = '';
        setState(() {  });
      }
    );
  }
  Widget _crearBotonInicializar() {
    return IconButton(
      icon: Icon( Icons.speaker_phone ),
      iconSize: 30.0, 
      color: Colors.green,
      tooltip: 'Inicializar',
      onPressed: () {
        initTodo();
      }
    );
  }

  // ******************************************************************
  void startOir() {
    print('++++++++++++++++ startOir() ++++++++++++++++');
    log('++++++++++++++++ startOir() ++++++++++++++++');
    
    _finalResult = false;

    yb.estado = 'OYENDO';

    _texto = "";
    speech.listen(
      onResult: resultListener,
      //listenFor: Duration(seconds: 5),
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      partialResults: true
    );
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    statusListener('Cancelado');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void soundLevelListener(double level) {
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    print('Error ==> ');
    print("${error.errorMsg} - ${error.permanent}");
    print(error);
    log('Error ==>');
    print(error.errorMsg);

    _estado = "${error.errorMsg} - ${error.permanent}";

    setState(() {  });
  }

  void statusListener(String status) {
    
    switch( status ){
      case 'listening':
        _estado = 'Oyendo'; break;
      case 'notListening':
        _estado = 'No Oyendo'; break;
      case 'Hablando':
        _estado = 'Hablando'; break;
      case 'No hablando':
        _estado = 'No hablando'; break;
    }
    
    setState(() {  });
  }

  void resultListener(SpeechRecognitionResult result) {
    _finalResult = result.finalResult;
    _texto = "${result.recognizedWords}";
    _textoCTRL.text = _texto;
    setState(() {  });

    if( _finalResult ){
      log('Termina de oir -> yb.buscandoMando( texto )');
      try {
        yb.buscandoMando( _texto );
      } catch (e) {
        print( e.toString() );
        log( e.toString() );
      }
    }
  }

  Widget _crearCampoTexto(){
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),

      child: TextField(
        controller: _textoCTRL,
        maxLines: 4,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color:Colors.green
            )
          ),

          labelText: 'Decir',
          labelStyle: TextStyle( color: Colors.green ),
          icon: Icon( Icons.message , color: Colors.green ),
          //Derecha
          //suffixIcon: Icon(Icons.accessibility)
        ),
        onChanged: (valor){
          _texto = valor;
        },
      )
    );
  }

  // ********************************************************************
  Future _speak( String _texto, dynamic mando ) async {
    print("\nInicia Hablar........................................");
    log("\nInicia Hablar........................................");
    print('-> Dira ====> $_texto');

    statusListener('Hablando');
    yb.mando = mando; // Puede venir NULL

    //await flutterTts.setLanguage("es-ES");
    await flutterTts.setLanguage("es-US");

    await flutterTts.setSpeechRate( _rate );
    await flutterTts.setVolume( _volume );
    await flutterTts.setPitch( _pitch );
    await flutterTts.isLanguageAvailable("es-ES");

    var result = await flutterTts.speak( _texto );

  }
  
  // *******************************************************************
  

  void _continuarDespuesDeHablar(){
    print("\n --> DespuesDeHablar........................................");
    log("--> DespuesDeHablar........................................");

    if( yb.mando == null ){ // Viene de Reproducir Texto Manualmente
      // No hacer nada.. volver estado inicial
      print('--> => NO hay mando');
      yb.accion = '';

    }
    else if( yb.mando['ejecutar'] ){ // Si Finaliza..pide algo mas
      print('--> => "ejecutar"');

      yb.ejecutaMando();
    }
    else if( yb.mando['oir'] ){ // Inicia Oir para capturar variables
      print('--> => "oir", accion: ${yb.accion}');
      print(yb.mando);

      if( yb.mando['accion'] == 'algo_mas' ){
        yb.mando['accion'] = '';
      }

      startOir( );
    }
    else if( yb.mando['finalizar'] ){ // Si Finaliza..pide algo mas
      print('--> => "finaliza"');

      yb.ejecutaMando();
    }
    else{ // Termina Todo
      print('--> => "Termina TODO ???"');

      if( yb.pideMas ){
          yb.mando = yb.clonarMando( yb.mandos.elementAt(0) ); // algo_mas
          yb.accion = yb.mando['accion'];

          yb.ejecutaMando();
      }
    }
  }


}