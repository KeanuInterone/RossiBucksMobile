import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rossi_bucks/main.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:rossi_bucks/models/product.dart';
import 'package:rossi_bucks/screens/review_order_screen.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanScreenState();
  }
}

class ScanScreenState extends State<ScanScreen> {
  QRReaderController controller;
  List<String> codes = [];
  List<Product> products = [];
  AudioCache player;
  String scanSound = "scan_sound.mp3";

  @override
  void initState() {
    super.initState();
    player = new AudioCache();
    controller = QRReaderController(
        cameras[0], ResolutionPreset.medium, CodeFormat.values,
        (dynamic value) {
      print(value);
      player.play(scanSound);

      _addProductWithValue(value);

      Future.delayed(const Duration(seconds: 1), controller.startScanning);
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool controllerInitialized = controller.value.isInitialized;

    if (!controllerInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 36, 34, 1),
        title: Text("Scan"),
      ),
      body: Stack(
        children: <Widget>[
          QRReaderPreview(controller),
          ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return Text(
                "${product.name} +${product.points.toString()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            height: 80,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewOrderScreen(
                          products: products,
                        ),
                  ),
                );
              },
              child: Text(
                "REVIEW ORDER",
                style: TextStyle(color: Colors.white),
              ),
              color: Color.fromRGBO(231, 36, 34, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  void _addProductWithValue(String ean) {
    Product product = Product.eanDict[ean];
    if (product != null) {
      products.add(product);
      setState(() {});
    }
  }
}
