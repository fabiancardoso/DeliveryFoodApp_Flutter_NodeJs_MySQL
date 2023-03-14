import 'package:adminapp/Screens/productsScreen/productosEnStock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen(
      {super.key,
      required this.name,
      required this.price,
      required this.imageName,
      required this.id});
  final String imageName;
  final String name;
  final double price;
  final int id;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {
  String name = '';
  double price = 0;
  double textFieldPriceWidth = 0;
  double textFieldNameWidth = 0;
  bool textfieldNameExtended = false;
  bool textFieldPriceExtended = false;
  List<String> offers = [
    'Envio gratis',
    'Porcentaje de descuento',
    'Cantidad especifica',
    'Sin oferta'
  ];
  String offerSelected = 'Sin oferta';
  double _porcentajeTextWidth = 0;
  double porcentaje = 0;

  Future<void> updatePrice() async {
    Dio dio = Dio();

    FormData formdata = FormData.fromMap({
      'price': price,
      'id': widget.id,
      'offer': offerSelected,
      'porcentaje': porcentaje
    });
    final prefs = await SharedPreferences.getInstance();

    var tkn = prefs.getString('token') ?? 0;
    if (tkn != 0) {
      String token = tkn.toString();

      var response = await dio.put('http://192.168.1.28:3200/products',
          data: formdata,
          options: Options(headers: <String, dynamic>{
            'Content-Type': 'application/json; charset=utf-8',
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 201) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const App(pag: 1),
            ));
      }
    }
  }

  @override
  void initState() {
    name = widget.name;
    price = widget.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 222, 222),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.black),
                margin: const EdgeInsets.fromLTRB(130, 150, 0, 0),
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.network(
                      'http://192.168.1.28:3200/images/${widget.imageName}',
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(70, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(90, 10, 0, 0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (textFieldPriceExtended) {
                              textFieldPriceWidth = 0;
                              textFieldPriceExtended = false;
                            } else {
                              textFieldPriceWidth = 70;
                              textFieldPriceExtended = true;
                            }
                          });
                        },
                        icon: const Icon(Icons.edit)),
                    AnimatedContainer(
                      margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                      width: textFieldPriceWidth,
                      duration: const Duration(milliseconds: 300),
                      child: CupertinoTextField(
                        placeholder: 'Price',
                        onChanged: (String value) {
                          setState(() {
                            price = double.parse(value);
                          });
                        },
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ])),
              Text(
                '\$ ${price.toString()}',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 25,
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 43, 118),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: const Color.fromARGB(255, 63, 43, 118),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  menuMaxHeight: 200,
                  iconEnabledColor: Colors.white,
                  items: offers.map((String a) {
                    return DropdownMenuItem(value: a, child: Text(a));
                  }).toList(),
                  hint: Text(
                    '    $offerSelected',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.toString() == 'Porcentaje de descuento') {
                      setState(() {
                        _porcentajeTextWidth = 100;
                      });
                    } else {
                      setState(() {
                        _porcentajeTextWidth = 0;
                      });
                    }
                    setState(() {
                      offerSelected = value.toString();
                    });
                  }),
            ),
            AnimatedContainer(
              margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              width: _porcentajeTextWidth,
              duration: const Duration(milliseconds: 200),
              child: CupertinoTextField(
                placeholder: 'Porcentaje',
                onChanged: (String value) {
                  setState(() {
                    porcentaje = double.parse(value);
                  });
                },
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ])),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 270,
                    child: ElevatedButton(
                      onPressed: updatePrice,
                      child: const Text('Update Product'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 63, 43, 118)),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
