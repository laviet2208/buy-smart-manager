import 'package:flutter/material.dart';
import '../../../../../../../data/product/Product.dart';

class show_hide_product extends StatefulWidget {
  final Product product;
  const show_hide_product({super.key, required this.product});

  @override
  State<show_hide_product> createState() => _show_hide_productState();
}

class _show_hide_productState extends State<show_hide_product> {
  bool status = false;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 30,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Text(
              'Trạng thái',
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CheckboxListTile(
              title: Text('Hiển thị', style: TextStyle(fontFamily: 'muli'),),
              value: status,
              onChanged: (bool? value) {
                setState(() {
                  status = value!;
                  widget.product.showStatus = 1;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: CheckboxListTile(
              title: Text('Không hiển thị', style: TextStyle(fontFamily: 'muli'),),
              value: !status,
              onChanged: (bool? value) {
                setState(() {
                  status = !value!;
                  widget.product.showStatus = 0;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}

