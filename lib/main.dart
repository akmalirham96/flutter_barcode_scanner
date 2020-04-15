import 'package:flutter/material.dart';
import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "Hey";

  Future _scanQR() async{
    try{
      String qrResult = await BarcodeScanner.scan();
      setState(() {
          result = qrResult;
      });
    }on PlatformException catch (ex){
      if(ex.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          result = "Camera permission was denied";
        });
      }else{
        setState(() {
          result = "Error $ex";
        });
      }
    } on FormatException{
      setState(() {
        result = "You press back button before scan";
      });
    } catch (ex){
      setState(() {
        result = "Error $ex";
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
      ), 
      body: Center(
        child: Text(result),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt), 
          onPressed: _scanQR,
          label: Text("Scanner")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
