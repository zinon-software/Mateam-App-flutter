import 'package:app_flutter_api/models/productsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class FetchApi {
  Future<List<ProductsModel>> fetchProducts() async {
    http.Response response =
        await http.get(Uri.parse("https://mateamm.herokuapp.com/api/v2/products"));

    if (response.statusCode == 200) {
      var body = jsonDecode(utf8.decode(response.bodyBytes));

      List<ProductsModel> product = [];

      for (var item in body) {
        product.add(ProductsModel.fromJson(item));
      }
      return product;
    }
    return null;
  }
}
