import 'package:flutter/material.dart';
import '../../../../../../../../data/product/Product.dart';
import 'item_directory_select.dart';
import 'product_directory_search.dart';

class select_product_directory extends StatefulWidget {
  final Product product;
  const select_product_directory({super.key, required this.product});

  @override
  State<select_product_directory> createState() => _select_product_directoryState();
}

class _select_product_directoryState extends State<select_product_directory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return Container(
      width: width/4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh mục sản phẩm',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.product.directoryList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: item_directory_select(id: widget.product.directoryList[index], event: () {
                      widget.product.directoryList.removeAt(index);
                      setState(() {

                      });
                    },),
                  );
                },
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Thêm danh mục sản phẩm'),
                        content: Container(
                          width: 400,
                          height: 300,
                          child: product_directory_search(product: widget.product, event: () {setState(() {});  Navigator.of(context).pop();},),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  '+ Thêm danh mục sản phẩm',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
