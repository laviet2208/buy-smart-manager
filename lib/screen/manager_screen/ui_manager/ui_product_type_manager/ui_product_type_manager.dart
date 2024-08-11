import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../data/product/ProductType.dart';
import '../../../../general_ingredient/heading_title.dart';
import 'actions/type_ui_search.dart';
import 'ingredients/demo_area_type.dart';
import 'ingredients/item_ui_type.dart';

class ui_product_type_manager extends StatefulWidget {
  const ui_product_type_manager({super.key});

  @override
  State<ui_product_type_manager> createState() => _ui_product_type_managerState();
}

class _ui_product_type_managerState extends State<ui_product_type_manager> {
  final List<String> typeList = [];
  ProductType productType = ProductType(id: '', createTime: getCurrentTime(), name: '', productList: []);
  String url = '';
  Future<void> get_product_type(String id) async {
    if (id != '') {
      final reference = FirebaseDatabase.instance.ref();
      await reference.child("productType").child(id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        productType = ProductType.fromJson(data);
        setState(() {

        });
      });
      await _getImageURL();
    }
  }

  Future<void> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('productType').child(productType.id + '.png');
    url = await ref.getDownloadURL();
    setState(() {

    });
  }

  void get_type_ui() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child('UI').child('productType').onValue.listen((event) {
      typeList.clear();
      final dynamic orders = event.snapshot.value;
      for (final result in orders) {
        String id = result.toString();
        typeList.add(id);
      }
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_type_ui();
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
                    '+ Thêm phân loại hiển thị',
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
                    return type_ui_search(event: () { setState(() {}); }, idList: typeList,);
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            child: Container(
              width: width/2,
              height: 50,
              child: heading_title(numberColumn: 3, listTitle: ['Mã phân loại', 'Tên phân loại', 'Thao tác'], width: width/2, height: 50),
            ),
          ),

          Positioned(
            top: 100,
            bottom: 0,
            left: 0,
            child: Container(
              width: width/2,
              child: ListView.builder(
                itemCount: typeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: item_ui_type(id: typeList[index], index: index, typeList: typeList, event: () async {
                      await get_product_type(typeList[index]);
                      await _getImageURL();
                      setState(() {

                      });
                    },),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: width/2 + 100,
            right: 100,
            child: Container(
              height: 20,
              alignment: Alignment.center,
              child: AutoSizeText(
                'Phần DEMO các phân loại sản phẩm',
                style: TextStyle(
                  fontFamily: 'muli',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 100,
                ),
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: width/2 + 100,
            right: 100,
            child: Container(
              height: 360,
              alignment: Alignment.center,
              child: demo_area_type(productType: productType, url: url),
            ),
          ),
        ],
      ),
    );
  }
}
