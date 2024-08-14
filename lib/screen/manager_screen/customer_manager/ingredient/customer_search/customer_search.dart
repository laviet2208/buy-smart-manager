import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/screen/manager_screen/customer_manager/ingredient/customer_search/item_customer_search.dart';

import '../../../../../data/Account/Account.dart';
import '../../../../../general_ingredient/heading_title.dart';
import '../item_customer.dart';

class customer_search extends StatefulWidget {
  const customer_search({super.key});

  @override
  State<customer_search> createState() => _customer_searchState();
}

class _customer_searchState extends State<customer_search> {
  List<Account> accountList = [];
  List<Account> chosenList = [];
  TextEditingController searchController = TextEditingController();

  void get_user_list() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("Account").onValue.listen((event) {
      accountList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountList.add(Account.fromJson(value));
      });
      setState(() {

      });
    });
  }

  // Future<void> get_user_list() async {
  //   final reference = FirebaseDatabase.instance.ref();
  //   DatabaseEvent snapshot = await reference.child("Account").once();
  //   final dynamic data = snapshot.snapshot.value;
  //   accountList.clear();
  //   data.forEach((key, value) {
  //     accountList.add(Account.fromJson(value));
  //     print(accountList.length);
  //   });
  //   setState(() {
  //
  //   });
  // }

  void on_search_text_changed(String value) {
    setState(() {
      chosenList = accountList.where((account) => account.username.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user_list();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/7*6;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height/5*4,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: (width)/2,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: on_search_text_changed,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'muli',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm theo email',
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
              top: 50,
              left: 0,
              right: 0,
              child: heading_title(numberColumn: 4, listTitle: ['Thông tin tài khoản','Thông tin khách hàng','Trạng thái','Thao tác'], width: width, height: 50,),
            ),

            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                  itemCount: chosenList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return item_customer_search(account: chosenList.reversed.toList()[index], index: index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
