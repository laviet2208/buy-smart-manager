import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../general_ingredient/heading_title.dart';
import 'actions/add_new_voucher.dart';
import 'ingredient/voucher_item.dart';

class voucher_manager_main extends StatefulWidget {
  const voucher_manager_main({super.key});

  @override
  State<voucher_manager_main> createState() => _voucher_manager_mainState();
}

class _voucher_manager_mainState extends State<voucher_manager_main> {
  List<String> keyList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    int totalDataSize = 0;

    reference.child("Voucher").onChildAdded.listen((event) {
      final dynamic key = event.snapshot.key;

      if (key != null && !keyList.contains(key)) {
        keyList.add(key.toString());

        // Tính kích thước dữ liệu
        String jsonString = jsonEncode(key.toString());
        totalDataSize += utf8.encode(jsonString).length;

        setState(() {});
      }
    });

    reference.child("Voucher").onChildRemoved.listen((event) {
      final dynamic key = event.snapshot.key;

      if (key != null && keyList.contains(key)) {
        keyList.remove(key);

        // Tính kích thước dữ liệu
        String jsonString = jsonEncode(key.toString());
        totalDataSize += utf8.encode(jsonString).length;

        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                width: 210,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all()
                ),
                child: Center(
                  child: Text(
                    '+ Thêm Voucher',
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
                    return add_new_voucher();
                  },
                );
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
              child: heading_title(numberColumn: 5, listTitle: ['Thông tin sự kiện', 'Thời gian khả dụng', 'Giá trị voucher', 'Thông tin khách hàng','Thao tác',], width: width, height: 50),
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
                itemCount: keyList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return voucher_item(id: keyList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
