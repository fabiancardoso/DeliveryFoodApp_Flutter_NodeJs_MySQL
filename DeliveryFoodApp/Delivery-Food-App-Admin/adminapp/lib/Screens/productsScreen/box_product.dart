import 'package:flutter/material.dart';
import './updateProductScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ProductBox extends StatefulWidget {
  const ProductBox(
      {super.key,
      required this.name,
      required this.price,
      required this.id,
      required this.imageName});
  final String name;
  final double price;
  final int id;
  final String imageName;
  @override
  State<ProductBox> createState() => _ProductBox();
}

class _ProductBox extends State<ProductBox> {
  int id = 0;
  void updateProduct() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateProductScreen(
            name: widget.name,
            price: widget.price,
            imageName: widget.imageName,
            id: widget.id,
          ),
        ));
  }

  void deleteProduct() async {
    final prefs = await SharedPreferences.getInstance();
    var tkn = prefs.getString('token');
    String token = tkn.toString();
    var response = await http.delete(
        Uri.parse('http://192.168.1.28:3200/products/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token'
        });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(255, 223, 222, 222),
        child: Container(
          width: 125,
          height: 170,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 238, 236, 236),
          ),
          child: Column(children: [
            Row(children: [
              Container(
                width: 100,
                height: 90,
                margin: const EdgeInsets.fromLTRB(30, 10, 0, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://192.168.1.28:3200/images/${widget.imageName}'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(150, 0, 0, 0),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: updateProduct, icon: const Icon(Icons.edit)),
                    Container(
                        child: IconButton(
                            onPressed: deleteProduct,
                            icon: const Icon(Icons.delete))),
                  ],
                ),
              ),
            ]),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    '\$ ${widget.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color.fromARGB(130, 130, 130, 130),
                  ),
                )
              ]),
            ),
          ]),
        ));
  }
}
