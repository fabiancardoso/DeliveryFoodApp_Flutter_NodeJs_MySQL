

class Product {
  String name = '';
  double precio = 0;
  int id = 0;
  String imageName = '';
  Product(this.name, this.precio, this.id);

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    precio = json['price'].toDouble();
    id = json['id'];
    imageName = json['imageName'];
  }
}
