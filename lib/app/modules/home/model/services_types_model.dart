class ServiceTypesModel {
  String? sId;
  String? name;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  ServiceTypesModel(
      {this.sId,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  ServiceTypesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
