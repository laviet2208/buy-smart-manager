import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../data/product/Product.dart';
import '../../../../../../../../data/product/ProductDirectory.dart';

class product_directory_search extends StatefulWidget {
  final Product product;
  final VoidCallback event;
  const product_directory_search({super.key, required this.product, required this.event});

  @override
  State<product_directory_search> createState() => _product_directory_searchState();
}

class _product_directory_searchState extends State<product_directory_search> {
  String query = '';
  final control = TextEditingController();
  List<ProductDirectory> filteredList = [];
  final List<ProductDirectory> directory_type = [];

  void get_directory_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productDirectory").onValue.listen((event) {
      directory_type.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductDirectory directory = ProductDirectory.fromJson(value);
        if (!widget.product.directoryList.contains(directory.id)) {
          directory_type.add(directory);
          filteredList = directory_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_directory_data();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          TextField(
            controller: control,
            onChanged: (value) {
              setState(() {
                query = value;
                filteredList = directory_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
              });
            },
            decoration: InputDecoration(
              labelText: 'Tìm kiếm danh mục sản phẩm',
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
                    onTap: () {
                      control.text = filteredList[index].name;
                      widget.product.directoryList.add(filteredList[index].id);
                      // setState(() {
                      //
                      // });
                      widget.event();
                      // Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
