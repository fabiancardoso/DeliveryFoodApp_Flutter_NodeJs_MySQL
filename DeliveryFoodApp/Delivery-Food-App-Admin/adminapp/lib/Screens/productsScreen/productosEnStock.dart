import 'package:flutter/material.dart';
import 'box_product.dart';
import 'producto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductosEnStock extends StatefulWidget {
  const ProductosEnStock({super.key});
  @override
  State<ProductosEnStock> createState() => _ProductosEnStock();
}

class _ProductosEnStock extends State<ProductosEnStock> {
  List<Product> data = [];
  Future<List<Product>> getProductos() async {
    var url = 'http://192.168.1.28:3200/admin/products/';
    var response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 90));
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
      height: 550,
      margin: const EdgeInsets.all(10),
      child: SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              
              return ProductBox(
                name: data[index].name,
                price: data[index].precio,
                id: data[index].id,
                imageName: data[index].imageName,
              );
            },
          )),
    );
  }
}
