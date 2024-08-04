class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? status;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.status,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}
