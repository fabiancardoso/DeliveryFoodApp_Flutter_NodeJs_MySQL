import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../user/user.dart';
import './home/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  String name = '';
  String lastname = '';
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String address = '';
  double _heightAnimatedContainer = 0;
  void createAccount() async {
    if (password == confirmPassword) {
      var user = {
        'name': name,
        'lastname': lastname,
        'username': username,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('http://192.168.1.28:3200/users/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(user),
      );

      if (response.statusCode == 201) {
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
      } else if (response.statusCode == 401) {
        setState(() {
          _heightAnimatedContainer = 20;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 236, 236),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(90, 50, 0, 0),
            child: const Text('Completá tus datos',
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                width: 250,
                child: CupertinoTextField(
                  placeholder: 'Name',
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: CupertinoTextField(
                  placeholder: 'Lastname',
                  onChanged: (String value) {
                    setState(() {
                      lastname = value;
                    });
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: CupertinoTextField(
                  placeholder: 'Username',
                  onChanged: (String value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
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
              ),
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
              SizedBox(
                width: 250,
                child: CupertinoTextField(
                  placeholder: 'Confirm passowrd',
                  onChanged: (String value) {
                    setState(() {
                      confirmPassword = value;
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
                  duration: const Duration(milliseconds: 200),
                  width: 200,
                  height: _heightAnimatedContainer,
                  margin: const EdgeInsets.fromLTRB(80, 10, 0, 0),
                  child: const Text(
                    'El usuario ya existe',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
              Container(
                width: 250,
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    createAccount();
                  },
                  child: const Text('Crear Cuenta'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 63, 43, 118)),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
