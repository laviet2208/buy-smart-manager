import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../general_ingredient/heading_title.dart';
import '../item/product_in_directory_item.dart';

class directory_view_product_list extends StatefulWidget {
  final String id;
  const directory_view_product_list({super.key, required this.id});

  @override
  State<directory_view_product_list> createState() => _directory_view_product_listState();
}

class _directory_view_product_listState extends State<directory_view_product_list> {
  List<String> productId = [];

  void get_product_list() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productDirectory").child(widget.id).child('productList').onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        productId.clear();
        if (data != null) {
          for (final result in data) {
            productId.add(result.toString());
          }
        }
        setState(() {

        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product_list();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/5*4;
    double height = MediaQuery.of(context).size.height/4*3;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: heading_title(numberColumn: 5, listTitle: ['Tên sản phẩm', 'Kho', 'Nhà cung cấp', 'Danh mục', 'Thao tác'], width: width, height: 50),
          ),

          Positioned(
            top: 105,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: productId.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return product_in_directory_item(id: productId[index], index: index, directoryId: widget.id,);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
