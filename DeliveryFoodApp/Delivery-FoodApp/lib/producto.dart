class Product {
  String name = '';
  double precio = 0;
  int id = 0;
  String imageName = '';
  String offerType = '';
  int descuento = 0;
  Product(this.name, this.precio, this.id);

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    precio = json['price'].toDouble();
    id = json['id'];
    imageName = json['imageName'];
    offerType = json['offerType'] != null ? json['offerType'] : '';
    descuento = json['descuento'] != null ? json['descuento'] : 0;
  }
}
