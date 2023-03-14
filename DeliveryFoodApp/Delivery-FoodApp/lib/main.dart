import 'package:flutter/material.dart';
import 'package:myapp/generated/l10n.dart';
import './screens/login.dart';
import './screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
          const Locale('es','ES'),
          const Locale('en','EN'),
          
      ],
      title: 'Food delivery app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
