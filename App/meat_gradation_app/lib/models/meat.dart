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
    data['meatTypeConfidence'] =
        double.parse((meatTypeConfidence! * 100).toStringAsFixed(2));
    data['consumableConfidence'] =
        double.parse((consumableConfidence! * 100).toStringAsFixed(2));
    data['nonConsumableConfidence'] =
        double.parse((nonConsumableConfidence! * 100).toStringAsFixed(2));
    data['remarks'] = remarks;
    return data;
  }
}
