class CustomerModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? token;

  CustomerModel({this.id, this.name, this.email, this.phone, this.token});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['token'] = this.token;
    return data;
  }
}
