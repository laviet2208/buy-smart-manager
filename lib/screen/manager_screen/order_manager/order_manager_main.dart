import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../general_ingredient/heading_title.dart';
import 'ingredient/item_order.dart';

class order_manager_main extends StatefulWidget {
  const order_manager_main({super.key});

  @override
  State<order_manager_main> createState() => _order_manager_mainState();
}

class _order_manager_mainState extends State<order_manager_main> {
  List<String> keyList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Order").onChildAdded.listen((event) {
      final dynamic key = event.snapshot.key;
      if (key != null && !keyList.contains(key)) {
        keyList.add(key.toString());
        setState(() {});
      }
    });
    reference.child("Order").onChildRemoved.listen((event) {
      final dynamic key = event.snapshot.key;
      if (key != null && keyList.contains(key)) {
        keyList.remove(key);
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
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all()
                ),
                child: Center(
                  child: Text(
                    '+ Tạo thủ công',
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

              },
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              width: width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: heading_title(numberColumn: 5, listTitle: ['Thông tin khách hàng', 'Thông tin đơn', 'Giá trị', 'Trạng thái', 'Thao tác'], width: width, height: 50),
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
                  return item_order(id: keyList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
