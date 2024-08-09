import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../data/otherdata/Tool.dart';
import '../../../../../../../../data/product/ProductDirectory.dart';

class item_directory_select extends StatefulWidget {
  final String id;
  final VoidCallback event;
  const item_directory_select({super.key, required this.id, required this.event});

  @override
  State<item_directory_select> createState() => _item_directory_selectState();
}

class _item_directory_selectState extends State<item_directory_select> {
  ProductDirectory directory = ProductDirectory(id: '', status: 0, name: '', createTime: getCurrentTime(), productList: []);

  void get_type_name() {
    if (widget.id == '') {

    } else {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productDirectory").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        if (data != null) {
          directory = ProductDirectory.fromJson(data);
        } else {
          directory.name = 'Danh mục không tồn tại';
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
    get_type_name();
  }
  
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60)/4 - 30;
    return Container(
      width: width,
      child: Row(
        children: [
          Container(
            width: width - 20,
            child: Text(
              directory.name,
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: 14,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          GestureDetector(
            child: Container(
              width: 20,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.delete_outline_outlined,
                size: 15,
                color: Colors.red,
              ),
            ),
            onTap: widget.event,
          ),
        ],
      ),
    );
  }
}
