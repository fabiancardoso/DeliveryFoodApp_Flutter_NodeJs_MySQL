import 'package:flutter/material.dart';

class SalesData extends StatefulWidget {
  const SalesData(
      {super.key, required this.cantidadDeVentas, required this.montoTotal});
  final int cantidadDeVentas;
  final double montoTotal;
  @override
  State<SalesData> createState() => _SalesData();
}

class _SalesData extends State<SalesData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: const Text(
          'These are your sales data: ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        )),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              width: 300,
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 227, 226, 226),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Text(
                    'Total sold today: ${widget.cantidadDeVentas} ',
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(255, 109, 108, 107),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                  Text(
                    'Total amount: \$ ${widget.montoTotal}',
                    style: const TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(255, 109, 108, 107),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
