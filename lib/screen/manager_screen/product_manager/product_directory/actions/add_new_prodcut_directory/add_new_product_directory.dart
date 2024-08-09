import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/ProductDirectory.dart';
import '../../../../../../general_ingredient/textfield_type_1.dart';
import '../../../../../../general_ingredient/utils.dart';

class add_new_product_directory extends StatefulWidget {
  final VoidCallback event;
  const add_new_product_directory({super.key, required this.event});

  @override
  State<add_new_product_directory> createState() => _add_new_product_directoryState();
}

class _add_new_product_directoryState extends State<add_new_product_directory> {
  bool loading = false;

  final nameController = TextEditingController();

  Future<void> push_new_productdirect(ProductDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productDirectory').child(directory.id).set(directory.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm nhà danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm danh mục sản phẩm mới', style: TextStyle(fontFamily: 'muli'),),
      content: Container(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfield_type_1(title: 'Nhập tên danh mục mới', hint: 'Tên danh mục', controller: nameController),

            Container(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Lưu ý: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'muli',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: 'Danh mục sản phẩm là thứ sẽ hiển thị ở giao diện chính của app',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 20,),
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
                String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                ProductDirectory directory = ProductDirectory(id: 'DIRECT' + id, name: nameController.text.toString(), createTime: getCurrentTime(), productList: [], status: 1);
                await push_new_productdirect(directory);
                widget.event();
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
