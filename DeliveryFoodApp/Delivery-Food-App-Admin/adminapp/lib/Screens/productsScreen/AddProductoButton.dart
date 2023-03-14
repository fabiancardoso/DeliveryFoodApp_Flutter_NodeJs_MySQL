import 'package:flutter/material.dart';
import './sellProduct.dart';

class AddProductButton extends StatefulWidget {
  const AddProductButton({super.key});

  @override
  State<AddProductButton> createState() => _AddProductButton();
}

class _AddProductButton extends State<AddProductButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                   backgroundColor: const Color.fromARGB(255, 63, 43, 118),
                ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                      builder: (context) => const SellProduct(),
          ));
              },
              child: const Text('Agregar producto'),
            ),
          ),
        ],
      ),
    );
  }
}
