import 'package:flutter/material.dart';

import '../../../../data/cartData/CartData.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../general_ingredient/text_line_in_item.dart';

class item_product_in_order extends StatefulWidget {
  final Cartdata cartdata;
  final int index;
  const item_product_in_order({super.key, required this.cartdata, required this.index});

  @override
  State<item_product_in_order> createState() => _item_product_in_orderState();
}

class _item_product_in_orderState extends State<item_product_in_order> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3*2;
    double height = 150;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Mã sản phẩm: ', content: widget.cartdata.product.id),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Tên sản phẩm: ', content: widget.cartdata.product.name),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Số lượng: ', content: widget.cartdata.number.toString()),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Đơn giá: ', content: getStringNumber(widget.cartdata.product.cost) + '.usd'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Thành tiền: ', content: getStringNumber(widget.cartdata.product.cost * widget.cartdata.number) + '.usd'),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/3-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),
        ],
      ),
    );
  }
}
