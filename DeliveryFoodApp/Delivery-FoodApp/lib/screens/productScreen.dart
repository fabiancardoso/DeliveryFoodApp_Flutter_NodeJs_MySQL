import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'myProfile/myaddress/address.dart';
import './succesFulPurchasedScreen.dart';
import 'package:myapp/generated/l10n.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(
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
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  int cantidad = 1;
  double animatedContainerWidth = 0;
  double animatedContainerHeight = 0;
  List<String> addresses = [];
  String addressSelected = 'Address';
  List<Address> data = [];

  void comprar() async {
    if (addressSelected != 'Address') {
      final prefs = await SharedPreferences.getInstance();

      var tkn = prefs.getString('token') ?? 0;
      String token = tkn.toString();

      var futureId = prefs.getInt('id') ?? 0;

      int myId = futureId;

      var _compra = {
        'user_id': myId,
        'product_id': widget.id,
        'cantidad': cantidad,
        'address': addressSelected,
      };
      if (myId > 0) {
        var response =
            await http.post(Uri.parse('http://192.168.1.28:3200/products/buy'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=utf-8',
                  HttpHeaders.authorizationHeader: "Bearer $token" ,
                },
                body: jsonEncode(_compra));

        if (response.statusCode == 201) {
          
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessFulPurchasedScreen(),
              ));
        }
      }
    } else {
      setState(() {
        animatedContainerWidth = 200;
        animatedContainerHeight = 15;
      });
    }
  }

  void sendVisit() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/users/productVisited';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode({'product_id': widget.id}));
  }

  Future<List<Address>> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
    var url = 'http://192.168.1.28:3200/users/address';
    var response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $token',
    });
    var datos = jsonDecode(response.body);
    List<Address> registros = [];
    for (datos in datos) {
      registros.add(Address.fromJson(datos));
    }
    return registros;
  }

  @override
  void initState() {
    getAddress().then((value) {
      setState(() {
        data.addAll(value);
      });
    });

    super.initState();
    sendVisit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(
              255,
              153,
              130,
              217,
            ),
            title: Text(AppLocalizations.of(context).producto),
            centerTitle: true,
            ),
            
        body: Container( 
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage('http://192.168.1.28:3200/images/${widget.imageName}'),
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              )),
          child:  ListView(children: [
             const Padding(padding: EdgeInsets.fromLTRB(0, 180, 0, 0)),
          Container(
            decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(170, 40),
                    ),
            ), 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Container(
                      margin: const EdgeInsets.fromLTRB(220, 0, 0, 0),
                      child: Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),
                 Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (cantidad > 1) {
                          setState(() {
                            cantidad--;
                          });
                        }
                      },
                      child: Center (child: Text('-',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800
                        ),
                      ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          153,
                          130,
                          217,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )),
                ),
                Center(
                  child: Text('$cantidad',
                     style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700
                        ),
                  ),
                ),
                Container(
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cantidad++;
                      });
                    },
                    child: Center(child: const Text('+',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800
                        ),
                  
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        153,
                        130,
                        217,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                child: ElevatedButton(
                  onPressed: comprar,
                  child: Text(AppLocalizations.of(context).comprar),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      153,
                      130,
                      217,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ),
              Container(
                  height: 25,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        153,
                        130,
                        217,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                      borderRadius: BorderRadius.circular(8),
                      dropdownColor: const Color.fromARGB(
                        255,
                        153,
                        130,
                        217,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      menuMaxHeight: 200,
                      iconEnabledColor: Colors.white,
                      items: data.map((Address a) {
                        return DropdownMenuItem(
                            value: a.address, child: Text(a.address));
                      }).toList(),
                      hint: Text(
                        '    $addressSelected',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          addressSelected = value.toString();
                        });
                      })),
              AnimatedContainer(
                  margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  width: animatedContainerWidth,
                  height: animatedContainerHeight,
                  duration: const Duration(milliseconds: 100),
                  child: const Text(
                    'Debe seleccionar una dirección',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
            ],
             ),
              ],
            ),
          ),
          
         
        ])));
  }
}
