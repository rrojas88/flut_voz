import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  Setting({Key key, this.configGeneral }) : super(key: key);

  Function configGeneral;


  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  double _rate = 0.5;
  double _volume = 1.0;
  double _pitch = 1.0;
  bool _debugger = false;

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
              _crearSwitchDebugger()
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
        widget.configGeneral(valor, _pitch, _volume, _debugger);
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
        widget.configGeneral(_rate, valor, _volume, _debugger);
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
        widget.configGeneral(_rate, _pitch, valor, _debugger);
        _volume = valor;
        setState(() {  }); 
      }
    );
  }

  Widget _crearSwitchDebugger() {
    return SwitchListTile(
      title: Text('Depurar'),
      value: _debugger, 
      onChanged: ( valor ){
        widget.configGeneral(_rate, _pitch, _volume, valor);
        _debugger = valor; 
        setState(() { });
      }
    );

  }


}