import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart';

class SellProduct extends StatefulWidget {
  const SellProduct({super.key});

  @override
  State<SellProduct> createState() => _SellProduct();
}

class _SellProduct extends State<SellProduct> {
  File? image = File('images/imagenEnBlanco.jpeg');
  String name = '';
  double price = 0;
  List<String> categories = [
    'Pizzas',
    'Burgers',
    'Beverages',
    'Dishes',
    'Potatoes'
  ];
  String categorySelected = 'Category';

  Future<void> uploadProduct() async {
    String filename = image!.path.split('/').last;
    Dio dio = Dio();

    FormData formdata = FormData.fromMap({
      'name': name,
      'price': price,
      'category': categorySelected,
      'image': await MultipartFile.fromFile(image!.path, filename: filename)
    });
    final prefs = await SharedPreferences.getInstance();

    var tkn = prefs.getString('token') ?? 0;

    String token = tkn.toString();

    if(categorySelected != 'Category'){
      var response = await dio.post('http://192.168.1.28:3200/products',
        data: formdata,
        options: Options(headers: <String, dynamic>{
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        }));

        if (response.statusCode == 201) {
        setState(() {
          name = '';
          price = 0;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  App(),
            ));
      }
    }

    
  }

  void loadImage() async {
    final ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(img!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Product'),
          backgroundColor: const Color.fromARGB(255, 116, 90, 187),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 212, 212, 212),
              image: DecorationImage(
                image: FileImage(image!),
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              )),
          child: ListView(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(0, 200, 0, 0)),
              Container(
                width: 40,
                height: 30,
                margin: const EdgeInsets.fromLTRB(330, 10, 0, 0),
                child: FloatingActionButton(
                    backgroundColor: Colors.black12,
                    onPressed: loadImage,
                    child: const Text(
                      '+',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              Container(
                  height: 550,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 218, 217, 217),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(150, 30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 190,
                                child: CupertinoTextField(
                                  placeholder: 'Name',
                                  onChanged: (String value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 190,
                                child: CupertinoTextField(
                                  placeholder: 'Price',
                                  onChanged: (String value) {
                                    setState(() {
                                      price = double.parse(value);
                                    });
                                  },
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                margin: const EdgeInsets.fromLTRB(0, 30, 0, 90),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 63, 43, 118),
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButton(
                                    borderRadius: BorderRadius.circular(8),
                                    dropdownColor:
                                        const Color.fromARGB(255, 63, 43, 118),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    menuMaxHeight: 200,
                                    iconEnabledColor: Colors.white,
                                    items: categories.map((String a) {
                                      return DropdownMenuItem(
                                          value: a, child: Text(a));
                                    }).toList(),
                                    hint: Text(
                                      '    $categorySelected',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        categorySelected = value.toString();
                                      });
                                    }),
                              ),
                            ],
                          )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 270,
                              child: ElevatedButton(
                                onPressed: uploadProduct,
                                child: const Text('Sell product'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 63, 43, 118)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
