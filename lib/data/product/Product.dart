import '../otherdata/Time.dart';

class Product {
  String id;
  Time createTime;
  String name;
  String viName;
  String description;
  int showStatus; //trạng thái hiển thị
  String productType; //phân loại sản phẩm
  List<String> directoryList;
  double cost; // Giá tiền gốc
  double costBeforeSale; // Giá tiền trước khi giảm giá
  int inventory; // Số lượng tồn kho
  Time saleLimit; // Dành cho sale có thời hạn
  String subdescription; // Nội dung phụ

  Product({required this.id, required this.name, required this.productType, required this.showStatus, required this.createTime, required this.description, required this.directoryList, required this.cost, required this.costBeforeSale, required this.inventory, required this.saleLimit, required this.subdescription, required this.viName});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'name': name,
    'description': description,
    'directoryList': directoryList.map((e) => e).toList(),
    'showStatus': showStatus,
    'productType': productType,
    'cost': cost,
    'costBeforeSale': costBeforeSale,
    'inventory': inventory,
    'saleLimit': saleLimit.toJson(),
    'subdescription': subdescription,
    'viName': viName,
  };

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    List<String> prdList = [];

    if (json["directoryList"] != null) {
      for (final result in json["directoryList"]) {
        prdList.add(result.toString());
      }
    }

    return Product(
      id: json['id'].toString(),
      createTime: Time.fromJson(json['createTime']),
      name: json['name'].toString(),
      directoryList: prdList,
      showStatus: int.parse(json['showStatus'].toString()),
      productType: json['productType'].toString(),
      cost: double.parse(json['cost'].toString()),
      costBeforeSale: double.parse(json['costBeforeSale'].toString()),
      inventory: int.parse(json['inventory'].toString()),
      description: json['description'].toString(),
      saleLimit: Time.fromJson(json['saleLimit']),
      subdescription: json['subdescription'].toString(),
      viName: json['viName'].toString(),
    );
  }
}