import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/generated/l10n.dart';
import '../login.dart';
import './misDatos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'myaddress/Myaddress.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
  String name = '';
  String lastname = '';
  String imageName = '';
  File? image = File('');

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? nme = prefs.getString('name');
    String? imgnme = prefs.getString('imageName') ?? '';
    String? lnme = prefs.getString('lastname');
    setState(() {
      lastname = lnme.toString();
      name = nme.toString();
      imageName = imgnme.toString();
    });
  }

  void loadImage() async {
    final ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(img!.path);
    });

    uploadProfilePicture();
  }

  Future<void> uploadProfilePicture() async {
    String filename = image!.path.split('/').last;
    Dio dio = Dio();

    FormData formdata = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: filename)
    });
    final prefs = await SharedPreferences.getInstance();

    var tkn = prefs.getString('token') ?? 0;

    String token = tkn.toString();

    var response = await dio.post('http://192.168.1.28:3200/users/picture',
        data: formdata,
        options: Options(headers: <String, dynamic>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        }));

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = response.data['imageName'];
      await prefs.setString('imageName', data);
      setState(() {
        imageName = data;
      });
    }
  }

  void signOff()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();     
     Navigator.push(
      context,
    MaterialPageRoute(builder: (context) => const Login(),));
          
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 223, 223),
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).miPerfil),
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
      ),
      body: ListView(
        children: [
          Container(
            width: 300,
            height: 200,
            child: Center(
              child: Row(children: [
                Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.fromLTRB(110, 0, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(73),
                      image: DecorationImage(
                          image: imageName.length > 0
                              ? NetworkImage(
                                  'http://192.168.1.28:3200/images/${imageName}')
                              : NetworkImage(
                                  'http://192.168.1.28:3200/images/default-profile-picture.jpg'),
                          fit: BoxFit.fill,
                          alignment: Alignment.center)),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    width: 30,
                    height: 30,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(loadImage);
                      },
                      backgroundColor: const Color.fromARGB(255, 63, 43, 118),
                      child: const Text('+', style: TextStyle(fontSize: 25)),
                    ))
              ]),
            ),
          ),
          const Padding(padding:EdgeInsets.fromLTRB(0, 20, 0, 0) ),
          Center(
            //margin: const EdgeInsets.fromLTRB(93, 20, 0, 10),
            child: Text(
              '$name $lastname',
              style: const TextStyle(
                fontSize: 30,
                textBaseline: TextBaseline.ideographic,
                fontStyle: FontStyle.italic, 
                fontFamily: AutofillHints.familyName,
                fontWeight: FontWeight.w900),
            ),
          ),
           const Padding(padding:EdgeInsets.fromLTRB(0, 20, 0, 0) ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MisDatosScreen(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                    ),
                    child: Row(children: [
                      Text(AppLocalizations.of(context).misDatos),
                      const Padding(padding: EdgeInsets.fromLTRB(175, 0, 0, 0)),
                      const Icon(Icons.arrow_right_sharp)
                    ])),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyAdressScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 63, 43, 118)
                  ),
                  child: Row(children: [
                    Text(AppLocalizations.of(context).direccion),
                    const Padding(padding: EdgeInsets.fromLTRB(179, 0, 0, 0)),
                    const Icon(Icons.arrow_right_sharp)
                  ]),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: signOff,
                   child: Text(AppLocalizations.of(context).cerrarSesion,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 63, 43, 118)
                    ),
                   ),
                   
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
