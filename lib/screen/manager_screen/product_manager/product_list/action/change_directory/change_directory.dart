import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/product/Product.dart';
import '../../../../../../data/product/ProductDirectory.dart';
import '../../../../../../general_ingredient/utils.dart';
import '../../controller.dart';
import '../add_new_product/controller.dart';

class change_directory extends StatefulWidget {
  final Product product;
  const change_directory({super.key, required this.product});

  @override
  State<change_directory> createState() => _change_directoryState();
}

class _change_directoryState extends State<change_directory> {
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
                    onTap: () async {
                      toastMessage('Vui lòng đợi');
                      control.text = filteredList[index].name;
                      widget.product.directoryList.add(filteredList[index].id);
                      filteredList[index].productList.add(widget.product.id);
                      await add_product_controller.push_new_productdirect(filteredList[index]);
                      await product_manager_controller.change_productDirectory(widget.product);
                      setState(() {

                      });
                      toastMessage('Thêm thành công');
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
