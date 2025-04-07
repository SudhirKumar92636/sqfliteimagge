class UserModles {
  String? username;
  String? address;
  String? email;
  String? phone;
  String? password;
  String ? image;


  UserModles(
      {this.username, this.address, this.email, this.phone, this.password ,this.image});

  UserModles.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    address = json['Address'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = username;
    data['Address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['image'] = image;

    return data;
  }
}
