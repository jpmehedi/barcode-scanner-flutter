import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String code = "Hey there !";

  Future _scanQR() async {
    try {
      var result = await BarcodeScanner.scan();

      setState(() {
        code = result.rawContent;
        print(result.type); // The result type (barcode, cancelled, failed)
        print(result.rawContent); // The barcode content
        print(result.format); // The barcode format (as enum)
        print(result.formatNote);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          code = "Camera permission was denied";
        });
      } else {
        setState(() {
          code = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        code = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        code = "Unknown Error $ex";
      });
    }
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Expanded(
            child: Linkify(
              onOpen: _onOpen,
              text: code,
              options: LinkifyOptions(humanize: false),
              linkStyle: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
