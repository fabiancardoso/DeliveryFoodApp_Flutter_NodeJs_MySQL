import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/producto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'box_product.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _Ofertas();
}

class _Ofertas extends State<Ofertas> {
  List<Product> data = [];
  Future<List<Product>> getProductos() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/products/sales';
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
           width: 320,
           height: data.length * 300,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
             maxCrossAxisExtent: 200,
             childAspectRatio: 3/2,

            ),
            itemBuilder: 
              (BuildContext context, int index) {
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
          
          




    );
  }
}
