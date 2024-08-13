import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/Account/Account.dart';
import '../../../../data/historyData/Transaction.dart';
import '../../../../general_ingredient/textfield_type_1.dart';

class change_account_money extends StatefulWidget {
  final Account account;
  const change_account_money({super.key, required this.account});

  @override
  State<change_account_money> createState() => _change_account_moneyState();
}

class _change_account_moneyState extends State<change_account_money> {
  final controller = TextEditingController();
  final ContentController = TextEditingController();
  bool loading = false;
  bool _firstValue = false;
  bool _secondValue = false;

  TransactionHis transaction = TransactionHis(id: '', content: '', money: 0, owner: '', type: 0);

  Future<void> update_money(double money) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Account').child(widget.account.id).child('money').set(money);
  }

  Future<void> update_trans() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Transaction').child(transaction.id).set(transaction.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cộng trừ tiền'),
      content: Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textfield_type_1(title: 'Số tiền giao dịch', hint: 'Nhập số tiền giao dịch', controller: controller),

            SizedBox(height: 10,),

            textfield_type_1(title: 'Nội dung', hint: 'Nhập nội dung giao dịch', controller: ContentController),

            SizedBox(height: 10,),

            CheckboxListTile(
              title: Text('Cộng tiền'),
              value: _firstValue,
              onChanged: (bool? value) {
                setState(() {
                  _firstValue = value!;
                  _secondValue = false;
                });
              },
            ),


            SizedBox(height: 10,),

            CheckboxListTile(
              title: Text('Trừ tiền'),
              value: _secondValue,
              onChanged: (bool? value) {
                setState(() {
                  _secondValue = value!;
                  _firstValue = false;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          child: Text('Cập nhật', style: TextStyle(color: Colors.blueAccent,),),
          onPressed: () async {
            if (_firstValue || _secondValue) {
              if (controller.text.isNotEmpty && ContentController.text.isNotEmpty) {
                setState(() {
                  loading = true;
                });
                if (_firstValue) {
                  transaction.type = 1;
                }
                if (_secondValue) {
                  transaction.type = 0;
                }
                String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                transaction.id = 'TRANS' + id;
                transaction.money = double.parse(controller.text.toString());
                transaction.content = ContentController.text.toString();
                transaction.owner = widget.account.id;
                widget.account.money = transaction.type == 0 ? (widget.account.money - transaction.money) : (widget.account.money + transaction.money);
                await update_money(widget.account.money);
                await update_trans();
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              }
            }
          },
        ) : CircularProgressIndicator(color: Colors.blue,),

        TextButton(
          child: Text('Đóng', style: TextStyle(color: Colors.red,),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
