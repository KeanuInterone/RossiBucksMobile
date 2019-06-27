import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rossi_bucks/screens/scan_screen.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:rossi_bucks/screens/loading_screen.dart';


List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(
    MaterialApp(
      title: "Rossi Bucks",
      home: LoadingScreen(),
    ),
  );
}

