import 'package:flutter/material.dart';

import '../../../../data/orderData/Order.dart';
import '../../../../general_ingredient/heading_title.dart';
import '../ingredient/item_product_in_order.dart';

class view_product_list extends StatefulWidget {
  final Order order;
  const view_product_list({super.key, required this.order});

  @override
  State<view_product_list> createState() => _view_product_listState();
}

class _view_product_listState extends State<view_product_list> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3*2;
    double height = MediaQuery.of(context).size.height/3*2;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Danh sách sản phẩm'),
      content: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Container(
              height: 50,
              child: heading_title(numberColumn: 3, listTitle: ['Thông tin sp', 'Giá trị', 'Thao tác'], width: width, height: 50),
            ),

            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.order.productList.length,
                  itemBuilder: (context, index) {
                    return item_product_in_order(cartdata: widget.order.productList[index], index: index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
