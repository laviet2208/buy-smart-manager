import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/Account/Account.dart';
import '../../../../general_ingredient/textfield_type_2.dart';
import '../../../../general_ingredient/utils.dart';

class view_account_info extends StatefulWidget {
  final Account account;
  const view_account_info({super.key, required this.account});

  @override
  State<view_account_info> createState() => _view_account_infoState();
}

class _view_account_infoState extends State<view_account_info> {
  bool loading = false;
  final userController = TextEditingController();
  final passController = TextEditingController();
  final idController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontFamily: 'muli', color: Colors.black, fontSize: 14);
  TextStyle hintStyle = TextStyle(fontWeight: FontWeight.normal, fontFamily: 'muli', color: Colors.grey, fontSize: 14);
  TextStyle editStyle = TextStyle(fontWeight: FontWeight.normal, fontFamily: 'muli', color: Colors.black, fontSize: 14);

  Future<void> update_account() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Account').child(widget.account.id).set(widget.account.toJson());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.text = widget.account.username;
    passController.text = widget.account.password;
    idController.text = widget.account.id;
    firstnameController.text = widget.account.firstName;
    lastnameController.text = widget.account.lastName;
    addressController.text = widget.account.address;
    phoneController.text = widget.account.phoneNum;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xem chi tiết tài khoản'),
      content: Container(
        width: 500,
        height: 500,
        child: ListView(
          children: [
            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: true, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Mã khách hàng', hint: 'Nhập mã khách hàng', controller: idController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: true, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Email khách hàng', hint: 'Nhập email khách hàng', controller: userController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: true, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Mật khẩu tài khoản', hint: 'Nhập mật khẩu', controller: passController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: false, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Họ', hint: 'Họ khách hàng', controller: firstnameController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: false, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Tên đệm và tên', hint: 'Tên đệm và tên', controller: lastnameController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: false, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'Địa chỉ khách hàng', hint: 'Địa chỉ khách hàng', controller: addressController, edittextStyle: editStyle),

            SizedBox(height: 10,),

            textfield_type_2(titleStyle: titleStyle, hintStyle: hintStyle, readOnly: false, maxLine: 1, onchange: () {}, textfieldHeight: 50, title: 'SĐT khách hàng', hint: 'SĐT khách hàng', controller: phoneController, edittextStyle: editStyle),

            SizedBox(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (firstnameController.text.isNotEmpty && lastnameController.text.isNotEmpty) {
              setState(() {
                loading = true;
              });
              widget.account.firstName = firstnameController.text.toString();
              widget.account.lastName = lastnameController.text.toString();
              widget.account.address = addressController.text.isNotEmpty ? addressController.text.toString() : '';
              widget.account.phoneNum = phoneController.text.isNotEmpty ? phoneController.text.toString() : '';
              await update_account();
              setState(() {
                loading = false;
              });
              toastMessage('Cập nhật thành công');
              Navigator.of(context).pop();
            } else {
              toastMessage('Hoàn thiện 1 số thông tin cần');
            }
          },
          child: Text(
            'Lưu thông tin',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(
                color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
