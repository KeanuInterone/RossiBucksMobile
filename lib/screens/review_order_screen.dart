import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rossi_bucks/models/product.dart';
import 'package:flutter/foundation.dart';

class ReviewOrderScreen extends StatefulWidget {
  List<Product> products;

  ReviewOrderScreen({@required this.products});

  @override
  State<StatefulWidget> createState() {
    return ReviewOrderScreenState(products: products);
  }
}

class ReviewOrderScreenState extends State<ReviewOrderScreen> {
  List<Product> products;

  ReviewOrderScreenState({@required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 36, 34, 1),
        title: Text("Review Order"),
      ),
      body: Stack(
        children: <Widget>[
          ListView.separated(
            padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 120),
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.name),
                    Text("+${product.points}")
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            height: 80,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "SUBMIT ORDER",
                style: TextStyle(color: Colors.white),
              ),
              color: Color.fromRGBO(231, 36, 34, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
