import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../data/product/ProductDirectory.dart';
import '../../../../../general_ingredient/utils.dart';

class add_ui_directory extends StatefulWidget {
  final List<String> directoryList;
  const add_ui_directory({super.key, required this.directoryList});

  @override
  State<add_ui_directory> createState() => _add_ui_directoryState();
}

class _add_ui_directoryState extends State<add_ui_directory> {
  String query = '';
  final control = TextEditingController();
  List<ProductDirectory> filteredList = [];
  final List<ProductDirectory> directory_type = [];

  void get_directory_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productDirectory").onValue.listen((event) {
      directory_type.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductDirectory directory = ProductDirectory.fromJson(value);
        if (!widget.directoryList.contains(directory.id)) {
          directory_type.add(directory);
          filteredList = directory_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  Future<void> push_new_list() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('UI').child('productDirectory').set(widget.directoryList.map((e) => e).toList());
      toastMessage('Cập nhật thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            TextField(
              controller: control,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Tìm kiếm danh mục sản phẩm',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ListTile(
                      title: Text(filteredList[index].name),
                      onTap: () async {
                        toastMessage('Vui lòng đợi');
                        control.text = filteredList[index].name;
                        widget.directoryList.add(filteredList[index].id);
                        await push_new_list();
                        setState(() {

                        });
                        toastMessage('Thêm thành công');
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
