import '../otherdata/Time.dart';
class ProductType {
  String id;
  Time createTime;
  String name;
  List<String> productList;

  ProductType({
    required this.id,
    required this.createTime,
    required this.name,
    required this.productList,
  });

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'name': name,
    'productList': productList.map((e) => e).toList(),
  };

  factory ProductType.fromJson(Map<dynamic, dynamic> json) {
    List<String> prdList = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        prdList.add(result.toString());
      }
    }

    return ProductType(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      name: json['name'].toString(),
      productList: prdList,
    );
  }
}