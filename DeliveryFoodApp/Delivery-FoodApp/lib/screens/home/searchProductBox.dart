import 'package:flutter/material.dart';

class SearchProductBox extends StatefulWidget {
  const SearchProductBox(
      {super.key, required this.name, required this.imageName});
  final String name;
  final String imageName;
  @override
  State<SearchProductBox> createState() => _SearchProductBox();
}

class _SearchProductBox extends State<SearchProductBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
        Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: NetworkImage(
                    'http://192.168.1.28:3200/images/${widget.imageName}',
                  ),
                  fit: BoxFit.fill)),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 0)),
        Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
        ]),
      ],
    ));
  }
}
