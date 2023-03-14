import 'package:flutter/material.dart';
import 'screens/productScreen.dart';

class ProductBox extends StatefulWidget {
  const ProductBox(
      {super.key,
      required this.name,
      required this.price,
      required this.id,
      required this.imageName,
      required this.imageWidth,
      required this.imageHeight,
      required this.offerType,
      required this.descuento});
  final String name;
  final double price;
  final int id;
  final String imageName;
  final double imageWidth;
  final double imageHeight;
  final String offerType;
  final int descuento;
  @override
  State<ProductBox> createState() => _ProductBox();
}

class _ProductBox extends State<ProductBox> {
  String offer = '';
  bool offerTypeBoxFlag = false;

  @override
  Widget build(BuildContext context) {
    if (widget.offerType == 'Porcentaje de descuento') {
      setState(() {
        offer = '${widget.descuento.toString()}% OFF';
        offerTypeBoxFlag = true;
      });
    } else if (widget.offerType == 'Envio gratis') {
      setState(() {
        offer = 'Envio gratis';
        offerTypeBoxFlag = true;
      });
    } else {
      setState(() {
        offer = '';
        offerTypeBoxFlag = false;
      });
    }

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductScreen(
                      name: widget.name,
                      price: widget.price,
                      id: widget.id,
                      imageName: widget.imageName)));
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
          ),
          child: Card(
              shadowColor: const Color.fromARGB(143, 0, 0, 0),
              elevation: 20,
              surfaceTintColor: Colors.black,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(25))),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(
                          'http://192.168.1.28:3200/images/${widget.imageName}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: offerTypeBoxFlag
                      ? Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 55,
                            height: 25,
                            child: Center(
                                child: Text(
                              offer,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 10),
                            )),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: const Color.fromARGB(255, 63, 43, 118),
                            ),
                          ),
                        ])
                      : null,
                ),
                
                  Column(
                    children: [
                      const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      Center(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0)),
                      Center(
                          
                          child: Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          )),
                      const Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 0)),
                    ],
                  ),
                
              ])),
        ));
  }
}
