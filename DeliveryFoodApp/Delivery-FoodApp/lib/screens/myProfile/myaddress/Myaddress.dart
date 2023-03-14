import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/generated/l10n.dart';
import 'address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAdressScreen extends StatefulWidget {
  const MyAdressScreen({super.key});

  @override
  State<MyAdressScreen> createState() => _MyAdressScreen();
}

class _MyAdressScreen extends State<MyAdressScreen> {
  String address = '';
  int addressIndex = 0;
  List<Address> data = [];
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

  void deleteAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();

    var response =
        await http.delete(Uri.parse('http://192.168.1.28:3200/users/address'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({'address': data[addressIndex].address}));

    Navigator.of(context).pop();
    setState(() {
      reload();
    });
  }

  void saveAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? tkn = prefs.getString('token');
    String token = tkn.toString();
  
    if ((address.length > 0) & (token.length > 0)) {
      var response =
          await http.post(Uri.parse('http://192.168.1.28:3200/users/address'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({'address': address}));
      
      if (response.statusCode == 200) {
        getAddress().then((value) {
          setState(() {
            data.addAll(value);
          });
        });
      }
    }
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const SingleChildScrollView(
                child: Center(
              child: Text('Desea borrar esta direccion?'),
            )),
            actions: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: deleteAddress, child: const Text('Si')),
                    const Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'))
                  ],
                ),
              )
            ],
          );
        });
  }

  void reload() {
    data.clear();
    getAddress().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getAddress().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 233, 233),
        appBar: AppBar(
           backgroundColor: const Color.fromARGB(255, 116, 90, 187),
           title: Text(AppLocalizations.of(context).miDireccion),
           centerTitle: true,
        ),
        body: ListView(
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                  width: 200,
                  child: CupertinoTextField(
                    placeholder: AppLocalizations.of(context).direccion,
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                  ),
                ),
                Container(
                    width: 80,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: saveAddress, child: const Text('Add'),
                         style: ElevatedButton.styleFrom(
                         backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                          ),
                        
                        ),
                
                ),
            
              ],
            ),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  height: 400,
                  width: 300,
                  margin: const EdgeInsets.all(10),

                  child: SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 239, 236, 246),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(data[index].address),
                                          const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                50, 0, 120, 0),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addressIndex = index;
                                              });
                                              showMyDialog();
                                            },
                                            child: Icon(Icons.delete_sharp),
                                          ),
                                        ]),
                                  )));
                        },
                      ))),
            ]),
          ],
        ));
  }
}
