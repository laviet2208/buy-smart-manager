import '../otherdata/Time.dart';
import '../voucherData/Voucher.dart';

class Account {
  String id;
  String username;
  String password;
  String firstName;
  String lastName;
  double money;
  String address;
  String phoneNum;
  List<Voucher> voucherList;
  int lockstatus;
  Time createTime;

  Account({required this.id, required this.username, required this.password, required this.address, required this.createTime, required this.money, required this.firstName, required this.lastName, required this.phoneNum, required this.lockstatus, required this.voucherList});

  Map<dynamic, dynamic> toJson() => {
    'id': id,
    'createTime': createTime.toJson(),
    'username': username,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'money': money,
    'address': address,
    'phoneNum': phoneNum,
    'lockstatus': lockstatus,
    'voucherList': voucherList.map((e) => e.toJson()).toList(),
  };

  factory Account.fromJson(Map<dynamic, dynamic> json) {
    List<Voucher> prdList = [];

    if (json["voucherList"] != null) {
      for (final result in json["voucherList"]) {
        prdList.add(Voucher.fromJson(result));
      }
    }

    return Account(
      id: json['id'].toString(),
      username: json['username'].toString(),
      password: json['password'].toString(),
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      address: json['address'].toString(),
      phoneNum: json['phoneNum'].toString(),
      money: double.parse(json['money'].toString()),
      lockstatus: int.parse(json['lockstatus'].toString()),
      createTime: Time.fromJson(json['createTime']),
      voucherList: prdList,
    );
  }
}