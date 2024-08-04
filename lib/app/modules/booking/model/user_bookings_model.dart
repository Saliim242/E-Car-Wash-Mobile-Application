// class UserBookingsModel {
//   String? sId;
//   Customer? customer;
//   List<Service>? service;
//   int? amount;
//   String? paymentStatus;
//   String? dateTime;
//   String? tn;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   UserBookingsModel({
//     this.sId,
//     this.customer,
//     this.service,
//     this.amount,
//     this.paymentStatus,
//     this.dateTime,
//     this.tn,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });

//   UserBookingsModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     customer = json['customer'] != null
//         ? new Customer.fromJson(json['customer'])
//         : null;
//     if (json['service'] != null) {
//       service = <Service>[];
//       json['service'].forEach((v) {
//         service!.add(new Service.fromJson(v));
//       });
//     }
//     amount = json['amount'];
//     paymentStatus = json['paymentStatus'];
//     dateTime = json['dateTime'];
//     tn = json['tn'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.customer != null) {
//       data['customer'] = this.customer!.toJson();
//     }
//     if (this.service != null) {
//       data['service'] = this.service!.map((v) => v.toJson()).toList();
//     }
//     data['amount'] = this.amount;
//     data['paymentStatus'] = this.paymentStatus;
//     data['dateTime'] = this.dateTime;
//     data['tn'] = this.tn;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Customer {
//   String? sId;
//   String? name;
//   String? email;

//   Customer({this.sId, this.name, this.email});

//   Customer.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     return data;
//   }
// }

// class Service {
//   String? image;
//   String? description;
//   String? sId;
//   ServiceType? serviceType;
//   CarType? carType;
//   int? price;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   Service(
//       {this.image,
//       this.description,
//       this.sId,
//       this.serviceType,
//       this.carType,
//       this.price,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Service.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     description = json['description'];
//     sId = json['_id'];
//     serviceType = json['serviceType'] != null
//         ? new ServiceType.fromJson(json['serviceType'])
//         : null;
//     carType =
//         json['carType'] != null ? new CarType.fromJson(json['carType']) : null;
//     price = json['price'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['description'] = this.description;
//     data['_id'] = this.sId;
//     if (this.serviceType != null) {
//       data['serviceType'] = this.serviceType!.toJson();
//     }
//     if (this.carType != null) {
//       data['carType'] = this.carType!.toJson();
//     }
//     data['price'] = this.price;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

// class ServiceType {
//   String? sId;
//   String? name;
//   String? description;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   ServiceType(
//       {this.sId,
//       this.name,
//       this.description,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   ServiceType.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     description = json['description'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

// class CarType {
//   String? sId;
//   String? type;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   CarType({this.sId, this.type, this.status, this.createdAt, this.updatedAt});

//   CarType.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     type = json['type'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['type'] = this.type;
//     data['status'] = this.status;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     return data;
//   }
// }

class UserBookingsModel {
  String? sId;
  Customer? customer;
  Service? service;
  int? amount;
  String? paymentStatus;
  String? dateTime;
  String? tn;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserBookingsModel(
      {this.sId,
      this.customer,
      this.service,
      this.amount,
      this.paymentStatus,
      this.dateTime,
      this.tn,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserBookingsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    amount = json['amount'];
    paymentStatus = json['paymentStatus'];
    dateTime = json['dateTime'];
    tn = json['tn'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['amount'] = this.amount;
    data['paymentStatus'] = this.paymentStatus;
    data['dateTime'] = this.dateTime;
    data['tn'] = this.tn;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Customer {
  String? sId;
  String? name;
  String? email;

  Customer({this.sId, this.name, this.email});

  Customer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class Service {
  String? image;
  String? description;
  String? sId;
  ServiceType? serviceType;
  CarType? carType;
  int? price;
  String? status;
  String? createdAt;
  String? updatedAt;

  Service(
      {this.image,
      this.description,
      this.sId,
      this.serviceType,
      this.carType,
      this.price,
      this.status,
      this.createdAt,
      this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    description = json['description'];
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
    data['image'] = this.image;
    data['description'] = this.description;
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
