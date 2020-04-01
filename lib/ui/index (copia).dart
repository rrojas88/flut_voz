import 'package:flutter/material.dart';

import 'dart:async';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  String _estado = 'Inicial';
  String _texto = '..nada aún';

  // ************************
  //bool _hasSpeech = false;
  double level = 0.0;
  String lastStatus = "";
  String _currentLocaleId = "";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();


  @override
  initState() {
    super.initState();
    //activateSpeechRecognizer();
    initSpeechState();
  }

  void activateSpeechRecognizer() {
    print('*** Inicializada App... ');
  }
  Future<void> initSpeechState() async {
    print('*** Inicializada App ... ');
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;

      print('_currentLocaleId === $_currentLocaleId');
    }

    if (!mounted) return;

    setState(() {
      //_hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voz'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.greenAccent,
      body: Container(
        padding: EdgeInsets.only( top: 40.0 ),
        child: Column(
          children: <Widget>[
            _crearBotonPlay(),
            Divider( height: 50.0 ),
            _crearBotonCancelar(),
            SizedBox( height: 16.0 ),
            Text(
              'Estado: $_estado',
              style: TextStyle( fontWeight: FontWeight.bold )
            ),
            Divider( height: 30.0 ),
            _crearBotonLimpiar(),
            SizedBox( height: 16.0 ),
            Text('Has dicho:'),
            SizedBox( height: 30.0 ),
            Text( _texto,
              style: TextStyle( fontWeight: FontWeight.bold )
            )
          ],
        ),  
      ),
    );
  }

  Widget _crearBotonPlay() {
    return IconButton(
      icon: Icon(Icons.mic),
      iconSize: 36.0,
      tooltip: 'Empezar a Oir',
      onPressed: () {
        start();        
      }
    );
  }

  Widget _crearBotonCancelar() {
    return IconButton(
      icon: Icon( Icons.mic_off ),
      iconSize: 30.0, 
      tooltip: 'Empezar a Oir',
      onPressed: () {
        cancelListening();
      }
    );
  }
  Widget _crearBotonLimpiar() {
    return IconButton(
      icon: Icon( Icons.clear ),
      iconSize: 30.0, 
      tooltip: 'Empezar a Oir',
      onPressed: () {
        setState(() {
          _texto = '';
        });
      }
    );
  }

  // ******************************************************************
  void start() {
    print('++++++++++++++++ startListening() ++++++++++++++++');
    print('_currentLocaleId= $_currentLocaleId');
    statusListener('Iniciando..');

    _texto = "";
    speech.listen(
        onResult: resultListener,
        //listenFor: Duration(seconds: 5),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
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

    _estado = "${error.errorMsg} - ${error.permanent}";

    setState(() {  });
  }

  void statusListener(String status) {
    print('Estado = $status');
    //changeStatusForStress(status);
    setState(() {
      _estado = "$status";
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    statusListener('Final');
    print('++++ Finalizo de oir...');

    setState(() {
      _texto = "${result.recognizedWords} - finalResult:${result.finalResult}";
    });
  }


}