import 'package:flutter/material.dart';
import 'package:rossi_bucks/models/product.dart';
import 'package:rossi_bucks/screens/scan_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingScreenState();
  }
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Product.getAllProducts(setStaticVariables: true).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScanScreen(),
        ),
      );
    });

    return Container(
      color: Color.fromRGBO(231, 36, 34, 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/RossiLogo.png"),
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(44, 46, 64, 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
