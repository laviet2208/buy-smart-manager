import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ads_manager/actions/add_new_ads/add_new_ads.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ads_manager/ingredient/item_ads.dart';

import '../../../general_ingredient/heading_title.dart';

class ads_manager_main extends StatefulWidget {
  const ads_manager_main({super.key});

  @override
  State<ads_manager_main> createState() => _ads_manager_mainState();
}

class _ads_manager_mainState extends State<ads_manager_main> {
  List<String> keyList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("adsData").onChildAdded.listen((event) {
      final dynamic key = event.snapshot.key;
      if (key != null && !keyList.contains(key)) {
        keyList.add(key.toString());
        setState(() {});
      }
    });

    reference.child("adsData").onChildRemoved.listen((event) {
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
                    '+ Thêm quảng cáo',
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
                    return add_new_ads(event: () { setState(() {}); },);
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
              width: width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: heading_title(numberColumn: 4, listTitle: ['Mã quảng cáo', 'Hình ảnh', 'Sản phẩm đại diện', 'Thao tác'], width: width, height: 50),
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
                  return item_ads(id: keyList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
