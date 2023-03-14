import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'orders/orderList.dart';
import 'salesDataWidget/SalesData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int cantidadDeVentas = 0;
  double montoTotal = 0;
  String username = '';
  void consultarCantidadVentas() async {
    final prefs = await SharedPreferences.getInstance();

    var tkn = prefs.getString('token');

    String token = tkn.toString();

    var response = await http.get(
      Uri.parse('http://192.168.1.28:3200/totalDeVentas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        cantidadDeVentas = datos['cantidadDeVentas'];
        montoTotal = datos['montoTotal'].toDouble();
      });
    }
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('username');

    setState(() {
      username = user.toString();
    });
  }

  @override
  void initState() {
    setState(() {
      loadData();
      consultarCantidadVentas();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 116, 90, 187),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
            Center(
                child: Text('Hello $username!',
                    style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic))),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Center(
                    child: cantidadDeVentas > 0
                        ? Text(
                            'TaskList',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        : null,
                  ),
                  const OrderList(),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  SalesData(cantidadDeVentas: cantidadDeVentas, montoTotal: montoTotal)
                ],
              ),
            ),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        consultarCantidadVentas();
                      });
                    },
                    child: const Text('Update data'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 63, 43, 118)),
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
