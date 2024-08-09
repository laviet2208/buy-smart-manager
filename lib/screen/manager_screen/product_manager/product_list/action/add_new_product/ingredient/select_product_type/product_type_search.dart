import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../data/product/Product.dart';
import '../../../../../../../../data/product/ProductType.dart';

class product_type_search extends StatefulWidget {
  final Product product;
  final VoidCallback event;
  const product_type_search({super.key, required this.product, required this.event});

  @override
  State<product_type_search> createState() => _product_type_searchState();
}

class _product_type_searchState extends State<product_type_search> {
  String query = '';
  final control = TextEditingController();
  List<ProductType> filteredList = [];
  final List<ProductType> list_type = [];

  void get_type_data() {
    final reference = FirebaseDatabase.instance.ref();
    reference.child("productType").onValue.listen((event) {
      list_type.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ProductType type = ProductType.fromJson(value);
        list_type.add(type);
        filteredList = list_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_type_data();
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
              });
            },
            decoration: InputDecoration(
              labelText: 'Tìm kiếm loại sản phẩm',
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
                      widget.product.productType = filteredList[index].id;
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
