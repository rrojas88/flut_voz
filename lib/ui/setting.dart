import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key key, this.configHabla }) : super(key: key);

  //double rate;
  //double volume;
  //double pitch;
  Function configHabla;


  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  double _rate = 0.5;
  double _volume = 1.0;
  double _pitch = 1.0;

  double get rate => _rate;
  double get volume => _volume;
  double get pitch => _pitch;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
       child: Center(
         child: Column(
           children: <Widget>[
              SizedBox( height: 70.0 ),
              Text('Configuración de Voz',
              style: TextStyle( fontWeight: FontWeight.bold),
              ),
              SizedBox( height: 40.0 ),
              _crearSliderRate(),
              Text('Rate: $_rate'),
              SizedBox( height: 20.0 ),
              _crearSliderPitch(),
              Text('Pitch: $_pitch'),
              SizedBox( height: 20.0 ),
              _crearSliderVolume(),
              Text('Volume: $_volume'),
              SizedBox( height: 20.0 ),
           ],
         ),
       ),
    );
  }

  Widget _crearSliderRate() {
    return Slider(
      activeColor: Colors.green,
      label: _rate.toString(),
      divisions: 10,
      value: _rate,
      min: 0.0,
      max: 1.0,
      onChanged: (valor){ 
        widget.configHabla(valor, _pitch, _volume);
        _rate = valor;
        setState(() {  }); 
      }
    );
  }
  Widget _crearSliderPitch() {
    return Slider(
      activeColor: Colors.green,
      label: _pitch.toString(),
      divisions: 10,
      value: _pitch,
      min: 0.5,
      max: 2.0,
      onChanged: (valor){ 
        widget.configHabla(_rate, valor, _volume);
        _pitch = valor;
        setState(() {  }); 
      }
    );
  }
  Widget _crearSliderVolume() {
    return Slider(
      activeColor: Colors.green,
      label: _volume.toString(),
      divisions: 10,
      value: _volume,
      min: 0.0,
      max: 1.0,
      onChanged: (valor){
        widget.configHabla(_rate, _pitch, valor);
        _volume = valor;
        setState(() {  }); 
      }
    );
  }



}