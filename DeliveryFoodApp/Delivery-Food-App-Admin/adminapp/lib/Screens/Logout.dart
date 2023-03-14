import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user/user.dart';
import './login.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<LogOut> createState() => _LogOut();
}

class _LogOut extends State<LogOut> {
  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('username');

    setState(() {
      username = user.toString();
    });
  }

  void cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }

  String username = '';
  @override
  initState() {
    cerrarSesion();
    super.initState();
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      
    );
  }
}
