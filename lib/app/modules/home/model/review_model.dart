class ReviewModel {
  String? sId;
  String? userId;
  String? serviceId;
  double? rating;
  String? comment;
  String? dateTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ReviewModel({
    this.sId,
    this.userId,
    this.serviceId,
    this.rating,
    this.comment,
    this.dateTime,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    serviceId = json['serviceId'];
    rating = double.parse(json['rating'].toString());
    comment = json['comment'];
    dateTime = json['dateTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['serviceId'] = this.serviceId;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['dateTime'] = this.dateTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
