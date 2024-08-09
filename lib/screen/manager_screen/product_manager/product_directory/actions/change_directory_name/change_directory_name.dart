import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/ProductDirectory.dart';
import '../../../../../../general_ingredient/textfield_type_1.dart';
import '../../../../../../general_ingredient/utils.dart';

class change_directory_name extends StatefulWidget {
  final ProductDirectory directory;
  const change_directory_name({super.key, required this.directory});

  @override
  State<change_directory_name> createState() => _change_directory_nameState();
}

class _change_directory_nameState extends State<change_directory_name> {
  final nameController = TextEditingController();
  bool loading = false;

  Future<void> push_new_productdirect(ProductDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productDirectory').child(directory.id).set(directory.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Cập nhật danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.directory.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thay đổi tên danh mục'),
      content: Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfield_type_1(title: 'Nhập tên danh mục mới', hint: 'Tên danh mục', controller: nameController),

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (loading) {

            } else {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  loading = true;
                });
                ProductDirectory directory = ProductDirectory(id: widget.directory.id, name: nameController.text.toString(), createTime: getCurrentTime(), productList: widget.directory.productList, status: 1);
                await push_new_productdirect(directory);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              } else {
                toastMessage('Vui lòng nhập tên danh mục');
              }
            }
          },
          child: Text(
            'Lưu danh mục',
            style: TextStyle(
              fontFamily: 'muli',
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
            if (loading) {
              Navigator.of(context).pop();
            } else {

            }
          },
          child: Text(
            'Hủy',
            style: TextStyle(
              fontFamily: 'muli',
              color: Colors.redAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.redAccent,),
      ],
    );
  }
}
