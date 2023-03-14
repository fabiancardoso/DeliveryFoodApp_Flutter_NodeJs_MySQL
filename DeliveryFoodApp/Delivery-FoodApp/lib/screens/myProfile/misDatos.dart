import 'package:flutter/material.dart';
import 'package:myapp/generated/l10n.dart';
import './ChangeData.dart';
import 'changePassword.dart';

class MisDatosScreen extends StatefulWidget {
  const MisDatosScreen({super.key});

  @override
  State<MisDatosScreen> createState() => _MisDatosScreen();
}

class _MisDatosScreen extends State<MisDatosScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).misDatos),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        const Center(),
        Container(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeDataScreen(
                          typeDataChange: AppLocalizations.of(context).correo
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                child: Row(children: [Text(AppLocalizations.of(context).correo)]))),
        Container(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeDataScreen(
                          typeDataChange: AppLocalizations.of(context).nombre,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                child: Row(
                  children: [
                    Text(AppLocalizations.of(context).nombre),
                  ],
                ))),
        Container(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeDataScreen(
                          typeDataChange: AppLocalizations.of(context).apellido,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                child: Row(children: [Text(AppLocalizations.of(context).apellido)]))),
        Container(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeDataScreen(
                          typeDataChange: AppLocalizations.of(context).nombreDeUsuario,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                child: Row(children: [Text(AppLocalizations.of(context).nombreDeUsuario)]))),
        Container(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ));
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                ),
                child: Row(children: [Text(AppLocalizations.of(context).contrasenia)]))),
      ]),
    );
  }
}
