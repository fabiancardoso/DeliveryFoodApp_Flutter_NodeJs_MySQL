import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawerHeader extends StatefulWidget {
  const MyDrawerHeader({super.key});

  @override
  State<MyDrawerHeader> createState() => _MyDrawerHeader();
}

class _MyDrawerHeader extends State<MyDrawerHeader> {
  String imageName = '';
  String username = '';

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? imgnme = prefs.getString('imageName');
    String? usrname = prefs.getString('username');
    setState(() {
      imageName = imgnme.toString();
      username = usrname.toString();
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return DrawerHeader(
      decoration: const BoxDecoration(
        color:  Color.fromARGB(255, 116, 90, 187),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                  image: imageName.length > 0
                      ? NetworkImage(
                          'http://192.168.1.28:3200/images/${imageName}')
                      : NetworkImage(
                          'http://192.168.1.28:3200/images/default-profile-picture.jpg'),
                  fit: BoxFit.fill,
                  alignment: Alignment.center),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Center(
              child: Text(username,
             style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25,
             ),
            ),)),
        ]),
      ),
    );
  }
}
