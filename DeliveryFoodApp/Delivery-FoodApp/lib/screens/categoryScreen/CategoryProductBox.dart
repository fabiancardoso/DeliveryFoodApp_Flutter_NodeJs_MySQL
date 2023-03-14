import 'package:flutter/material.dart';

class CategoryProductBox extends StatefulWidget {
  const CategoryProductBox({super.key, required this.name,required this.imageLocation});
  final String name;
  final String imageLocation;

  @override
  State<CategoryProductBox> createState() => _CategoryProductBox();
}

class _CategoryProductBox extends State<CategoryProductBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        height: 70,
        child: Card(
          shadowColor: Colors.black,
          color: const Color.fromARGB(255, 220, 212, 241),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(70))),
        
            child: ClipOval(
              child: Image.asset(widget.imageLocation,
              fit: BoxFit.cover 
              ),
              
              )
        
        ));
  }
}
