import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './box_product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './producto.dart';

class ProductosUltimamenteVistos extends StatefulWidget {
  const ProductosUltimamenteVistos({super.key});

  @override
  State<ProductosUltimamenteVistos> createState() =>
      _ProductosUltimamenteVistos();
}

class _ProductosUltimamenteVistos
    extends State<ProductosUltimamenteVistos> {
  List<Product> data = [];
  Future<List<Product>> getProductos() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/users/productosUltimamenteVistos';
    var response = await http.get(Uri.parse(url),
        headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $token',
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
      
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 239, 236, 246),
      ),
      child: SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductBox(
                name: data[index].name,
                price: data[index].precio,
                id: data[index].id,
                imageName: data[index].imageName,
                offerType: data[index].offerType,
                descuento: data[index].descuento,
                imageHeight: 60,
                imageWidth: 120,
              );
            },
          )),
    );
  }
}
