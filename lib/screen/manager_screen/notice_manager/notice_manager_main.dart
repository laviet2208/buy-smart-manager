import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../data/noticeData/noticeData.dart';
import '../../../general_ingredient/heading_title.dart';
import 'ingredient/add_notice.dart';
import 'ingredient/item_notice.dart';

class notice_manager_main extends StatefulWidget {
  const notice_manager_main({super.key});

  @override
  State<notice_manager_main> createState() => _notice_manager_mainState();
}

class _notice_manager_mainState extends State<notice_manager_main> {
  List<noticeData> noticeList = [];
  List<noticeData> chosenList = [];
  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = noticeList
          .where((account) =>
      account.title.toLowerCase().contains(value.toLowerCase()) ||
          account.sub.toLowerCase().contains(value.toLowerCase()) ||
          account.content.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void get_notice_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Notification").onValue.listen((event) {
      noticeList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        noticeList.add(noticeData.fromJson(value));
        chosenList.add(noticeData.fromJson(value));
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_notice_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    double height = MediaQuery.of(context).size.height - 60;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 0,
            child: Container(
              width: 250,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm thông báo',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'muli',
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 10,
            left: 260,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.yellow,
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 11, bottom: 11),
                  child: Text(
                    'Tạo thông báo',
                    style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return add_notice();
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 80,
            left: 0,
            child: heading_title(numberColumn: 4, listTitle: ['Tiêu đề', 'Nội dung', 'Thời gian','Thao tác'], width: width, height: 50),
          ),

          Positioned(
            top: 130,
            bottom: 0,
            left: 0,
            right: 0,
            child: ListView.builder(
              itemCount: chosenList.length,
              itemBuilder: (context, index) {
                return item_notice(notice: chosenList[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
