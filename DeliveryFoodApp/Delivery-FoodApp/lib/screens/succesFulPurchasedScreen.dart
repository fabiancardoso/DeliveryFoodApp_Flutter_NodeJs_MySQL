import 'package:flutter/material.dart';
import './home/home.dart';

class SuccessFulPurchasedScreen extends StatefulWidget {
  const SuccessFulPurchasedScreen({super.key});

  @override
  State<SuccessFulPurchasedScreen> createState() =>
      _SuccessFulPurchasedScreen();
}

class _SuccessFulPurchasedScreen extends State<SuccessFulPurchasedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 116, 90, 187),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
            ),
            const Text('Thanks for your order!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            const Text(
              'You can see the status on my orders section',
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ));
              },
              child: const Text('Go to home'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 63, 43, 118)),
            )
          ],
        ),
      ),
    );
  }
}
