import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/Account/Account.dart';
import 'package:lyshoppingmanager/general_ingredient/utils.dart';

class delete_account extends StatefulWidget {
  final Account account;
  const delete_account({super.key, required this.account});

  @override
  State<delete_account> createState() => _delete_accountState();
}

class _delete_accountState extends State<delete_account> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận xóa', style: TextStyle(color: Colors.black,),),
      content: Text('Bạn có chắc chắn xóa tài khoản này không? Việc này sẽ xóa toàn bộ thông tin người dùng này.'),
      actions: <Widget>[
        TextButton(
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent,),),
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog
          },
        ),

        !loading ? ElevatedButton(
          child: Text('Xác nhận', style: TextStyle(color: Colors.white,),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Nút màu đỏ để cảnh báo
          ),
          onPressed: () async {
            if (!loading) {
              setState(() {
                loading = true;
              });
              DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
              await databaseRef.child('Account').child(widget.account.id).remove();
              setState(() {
                loading = false;
              });
              toastMessage('Xóa thành công');
              Navigator.of(context).pop();
            } else {
              toastMessage('Vui lòng chờ');
            }
          },
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
