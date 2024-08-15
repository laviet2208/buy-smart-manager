import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/MoneyRequest/MoneyRequest.dart';
import 'package:lyshoppingmanager/general_ingredient/utils.dart';

import '../../../../data/Account/Account.dart';
import '../../../../data/historyData/Transaction.dart';
import '../../../../data/otherdata/Time.dart';

class handle_accept_request extends StatefulWidget {
  final MoneyRequest moneyRequest;
  const handle_accept_request({super.key, required this.moneyRequest});

  @override
  State<handle_accept_request> createState() => _handle_accept_requestState();
}

class _handle_accept_requestState extends State<handle_accept_request> {
  static Future<Account> getAccountData(String id) async {
    Account account = Account(id: '', username: '', password: '', address: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), money: 0, firstName: '', lastName: '', phoneNum: '', lockstatus: 0, voucherList: [],);
    final reference = FirebaseDatabase.instance.ref();
    DatabaseEvent snapshot = await reference.child("Account").child(id).once();
    final dynamic data = snapshot.snapshot.value;
    account = Account.fromJson(data);
    return account;
  }

  Future<void> update_money(double money) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Account').child(widget.moneyRequest.owner.id).child('money').set(money);
  }

  Future<void> update_trans(TransactionHis transaction) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Transaction').child(transaction.id).set(transaction.toJson());
  }

  Future<void> update_request() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('MoneyRequest').child(widget.moneyRequest.id).child('status').set('B');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.moneyRequest.type == 1 ? 'Xác nhận nạp' : 'Xác nhận rút'),
      content: Text('Bạn có chắc chắn muốn đồng ý không?'),
      actions: <Widget>[
        TextButton(
          child: Text('Hủy', style: TextStyle(color: Colors.red,),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Đồng ý', style: TextStyle(color: Colors.blue,),),
          onPressed: () async {
            Account acc = await getAccountData(widget.moneyRequest.owner.id);
            if (widget.moneyRequest.type == 1) {
              TransactionHis transaction = TransactionHis(id: '', content: '', money: 0, owner: '', type: 1);
              String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
              transaction.id = 'TRANS' + id;
              transaction.money = widget.moneyRequest.money;
              transaction.content = 'Handle request ' + widget.moneyRequest.id;
              transaction.owner = widget.moneyRequest.owner.id;
              acc.money = acc.money + widget.moneyRequest.money;
              await update_money(acc.money);
              await update_trans(transaction);
              await update_request();
              toastMessage('Xử lý thành công');
              Navigator.of(context).pop();
            } else {
              if (acc.money < widget.moneyRequest.money) {
                toastMessage('Tài khoản khách không còn đủ tiền');
              } else {
                TransactionHis transaction = TransactionHis(id: '', content: '', money: 0, owner: '', type: 0);
                String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                transaction.id = 'TRANS' + id;
                transaction.money = widget.moneyRequest.money;
                transaction.content = 'Handle request ' + widget.moneyRequest.id;
                transaction.owner = widget.moneyRequest.owner.id;
                acc.money = acc.money - widget.moneyRequest.money;
                await update_money(acc.money);
                await update_trans(transaction);
                await update_request();
                toastMessage('Xử lý thành công');
                Navigator.of(context).pop();
              }
            }
          },
        ),
      ],
    );
  }
}
