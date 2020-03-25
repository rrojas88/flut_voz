import 'package:flutter/material.dart';

import 'package:flut_voz/ui/index.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Material App Bar'),
        ),*/
        body: Home(),
      ),
    );
  }
}
