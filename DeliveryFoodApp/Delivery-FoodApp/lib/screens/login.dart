import 'dart:convert';
import '../user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './home/home.dart';
import 'SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String email = '';
  String password = '';
  double _height = 0;

  void login() async {
    var response =
        await http.post(Uri.parse('http://192.168.1.28:3200/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }));

    if (response.statusCode == 200) {
      var datos = jsonDecode(response.body);
      var user = User.fromJson(datos);

      final prefs = await SharedPreferences.getInstance();

       await prefs.setInt('id', user.id);
       await prefs.setString('name', user.name);
       await prefs.setString('lastname', user.lastname);
       await prefs.setString('username', user.username);
       await prefs.setString('imageName', user.imageName);
       await prefs.setString('token', user.token);
       await prefs.setBool('auth', true);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    } else if (response.statusCode == 403) {
      setState(() {
        _height = 15;
      });
    }
  }

  void verifyAuth() async {
    final prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
  
    if (id != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ));
    }
  }

  @override
  initState() {
    super.initState();
    verifyAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 236, 236),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 116, 90, 187),
          automaticallyImplyLeading: false,
        ),
        body: ListView(children: [
          const Padding(padding: EdgeInsets.fromLTRB(0, 130, 0, 0)),
          Center(
           //
            child: const Text(
              '¡Hola!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
            ),
          ),
          Center(
              
              child: const Text(
                'Ingresá tu correo y contraseña para comenzar',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 250,
                    child: CupertinoTextField(
                      placeholder: 'Email',
                      onChanged: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 250,
                    child: CupertinoTextField(
                      placeholder: 'Passowrd',
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      duration: const Duration(microseconds: 200),
                      width: 250,
                      height: _height,
                      margin: const EdgeInsets.fromLTRB(70, 10, 0, 0),
                      child: const Text(
                        'Incorrect user or password',
                        style: TextStyle(color: Colors.red),
                      )),
                  Container(
                    width: 250,
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 63, 43, 118)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ));
                      },
                      child: const Text('No tengo usuario')),
                ],
              )),
        ]));
  }
}
