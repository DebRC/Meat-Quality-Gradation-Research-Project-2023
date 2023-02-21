class Meat {
  String? meatType;
  double? meatTypeConfidence;
  double? consumableConfidence;
  double? nonConsumableConfidence;

  Meat(
      {this.meatType,
      this.meatTypeConfidence,
      this.consumableConfidence,
      this.nonConsumableConfidence});

  Meat.fromJson(Map<String, dynamic> json) {
    meatType = json['meatType'];
    meatTypeConfidence = json['meatTypeConfidence'];
    consumableConfidence = json['consumableConfidence'];
    nonConsumableConfidence = json['nonConsumableConfidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meatType'] = meatType;
    data['meatTypeConfidence'] = meatTypeConfidence;
    data['consumableConfidence'] = consumableConfidence;
    data['nonConsumableConfidence'] = nonConsumableConfidence;
    return data;
  }
}
