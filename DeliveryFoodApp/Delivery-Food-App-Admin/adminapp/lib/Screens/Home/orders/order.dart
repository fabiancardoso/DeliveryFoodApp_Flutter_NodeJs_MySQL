class Order {
  String address = '';
  String client = '';
  int amount = 0;
  double price = 0;
  int id = 0;
  String imageName = '';
  String status = '';

  Order.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    imageName = json['imageName'];
    price = json['price'].toDouble();
    client = json['client'];
    amount = json['amount'];
    status = json['status'];
  }
}
