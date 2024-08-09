import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/product/ProductType.dart';
import '../../../../../../general_ingredient/textfield_type_1.dart';
import '../../../../../../general_ingredient/utils.dart';

class change_product_type_name extends StatefulWidget {
  final ProductType type;
  const change_product_type_name({super.key, required this.type});

  @override
  State<change_product_type_name> createState() => _change_product_type_nameState();
}

class _change_product_type_nameState extends State<change_product_type_name> {
  bool loading = false;
  final nameController = TextEditingController();

  Future<void> push_new_producttype(ProductType type) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productType').child(type.id).set(type.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm loại sản phẩm thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.type.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm phân loại sản phẩm mới', style: TextStyle(fontFamily: 'muli'),),
      content: Container(
        width: 200,
        child: textfield_type_1(title: 'Nhập tên phân loại sản phẩm mới', hint: 'Tên phân loại sản phẩm', controller: nameController),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          child: Text('Đồng ý', style: TextStyle(color: Colors.blue),),
          onPressed: () async {
            if (!loading) {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  loading = true;
                });
                widget.type.name = nameController.text.toString();
                await push_new_producttype(widget.type);
                setState(() {
                  loading = false;
                });
                toastMessage('Sửa thành công');
                Navigator.of(context).pop();
              } else {
                toastMessage('Bạn chưa điền loại sản phẩm');
              }
            } else {

            }
          },
        ) : CircularProgressIndicator(color: Colors.blue,),

        !loading ? TextButton(
          child: Text('Hủy', style: TextStyle(color: Colors.red),),
          onPressed: () async {
            if (!loading) {
              Navigator.of(context).pop();
            } else {

            }
          },
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
