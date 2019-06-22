import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rossi_bucks/main.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:audioplayers/audio_cache.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanScreenState();
  }
}

class ScanScreenState extends State<ScanScreen> {
  QRReaderController controller;
  List<String> codes = [];
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
      codes.add(value.toString());
      setState(() {});
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
        title: Text("Scan"),
      ),
      body: Stack(
        children: <Widget>[
          QRReaderPreview(controller),
          ListView.builder(
            itemCount: codes.length,
            itemBuilder: (context, index) {
              return Text(
                codes[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
