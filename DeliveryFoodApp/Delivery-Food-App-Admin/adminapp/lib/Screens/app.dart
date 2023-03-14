import 'package:flutter/material.dart';
import 'Home/home.dart';
import 'productsScreen/productosScreen.dart';
import 'Logout.dart';

class App extends StatefulWidget {
  const App({super.key, this.pag = 0});
  final int pag;
  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  int paginaActual = 0;
  List<Widget> paginas = [
    const Home(),
    const ProductsScreen(),
    const LogOut(),
  ];

  @override
  initState() {
    paginaActual = widget.pag;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 224, 224),
      
      body: paginas[paginaActual],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 89, 71, 137) ,
          currentIndex: paginaActual,
          onTap: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(Icons.home_sharp),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.sell_sharp),
              label: 'Vender',
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.logout_sharp),
              label: 'Cerrar sesión',
            ),
          ]),
    );
  }
}
