import 'dart:io';

class Meat {
  File? meatImage;
  String? meatType;
  double? meatTypeConfidence;
  double? consumableConfidence;
  double? nonConsumableConfidence;
  String? remarks;

  Meat(
      {this.meatImage,
      this.meatType,
      this.meatTypeConfidence,
      this.consumableConfidence,
      this.nonConsumableConfidence,
      this.remarks});

  Meat.fromJson(Map<String, dynamic> json) {
    meatImage = json['meatImage'];
    meatType = json['meatType'];
    meatTypeConfidence = json['meatTypeConfidence'];
    consumableConfidence = json['consumableConfidence'];
    nonConsumableConfidence = json['nonConsumableConfidence'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meatImage'] = meatImage;
    data['meatType'] = meatType;
    data['meatTypeConfidence'] = meatTypeConfidence;
    data['consumableConfidence'] = consumableConfidence;
    data['nonConsumableConfidence'] = nonConsumableConfidence;
    data['remarks'] = remarks;
    return data;
  }
}
