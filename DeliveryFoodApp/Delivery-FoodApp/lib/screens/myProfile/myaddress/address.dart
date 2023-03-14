class Address {
  String address = '';

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
   
  }
}
