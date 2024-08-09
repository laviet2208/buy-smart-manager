import '../otherdata/Time.dart';

class AdsData {
  String id;
  String productId;
  Time createTime;
  int status;

  AdsData({required this.id, required this.productId, required this.createTime, required this.status});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'productId': productId,
    'status': status,
  };

  factory AdsData.fromJson(Map<dynamic, dynamic> json) {
    return AdsData(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      productId: json['productId'].toString(),
      status: int.parse(json['status'].toString()),
    );
  }
}