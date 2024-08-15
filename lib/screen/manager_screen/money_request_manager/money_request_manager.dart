import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/screen/manager_screen/money_request_manager/ingredient/item_money_request.dart';

import '../../../general_ingredient/heading_title.dart';

class money_request_manager extends StatefulWidget {
  const money_request_manager({super.key});

  @override
  State<money_request_manager> createState() => _money_request_managerState();
}

class _money_request_managerState extends State<money_request_manager> {
  List<String> keyList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("MoneyRequest").onChildAdded.listen((event) {
      final dynamic key = event.snapshot.key;
      if (key != null && !keyList.contains(key)) {
        keyList.add(key.toString());
        setState(() {});
      }
    });
    reference.child("MoneyRequest").onChildRemoved.listen((event) {
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
            right: 0,
            child: heading_title(numberColumn: 4, listTitle: ['Thông tin khách hàng','Thông tin yêu cầu','Trạng thái','Thao tác'], width: width, height: 50,),
          ),

          Positioned(
            top: 50,
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
                  return item_money_request(id: keyList.reversed.toList()[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
