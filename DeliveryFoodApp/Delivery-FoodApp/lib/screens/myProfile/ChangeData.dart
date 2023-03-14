import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChangeDataScreen extends StatefulWidget {
  const ChangeDataScreen(
      {super.key, required this.typeDataChange});

  final String typeDataChange;

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreen();
}

class _ChangeDataScreen extends State<ChangeDataScreen> {
  String newData = '';

  void changeData() async {
    if (newData.length > 0) {
      final prefs = await SharedPreferences.getInstance();
      String? tkn = prefs.getString('token');
      String token = tkn.toString();
      var response =
          await http.put(Uri.parse('http://192.168.1.28:3200/users/'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': "Bearer $token",
              },
              body: jsonEncode({
                'data': newData,
                'typeData': widget.typeDataChange
              }));

      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 116, 90, 187),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 150,
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  color: const Color.fromARGB(255, 242, 242, 242)),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                  Container(
                    width: 200,
                    child: CupertinoTextField(
                      placeholder: widget.typeDataChange,
                      onChanged: (value) {
                        setState(() {
                          newData = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: changeData,
                    child: Text('Change ${widget.typeDataChange}'),
                    style: ElevatedButton.styleFrom(
                     backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
