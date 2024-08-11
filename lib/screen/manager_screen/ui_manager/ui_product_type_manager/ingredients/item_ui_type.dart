import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/otherdata/Tool.dart';
import 'package:lyshoppingmanager/data/product/ProductType.dart';

import '../../../../../general_ingredient/text_line_in_item.dart';
import '../../../../../general_ingredient/utils.dart';

class item_ui_type extends StatefulWidget {
  final String id;
  final int index;
  final List<String> typeList;
  final VoidCallback event;
  const item_ui_type({super.key, required this.id, required this.index, required this.typeList, required this.event});

  @override
  State<item_ui_type> createState() => _item_ui_typeState();
}

class _item_ui_typeState extends State<item_ui_type> {
  ProductType productType = ProductType(id: '', createTime: getCurrentTime(), name: '', productList: []);

  void get_product_type() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productType").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        productType = ProductType.fromJson(data);
        setState(() {

        });
      });
    }
  }

  Future<void> push_new_list() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('UI').child('productType').set(widget.typeList.map((e) => e).toList());
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
    get_product_type();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 20)/2;
    double height = 70;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: '', content: productType.id),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: '', content: productType.name),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  TextButton(
                    onPressed: () async {
                      widget.typeList.removeAt(widget.index);
                      await push_new_list();
                    },
                    child: Text(
                      'Xóa hiển thị',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: widget.event,
                    child: Text(
                      'Demo hiển thị',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
