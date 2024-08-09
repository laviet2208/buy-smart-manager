import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../data/product/ProductType.dart';
import '../../../../general_ingredient/heading_title.dart';
import 'actions/add_new_product_type/add_new_product_type.dart';
import 'ingredient/item/product_type_item.dart';

class product_type_main_manager extends StatefulWidget {
  const product_type_main_manager({super.key});

  @override
  State<product_type_main_manager> createState() => _product_type_main_managerState();
}

class _product_type_main_managerState extends State<product_type_main_manager> {
  final searchController = TextEditingController();
  List<ProductType> typeList = [];
  List<ProductType> chosenList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productType").onValue.listen((event) {
      typeList.clear();
      chosenList.clear();
      setState(() {

      });
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductType directory = ProductType.fromJson(value);
        typeList.add(directory);
        chosenList.add(directory);
      });
      setState(() {

      });
    });
  }

  void sortChosenListByCreateTime(List<ProductType> chosenList) {
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

  void sortChosenListByName(List<ProductType> chosenList) {
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
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 305,
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
                    '+ Thêm phân loại sản phẩm',
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
                    return add_new_product_type(event: () { setState(() {}); },);
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  // _searchItems(value.toString());
                  // print('chiều dài search: ' + _searchitems.length.toString());
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm phân loại sản phẩm',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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
              child: heading_title(numberColumn: 3, listTitle: ['Tên phân loại sản phẩm', 'Thời gian tạo', 'Thao tác'], width: width, height: 50),
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
                  return product_type_item(type: chosenList[index], index: index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}