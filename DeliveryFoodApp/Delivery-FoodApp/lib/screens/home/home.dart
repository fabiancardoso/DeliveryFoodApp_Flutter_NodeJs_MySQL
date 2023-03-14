import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../productos_ultimamente_vistos.dart';
import '../../productos_mas_vistos.dart';
import '../../drawer/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../productScreen.dart';
import 'dart:async';
import 'dart:convert';
import '../../producto.dart';
import '../../Ofertas.dart';
import 'searchProductBox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _width = 200;
  double _height = 0;
  bool listExpanded = false;

  List<Product> data = [];
  Future<List<Product>> searchProducts(String param) async {
    var url = 'http://192.168.1.28:3200/products/search';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'params': param,
        }));
    var datos = jsonDecode(response.body);

    List<Product> registros = [];

    for (datos in datos) {
      registros.add(Product.fromJson(datos));
    }
    return registros;
  }

  void expandList() {
    setState(() {
      _height = 500;
      listExpanded = true;
    });
  }

  void reduceList() {
    setState(() {
      if (listExpanded) {
        _height = 0;
        listExpanded = false;
      }
    });
  }

  void search(String param) {
    searchProducts(param).then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: reduceList,
        child: Scaffold(
            appBar: AppBar(
              title: CupertinoSearchTextField(
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
                onChanged: (String value) {
                  setState(() {
                    data.clear();
                  });
                  search(value);
                  expandList();
                },
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 116, 90, 187),
            ),
            drawer: const MyDrawer(),
            body: ListView(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _width,
                  height: _height,
                  color: Colors.white,
                  child: CustomScrollView(slivers: [
                    SliverFixedExtentList(
                      itemExtent: 50.0,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                            name: data[index].name,
                                            price: data[index].precio,
                                            id: data[index].id,
                                            imageName: data[index].imageName,
                                          )));
                            },
                            child: SearchProductBox(
                              name: data[index].name,
                              imageName: data[index].imageName,
                            ),
                          );
                        },
                        childCount: data.length,
                      ),
                    ),
                  ]),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).vistosUltimamente,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                const ProductosUltimamenteVistos(),
                const Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).productosMasVistos,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                const ProductosMasVistos(),
                const Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                Container(
                  width: 200,
                  margin: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).ofertas,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                const Ofertas(),
              ],
            )));
  }
}
