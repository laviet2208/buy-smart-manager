import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/product/Product.dart';
import '../../../../../../data/product/ProductType.dart';
import '../../../../../../general_ingredient/utils.dart';
import '../../controller.dart';
import '../add_new_product/controller.dart';

class change_product_type extends StatefulWidget {
  final Product product;
  const change_product_type({super.key, required this.product,});

  @override
  State<change_product_type> createState() => _change_product_typeState();
}

class _change_product_typeState extends State<change_product_type> {
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
        if (type.id != widget.product.productType) {
          list_type.add(type);
          filteredList = list_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
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
                filteredList = list_type.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
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
                    onTap: () async {
                      toastMessage('Vui lòng chờ');
                      control.text = filteredList[index].name;
                      ProductType type = await add_product_controller.get_type(widget.product.productType);
                      type.productList.remove(widget.product.id);
                      await add_product_controller.push_new_producttype(type);
                      widget.product.productType = filteredList[index].id;
                      filteredList[index].productList.add(widget.product.id);
                      await add_product_controller.push_new_producttype(filteredList[index]);
                      await product_manager_controller.change_productType(widget.product);
                      setState(() {

                      });
                      Navigator.of(context).pop();
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
