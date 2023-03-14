class Order {
  String productName = '';
  int orderId = 0;
  String status = '';
  String imageName = '';
  int cantidad = 0;
  double montoTotal = 0;

  Order.fromJson(Map<String, dynamic> json) {
    productName = json["ProductName"];
    orderId = json['OrderId'];
    status = json['Status'];
    imageName = json['ImageName'];
    cantidad = json['Cantidad'];
    montoTotal = json['MontoTotal'].toDouble();
  }
}
