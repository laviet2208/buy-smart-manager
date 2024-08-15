import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/MoneyRequest/MoneyRequest.dart';
import 'package:lyshoppingmanager/general_ingredient/utils.dart';

import '../../../../data/Account/Account.dart';
import '../../../../data/historyData/Transaction.dart';
import '../../../../data/otherdata/Time.dart';

class handle_deny_request extends StatefulWidget {
  final MoneyRequest moneyRequest;
  const handle_deny_request({super.key, required this.moneyRequest});

  @override
  State<handle_deny_request> createState() => _handle_deny_requestState();
}

class _handle_deny_requestState extends State<handle_deny_request> {
  Future<void> update_request() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('MoneyRequest').child(widget.moneyRequest.id).child('status').set('C');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hủy yêu cầu'),
      content: Text('Bạn có chắc chắn muốn Hủy không?'),
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
            await update_request();
            toastMessage('Hủy thành công');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
