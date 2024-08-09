import '../otherdata/Time.dart';

class ProductDirectory {
  String id;
  String name;
  int status; //0: đang ẩn, 1: đang hiện
  Time createTime;
  List<String> productList;

  ProductDirectory({required this.id, required this.status, required this.name, required this.createTime, required this.productList});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'name': name,
    'productList': productList.map((e) => e).toList(),
    'status': status,
  };

  factory ProductDirectory.fromJson(Map<dynamic, dynamic> json) {
    List<String> prdList = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        prdList.add(result.toString());
      }
    }

    return ProductDirectory(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      name: json['name'].toString(),
      productList: prdList,
      status: int.parse(json['status'].toString()),
    );
  }
}