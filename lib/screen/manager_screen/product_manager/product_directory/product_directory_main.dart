import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/product/ProductDirectory.dart';
import '../../../../general_ingredient/heading_title.dart';
import 'actions/add_new_prodcut_directory/add_new_product_directory.dart';
import 'ingredient/item/product_directory_item.dart';

class product_directory_main extends StatefulWidget {
  const product_directory_main({super.key});

  @override
  State<product_directory_main> createState() => _product_directory_mainState();
}

class _product_directory_mainState extends State<product_directory_main> {
  List<ProductDirectory> directList = [];
  List<ProductDirectory> chosenList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productDirectory").onValue.listen((event) {
      directList.clear();
      chosenList.clear();
      setState(() {

      });
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductDirectory directory = ProductDirectory.fromJson(value);
        directList.add(directory);
        chosenList.add(directory);
      });
      setState(() {

      });
    });
  }

  void sortChosenListByCreateTime(List<ProductDirectory> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
    });
  }

  void sortChosenListByName(List<ProductDirectory> chosenList) {
    chosenList.sort((a, b) {
      return a.name.compareTo(b.name);
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
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: width,
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
                    '+ Thêm danh mục sản phẩm',
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
                    return add_new_product_directory(event: () {
                      setState(() {

                      });
                    });
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
                itemCount: chosenList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return product_directory_item(directory: chosenList[index], index: index, id: chosenList[index].id,);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
