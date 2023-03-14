import 'package:flutter/material.dart';
import 'package:myapp/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../box_product.dart';
import '../../producto.dart';
import 'CategoryProductBox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreen();
}

class _CategoryScreen extends State<CategoryScreen> {
  List<Product> data = [];
  List<String> category = [
    'Pizzas',
    'Burgers',
    'Beverages',
    'Dishes',
    'Potatoes'
  ];
  List<bool> categorySelected = [false, false, false, false, false];

  List<String> locations = [
    'images/categories_icons/Pizzas_icon.png',
    'images/categories_icons/Burgers_icon.png',
    'images/categories_icons/Beverages_icon.png',
    'images/categories_icons/Dishes_icon.png',
    'images/categories_icons/Potatoes_icon.png'
  ];
  String categoryName = 'Pizzas';

  Future<List<Product>> getCategory() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/products/category';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode(<String, String>{
          'category': categoryName,
        }));
    var datos = jsonDecode(response.body);

    List<Product> registros = [];

    for (datos in datos) {
      registros.add(Product.fromJson(datos));
    }
    return registros;
  }

  @override
  void initState() {
    super.initState();
    getCategory().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 116, 90, 187),
          title: Text(AppLocalizations.of(context).categorias),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 222, 233),
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            for (int i = 0; i < category.length; i++) {
                              if (i == index) {
                                setState(() {
                                  categorySelected[i] = true;
                                });
                              } else {
                                setState(() {
                                  categorySelected[i] = false;
                                });
                              }
                            }

                            categoryName = category[index];
                            data.clear();
                            getCategory().then((value) {
                              setState(
                                () {
                                  data.addAll(value);
                                },
                              );
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CategoryProductBox(
                                name: category[index],
                                imageLocation: locations[index],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: categorySelected[index]
                                    ? const Color.fromARGB(255, 173, 157, 215)
                                    : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15)  
                                ),
                                width: 40,
                                height: 4,
                              )
                            ],
                          ));
                    },
                  )),
            ),
            Container(
              color: const Color.fromARGB(255, 226, 222, 233),
              width: 320,
              height: data.length * 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductBox(
                    name: data[index].name,
                    price: data[index].precio,
                    id: data[index].id,
                    imageName: data[index].imageName,
                    descuento: data[index].descuento,
                    offerType: data[index].offerType,
                    imageHeight: 50,
                    imageWidth: 200,
                  );
                },
                itemCount: data.length,
              ),
            )
          ],
        ));
  }
}
