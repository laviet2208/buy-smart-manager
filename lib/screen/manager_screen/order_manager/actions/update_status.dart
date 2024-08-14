import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../data/orderData/Order.dart';

class update_status extends StatefulWidget {
  final Order order;
  const update_status({super.key, required this.order,});

  @override
  State<update_status> createState() => _update_statusState();
}

class _update_statusState extends State<update_status> {
  bool loading = false;
  bool _firstValue = false;
  bool _secondValue = false;
  bool _thirdValue = false;
  bool _fourthValue = false;

  Future<void> update_status(String status) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Order').child(widget.order.id).child('status').set(status);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.order.status == 'A') {
      _firstValue = true;
    }
    if (widget.order.status == 'B') {
      _secondValue = true;
    }
    if (widget.order.status == 'C') {
      _thirdValue = true;
    }
    if (widget.order.status == 'D') {
      _fourthValue = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật trạng thái'),
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text('Chưa xử lý'),
              value: _firstValue,
              onChanged: (bool? value) {
                setState(() {
                  _firstValue = value!;
                  _secondValue = false;
                  _thirdValue = false;
                  _fourthValue = false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Đang xử lý'),
              value: _secondValue,
              onChanged: (bool? value) {
                setState(() {
                  _secondValue = value!;
                  _firstValue = false;
                  _thirdValue = false;
                  _fourthValue = false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Đơn hoàn thành'),
              value: _thirdValue,
              onChanged: (bool? value) {
                setState(() {
                  _thirdValue = value!;
                  _secondValue = false;
                  _firstValue = false;
                  _fourthValue = false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Đơn bị hủy'),
              value: _fourthValue,
              onChanged: (bool? value) {
                setState(() {
                  _fourthValue = value!;
                  _secondValue = false;
                  _thirdValue = false;
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
            if (_firstValue || _secondValue || _thirdValue || _fourthValue) {
              setState(() {
                loading = true;
              });
              if (_firstValue) {
                widget.order.status = 'A';
              }
              if (_secondValue) {
                widget.order.status = 'B';
              }
              if (_thirdValue) {
                widget.order.status = 'C';
              }
              if (_fourthValue) {
                widget.order.status = 'D';
              }
              await update_status(widget.order.status);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
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
