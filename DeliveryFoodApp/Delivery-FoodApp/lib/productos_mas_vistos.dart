import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/box_product.dart';
import 'package:myapp/producto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductosMasVistos extends StatefulWidget {
  const ProductosMasVistos({super.key});

  @override
  State<ProductosMasVistos> createState() => _ProductosMasVistos();
}

class _ProductosMasVistos extends State<ProductosMasVistos> {
  List<Product> data = [];
  Future<List<Product>> getProductos() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();

    var url = 'http://192.168.1.28:3200/users/productosMasVistos';
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': "Bearer $token",
    });
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
    getProductos().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 239, 236, 246),
        ),
        height: 400,
        width: 300,
        margin: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductBox(
                    name: data[index].name,
                    price: data[index].precio,
                    id: data[index].id,
                    imageName: data[index].imageName,
                    offerType: data[index].offerType,
                    descuento: data[index].descuento,
                    imageHeight: 100,
                    imageWidth: 350,
                  );
                },
              )),
        ]));
  }
}
