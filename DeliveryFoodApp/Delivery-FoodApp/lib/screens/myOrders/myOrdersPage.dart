import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/screens/myOrders/order.dart';
import '../../generated/l10n.dart';
import './orderBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPage();
}

class _MyOrdersPage extends State<MyOrdersPage> {
  List<Order> data = [];
  Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();

    var response = await http.get(
        Uri.parse('http://192.168.1.28:3200/users/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': "Bearer $token",
        });

    var datos = jsonDecode(response.body);

    List<Order> registros = [];

    for (datos in datos) {
      registros.add(Order.fromJson(datos));
    }
    return registros;
  }

  @override
  void initState() {
    getOrders().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).misPedidos),
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          
          return OrderBox(
            productName: data[index].productName,
            orderId: data[index].orderId,
            status: data[index].status,
            imageName: data[index].imageName,
            montoTotal: data[index].montoTotal,
            cantidad: data[index].cantidad,
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
