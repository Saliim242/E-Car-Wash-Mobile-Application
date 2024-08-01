class ServiceProvidersModel {
  String? sId;
  ServiceType? serviceType;
  CarType? carType;
  int? price;
  String? status;
  String? createdAt;
  String? updatedAt;

  ServiceProvidersModel(
      {this.sId,
      this.serviceType,
      this.carType,
      this.price,
      this.status,
      this.createdAt,
      this.updatedAt});

  ServiceProvidersModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    serviceType = json['serviceType'] != null
        ? new ServiceType.fromJson(json['serviceType'])
        : null;
    carType =
        json['carType'] != null ? new CarType.fromJson(json['carType']) : null;
    price = json['price'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType!.toJson();
    }
    if (this.carType != null) {
      data['carType'] = this.carType!.toJson();
    }
    data['price'] = this.price;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ServiceType {
  String? sId;
  String? name;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  ServiceType(
      {this.sId,
      this.name,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  ServiceType.fromJson(Map<String, dynamic> json) {
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

class CarType {
  String? sId;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  CarType({this.sId, this.type, this.status, this.createdAt, this.updatedAt});

  CarType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
