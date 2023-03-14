import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../generated/l10n.dart';

class OrderBox extends StatefulWidget {
  const OrderBox(
      {super.key,
      required this.orderId,
      required this.productName,
      required this.imageName,
      required this.cantidad,
      required this.montoTotal,
      required this.status});
  final String productName;
  final String status;
  final int orderId;
  final String imageName;
  final int cantidad;
  final double montoTotal;
  @override
  State<OrderBox> createState() => _OrderBox();
}

class _OrderBox extends State<OrderBox> {
  String status = '';
  bool confirmedDelivery = false;
  void confirmDelivery() async {
    if (status == 'En camino') {
      final prefs = await SharedPreferences.getInstance();
      String? tkn = prefs.getString('token');
      String token = tkn.toString();

      var response =
          await http.post(Uri.parse('http://192.168.1.28:3200/users/order'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode({'order': widget.orderId}));
     
      if (response.statusCode == 200) {
        setState(() {
          status = 'Delivered product';
          confirmedDelivery = true;
        });
      }
    }
  }

  @override
  void initState() {
    setState(() {
      status = widget.status;
      if (status == 'Delivered product') {
        confirmedDelivery = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      child: Container(
        width: 300,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 378,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://192.168.1.28:3200/images/${widget.imageName}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                Text(
                  widget.productName,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w900),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 60, 0)),
                  Text(
                  status,
                  style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700),
                ),
                
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                Text(
                  '${AppLocalizations.of(context).total}  \$ ${widget.montoTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Text(
                  '${AppLocalizations.of(context).cantidad} ${widget.cantidad.toString()}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                Container(
                  child: confirmedDelivery
                      ? null
                      : ElevatedButton(
                          onPressed: confirmDelivery,
                          child: Text(AppLocalizations.of(context).confirmarEntrega),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 63, 43, 118),
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
