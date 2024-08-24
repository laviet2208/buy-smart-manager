import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../data/noticeData/noticeData.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../general_ingredient/utils.dart';

class start_stop_notice extends StatefulWidget {
  final noticeData data;
  const start_stop_notice({super.key, required this.data});

  @override
  State<start_stop_notice> createState() => _start_stop_noticeState();
}

class _start_stop_noticeState extends State<start_stop_notice> {
  bool loading = false;
  Future<void> change_notice(noticeData data) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Notification').child(data.id).set(data.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.data.status == 1 ? 'Xác nhận đẩy thông báo' : 'Xác nhận tạm dừng thông báo'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            if (widget.data.status == 1) {
              widget.data.status = 2;
              widget.data.send = getCurrentTime();
              await change_notice(widget.data);
              toastMessage('Đẩy thành công');
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              widget.data.status = 1;
              await change_notice(widget.data);
              toastMessage('Dừng thành công');
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Xác nhận', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ) : CircularProgressIndicator(color: Colors.redAccent,),
      ],
    );
  }
}
