import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Product {
  String id;
  String name;
  String ean;
  int points;
  String brandID;

  Product({this.id, this.name, this.ean, this.points, this.brandID});

  Product.fromJson(Map productJson) {
    this.id = productJson["id"].toString();
    this.name = productJson["name"];
    this.ean = productJson["ean"];
    this.points = productJson["points"];
    this.brandID = productJson["brand_id"];
  }

  static List<Product> products;
  static Map<String, Product> eanDict;

  static Future<List<Product>> getAllProducts({bool setStaticVariables = false}) async {
    String url = "https://rossi-bucks.herokuapp.com/api/products";
    var response = await http.get(url);
    if (response.statusCode != 200) {
      return null;
    }
    List productsJson = json.decode(response.body);
    List<Product> productList = List();
    if (setStaticVariables) {
      eanDict = Map();
      products = List();
    }
    for (Map productJson in productsJson) {
      Product product = Product.fromJson(productJson);
      if (setStaticVariables) {
        eanDict[product.ean] = product;
        products.add(product);
      }
      productList.add(product);
    }

    return productList;
  }
}