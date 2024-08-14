import '../product/Product.dart';

class Cartdata {
  Product product;
  int number;

  Cartdata({required this.product, required this.number});

  Map<dynamic, dynamic> toJson() => {
    'product': product.toJson(),
    'number': number,
  };

  factory Cartdata.fromJson(Map<dynamic, dynamic> json) {
    return Cartdata(
      product: Product.fromJson(json['product']),
      number: int.parse(json['number'].toString()),
    );
  }
}