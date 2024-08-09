import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../data/product/Product.dart';
import '../../../../../general_ingredient/utils.dart';

class product_search_ads extends StatefulWidget {
  final String id;
  const product_search_ads({super.key, required this.id});

  @override
  State<product_search_ads> createState() => _product_search_adsState();
}

class _product_search_adsState extends State<product_search_ads> {
  String query = '';
  bool loading = false;
  final control = TextEditingController();
  List<Product> filteredList = [];
  final List<Product> product_list = [];

  void get_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productList").onValue.listen((event) {
      product_list.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product product = Product.fromJson(value);
        if (product.showStatus != 0) {
          product_list.add(product);
          filteredList = product_list.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  Future<void> change_product(String title) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('adsData').child(widget.id).child('productId').set(title);
      setState(() {
        loading = false;
      });
      toastMessage('Cập nhật thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_data();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chọn sản phẩm của quảng cáo'),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        child: Column(
          children: [
            TextField(
              controller: control,
              onChanged: (value) {
                setState(() {
                  query = value;
                  filteredList = product_list.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Tìm kiếm sản phẩm',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ListTile(
                      title: Text(filteredList[index].name),
                      onTap: () async {
                        control.text = filteredList[index].name;
                        toastMessage('vui lòng chờ');
                        setState(() {

                        });
                        await change_product(filteredList[index].id);
                        Navigator.of(context).pop();
                        // widget.product.directoryList.add(filteredList[index].id);
                        // setState(() {
                        //
                        // });
                        // widget.event();
                        // Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Đóng',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}