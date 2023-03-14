import 'package:flutter/material.dart';
import './order.dart';
import './orderCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderList();
}

class _OrderList extends State<OrderList> {
  List<Order> data = [];
  double _height = 0;

  Future<List<Order>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var tkn = prefs.getString('token');

    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/orders';
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    });
    var datos = jsonDecode(response.body);
    List<Order> registros = [];
    for (datos in datos) {
      registros.add(Order.fromJson(datos));
    }
    return registros;
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getOrders().then((value) {
      setState(() {
        data.addAll(value);
      });
    });

    if (data.isEmpty) {
      setState(() {
        _height = 400;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _height,
      width: 270,
      margin: const EdgeInsets.all(10),
      child: SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(
                  client: data[index].client,
                  id: data[index].id,
                  imageName: data[index].imageName,
                  address: data[index].address,
                  amount: data[index].amount,
                  status: data[index].status,
                  price: data[index].price);
            },
          )),
    );
  }
}
