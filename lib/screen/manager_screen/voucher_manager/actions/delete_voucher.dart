import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../data/voucherData/Voucher.dart';
import '../../../../general_ingredient/utils.dart';

class delete_voucher extends StatefulWidget {
  final Voucher voucher;
  const delete_voucher({super.key, required this.voucher});

  @override
  State<delete_voucher> createState() => _delete_voucherState();
}

class _delete_voucherState extends State<delete_voucher> {
  bool loading = false;

  Future<void> delete_voucher() async {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('VoucherStorage').child(widget.voucher.id).remove();
      setState(() {
        loading = false;
      });
      toastMessage('Xóa voucher thành công');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận xóa voucher'),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.blueAccent,) :TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await delete_voucher();
            setState(() {

            });
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),

        loading ? CircularProgressIndicator(color: Colors.redAccent,) :TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}
