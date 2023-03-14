import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  String password = '';
  String confirmPassword = '';
  double heightTextPasswordDoNotMatch = 0;
  double heightContainer = 150;

  void changePassword() async {
    if (password == confirmPassword) {
      final prefs = await SharedPreferences.getInstance();
      String? tkn = prefs.getString('token');
      String token = tkn.toString();
      var response =
          await http.put(Uri.parse('http://192.168.1.28:3200/users/password'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=utf-8',
                'Authorization': "Bearer $token",
              },
              body: jsonEncode({'password': password}));
      
      if (response.statusCode == 201) {
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        heightTextPasswordDoNotMatch = 20;
        heightContainer = 180;
      });
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 300,
              height: heightContainer,
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
                      placeholder: AppLocalizations.of(context).contrasenia,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 200,
                    child: CupertinoTextField(
                      placeholder: AppLocalizations.of(context).confirmarContrasenia,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                    ),
                    onPressed: changePassword,
                    child: Text(AppLocalizations.of(context).cambiar),
                  ),
                  AnimatedContainer(
                    height: heightTextPasswordDoNotMatch,
                    duration: const Duration(milliseconds: 200),
                    child: const Center(
                      child: Text('Passwords do not match',
                          style: TextStyle(color: Colors.red)),
                    ),
                    
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
