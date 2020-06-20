import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_barcode_scanner/web_screen.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('QRCode Scanner'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 25),
                padding: EdgeInsets.all(8),
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent[400],
                ),
                child: FlatButton(
                  child: Text('Scan QR Code', style: TextStyle(fontSize: 20, color: Colors.black),),
                  onPressed: () async {
                    try {
                      String barcode = await BarcodeScanner.scan();
                      setState(() {
                        this.barcode = barcode;
                      });
                    } on PlatformException catch (error) {
                      if (error.code == BarcodeScanner.CameraAccessDenied) {
                        setState(() {
                          this.barcode = 'Izin kamera tidak diizinkan oleh si pengguna';
                        });
                      } else {
                        setState(() {
                          this.barcode = 'Error: $error';
                        });
                      }
                  }
                },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: EdgeInsets.all(8),
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.orange[700],
                ),
                child: FlatButton(
                child: Text('Buka : $barcode',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                onPressed: barcode == ""
                ? () {}
                : (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebScreen(barcode),
                    ),
                  );
                },),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            //color: Colors.transparent,
            child: Container(
              height: 60,
              color: Colors.blue[900],
              alignment: Alignment.center,
              child: Text(
                'Pemrograman Mobile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            //elevation: 0,
          ),
      ),
    );
  }
}