import '../cartData/CartData.dart';
import '../otherdata/Time.dart';
import '../voucherData/Voucher.dart';
import 'Receiver.dart';

class Order {
  String id; // mã đơn
  Voucher voucher; // mã giảm giá
  String note; // ghi chú
  List<Cartdata> productList; // danh sách sản phẩm
  String status; // trạng thái A: Chưa xử lý, B: Đang xử lý, C: Hoàn thành, D: Bị hủy,
  Receiver receiver; // thông tin người nhận
  Time createTime; // thời gian tạo
  String owner; // id tk đặt

  Order({required this.id, required this.voucher, required this.note, required this.productList, required this.receiver, required this.createTime, required this.status, required this.owner});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'voucher': voucher.toJson(),
    'note': note,
    'status': status,
    'receiver': receiver.toJson(),
    'createTime': createTime.toJson(),
    'owner': owner,
    'productList': productList.map((e) => e.toJson()).toList()
  };

  factory Order.fromJson(Map<dynamic, dynamic> json) {
    List<Cartdata> prdList = [];

    if (json["productList"] != null) {
      for (final result in json["productList"]) {
        prdList.add(Cartdata.fromJson(result));
      }
    }

    return Order(
      id: json['id'].toString(),
      voucher: Voucher.fromJson(json['voucher']),
      note: json['note'].toString(),
      productList: prdList,
      receiver: Receiver.fromJson(json['receiver']),
      createTime: Time.fromJson(json['createTime']),
      status: json['status'].toString(),
      owner: json['owner'].toString(),
    );
  }
}