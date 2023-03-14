import 'package:flutter/material.dart';
import './AddProductoButton.dart';
import 'productosEnStock.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreen();
}

class _ProductsScreen extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold ( 
      appBar: AppBar(
        title: const Text('Mis Productos'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
      children: [
        const ProductosEnStock(),
        const AddProductButton(),
      ],
    )
    );
  }
}
