import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../data/noticeData/noticeData.dart';
import '../../../../general_ingredient/utils.dart';


class delete_notice extends StatefulWidget {
  final noticeData data;
  const delete_notice({super.key, required this.data});

  @override
  State<delete_notice> createState() => _delete_noticeState();
}

class _delete_noticeState extends State<delete_notice> {
  bool loading = false;

  Future<void> delete_notice() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('Notification').child(widget.data.id).remove();
      toastMessage('Xóa thông báo thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận xóa'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await delete_notice();
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Đồng ý',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
