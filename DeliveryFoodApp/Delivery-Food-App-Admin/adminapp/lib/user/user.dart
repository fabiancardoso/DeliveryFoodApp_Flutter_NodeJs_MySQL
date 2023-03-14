
class User {
  int id = 0;
  String name = '';
  String lastname = '';
  String username = '';
  String token = '';
  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    token = json['token'];
  }
    
}
