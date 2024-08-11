import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../data/product/ProductType.dart';
import '../../../../../general_ingredient/utils.dart';

class type_ui_search extends StatefulWidget {
  final List<String> idList;
  final VoidCallback event;
  const type_ui_search({super.key, required this.idList, required this.event});

  @override
  State<type_ui_search> createState() => _type_ui_searchState();
}

class _type_ui_searchState extends State<type_ui_search> {
  String query = '';
  final control = TextEditingController();
  List<ProductType> filteredList = [];
  final List<ProductType> list_type = [];

  void get_type_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productType").onValue.listen((event) {
      list_type.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductType type = ProductType.fromJson(value);
        if (!widget.idList.contains(type.id)) {
          list_type.add(type);
          filteredList = list_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  Future<void> push_new_list() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('UI').child('productType').set(widget.idList.map((e) => e).toList());
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
    get_type_data();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 400,
        height: 400,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: control,
                onChanged: (value) {
                  setState(() {
                    query = value;
                    filteredList = list_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm loại sản phẩm',
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
                          toastMessage('Vui lòng chờ');
                          control.text = filteredList[index].name;
                          widget.idList.add(filteredList[index].id);
                          await push_new_list();
                          setState(() {

                          });
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
      ),
    );
  }
}
