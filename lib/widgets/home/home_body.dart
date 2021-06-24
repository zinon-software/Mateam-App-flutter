import 'package:app_flutter_api/screens/DetailPage.dart';
import 'package:app_flutter_api/screens/HomePage.dart';
import 'package:app_flutter_api/widgets/home/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_api/static/constants.dart';
import 'package:app_flutter_api/models/productsModel.dart';
import 'package:app_flutter_api/models/fetchApi.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FetchApi fetchApi = FetchApi();

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (a, b, c) => HomePage(),
                        transitionDuration: Duration(seconds: 1),
                      ),
                    );
                    return Future.value(false);
                  },
                  child: FutureBuilder(
                      future: fetchApi.fetchProducts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List<ProductsModel> products = snapshot.data;
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) => ProductCard(
                              itemIndex: index,
                              product: products[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      product: products[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
