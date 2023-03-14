import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../user/user.dart';
import '../screens/login.dart';
import '../screens/home/home.dart';
import '../screens/myOrders/myOrdersPage.dart';
import '../screens/categoryScreen/categoryScreen.dart';
import '../Screens/myProfile/myProfile.dart';
import './myDrawerHeader.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const MyDrawerHeader(),
      ListTile(
        title: const Text('Home',
         style: TextStyle(
           fontWeight: FontWeight.w700,
           fontSize: 16
         ),
        ),
        leading: const Icon(
          MaterialSymbols.home_app_logo_sharp,
          color: Color.fromARGB(255, 116, 90, 187),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ));
        },
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).categorias,
          style: TextStyle(
           fontWeight: FontWeight.w700,
           fontSize: 16
         ),
        ),
        leading: const Icon(
          MaterialSymbols.category_outlined,
          color:  Color.fromARGB(255, 116, 90, 187),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ));
        },
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).misPedidos,
          style: TextStyle(
           fontWeight: FontWeight.w700,
           fontSize: 16
         ),
        ),
        leading: const Icon(
          MaterialSymbols.order_play_filled,
          color: Color.fromARGB(255, 116, 90, 187),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyOrdersPage(),
              ));
        },
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).miPerfil,
           style: TextStyle(
           fontWeight: FontWeight.w700,
           fontSize: 16
         ),
        ),
        leading:const Icon(
          Icons.account_box_outlined,
          color: Color.fromARGB(255, 116, 90, 187),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyProfileScreen(),
              ));
        },
      ),
      
    ]));
  }
}
