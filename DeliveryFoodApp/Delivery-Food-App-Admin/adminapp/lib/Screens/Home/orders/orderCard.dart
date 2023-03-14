import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderCard extends StatefulWidget {
  const OrderCard(
      {super.key,
      required this.address,
      required this.client,
      required this.amount,
      required this.id,
      required this.status,
      required this.imageName,
      required this.price});
  final String address;
  final String client;
  final int amount;
  final int id;
  final double price;
  final String imageName;
  final String status;

  @override
  State<OrderCard> createState() => _OrderCard();
}

class _OrderCard extends State<OrderCard> {
  bool envioConfirmado = false;

  void toConfirmOrder() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();

    var response =
        await http.post(Uri.parse('http://192.168.1.28:3200/orders/confirm'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode({'orderId': widget.id}));

    if (response.statusCode == 200) {
      setState(() {
        envioConfirmado = true;
      });
    }
  }

  @override
  void initState() {
    if (widget.status == 'Delivered product') {
      envioConfirmado = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 200,
      decoration:const BoxDecoration(
        color: Color.fromARGB(255, 239, 236, 246),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60), topRight: Radius.circular(5)),
            child: Image.network(
                width: 270,
                height: 90,
                'http://192.168.1.28:3200/images/${widget.imageName}',
                fit: BoxFit.fill),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text('\$${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text(
                      widget.client,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                    child: Text(
                      widget.address,
                      style:
                          const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(42, 8, 0, 2),
                      child: Text(
                        widget.amount.toString(),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  width: 150,
                  height: 30,
                  child: envioConfirmado
                      ? const Icon(Icons.check)
                      : ElevatedButton(
                          onPressed: toConfirmOrder,
                          child: const Text('Confirmar envio'))),
            ],
          ),
        ],
      ),
    );
  }
}
