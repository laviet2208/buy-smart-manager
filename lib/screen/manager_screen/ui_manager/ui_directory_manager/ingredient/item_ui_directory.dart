import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/general_ingredient/utils.dart';

import '../../../../../data/otherdata/Tool.dart';
import '../../../../../data/product/ProductDirectory.dart';
import '../../../../../general_ingredient/text_line_in_item.dart';

class item_ui_directory extends StatefulWidget {
  final String id;
  final int index;
  final List<String> directoryList;
  final VoidCallback event;
  const item_ui_directory({super.key, required this.id, required this.index, required this.directoryList, required this.event});

  @override
  State<item_ui_directory> createState() => _item_ui_directoryState();
}

class _item_ui_directoryState extends State<item_ui_directory> {
  ProductDirectory directory = ProductDirectory(id: '', name: '', createTime: getCurrentTime(), productList: [], status: 1);

  void get_directory_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productDirectory").child(widget.id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      directory = ProductDirectory.fromJson(data);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    double height = 50;
    double width = MediaQuery.of(context).size.width - 20;
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
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Tên danh mục: ', content: directory.name),

                  Container(height: 10,),
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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Thời gian tạo: ', content: getAllTimeString(directory.createTime)),

                  Container(height: 10,),
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
              width: (width - 50)/4-1,
              alignment: Alignment.center,
              child: Text(
                'Số lượng sản phẩm: ' + directory.productList.length.toString(),
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 15,
                  color: Colors.black,
                ),
              )
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/4-1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: ListView(
                children: [
                  Container(height: 10,),

                  TextButton(
                    onPressed: () async {
                      widget.directoryList.removeAt(widget.index);
                      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
                      await databaseRef.child('UI').child('productDirectory').set(widget.directoryList.map((e) => e).toList());
                      toastMessage('Xóa thành công');
                      widget.event();
                    },
                    child: Text(
                      'Bỏ hiển thị',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
              // color: Colors.redAccent,
              color: Color.fromARGB(255, 240, 240, 240),
            ),
          ),
        ],
      ),
    );
  }
}
