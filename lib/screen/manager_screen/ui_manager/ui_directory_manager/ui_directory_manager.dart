import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ui_manager/ui_directory_manager/actions/add_ui_directory.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ui_manager/ui_directory_manager/ingredient/item_ui_directory.dart';

import '../../../../general_ingredient/heading_title.dart';

class ui_directory_manager extends StatefulWidget {
  const ui_directory_manager({super.key});

  @override
  State<ui_directory_manager> createState() => _ui_directory_managerState();
}

class _ui_directory_managerState extends State<ui_directory_manager> {
  List<String> directoryList = [];

  void get_directory_ui() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child('UI').child('productDirectory').onValue.listen((event) {
      directoryList.clear();
      final dynamic orders = event.snapshot.value;
      for (final result in orders) {
        String id = result.toString();
        directoryList.add(id);
      }
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_ui();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double height = MediaQuery.of(context).size.height - 80;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all()
                ),
                child: Center(
                  child: Text(
                    '+ Thêm danh mục hiển thị',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: add_ui_directory(directoryList: directoryList), title: Text('Chọn danh mục hiển thị'),);
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 200,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all()
                ),
                child: Center(
                  child: Text(
                    'Xem Demo',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              onTap: () {
                // showDialog(
                //   context: context,
                //   builder: (context) {
                //     return type_ui_search(event: () { setState(() {}); }, idList: typeList,);
                //   },
                // );
              },
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              width: width,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: heading_title(numberColumn: 4, listTitle: ['Thông tin danh mục', 'Thời gian tạo', 'Số lượng mục con', 'Thao tác'], width: width, height: 50),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: directoryList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return item_ui_directory(index: index, id: directoryList[index], directoryList: directoryList, event: () { setState(() {}); },);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
