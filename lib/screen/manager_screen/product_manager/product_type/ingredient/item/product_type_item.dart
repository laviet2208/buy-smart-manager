import 'package:flutter/material.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/ProductType.dart';
import '../../../../../../general_ingredient/text_line_in_item.dart';
import '../../actions/change_product_type_name/change_product_type_name.dart';
import '../view_product_list/brand_view_product_list.dart';

class product_type_item extends StatefulWidget {
  final ProductType type;
  final int index;
  const product_type_item({super.key, required this.type, required this.index});

  @override
  State<product_type_item> createState() => _product_type_itemState();
}

class _product_type_itemState extends State<product_type_item> {
  @override
  Widget build(BuildContext context) {
    double height = 70;
    double width = MediaQuery.of(context).size.width - 20;

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
                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Tên phân loại: ', content: widget.type.name),

                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Số sản phẩm loại này: ', content: widget.type.productList.length.toString()),

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
                  Container(height: 10,),

                  text_line_in_item(color: Colors.black,title: 'Thời gian tạo: ', content: getAllTimeString(widget.type.createTime)),

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
            width: (width - 50)/3-10,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    child: Container(
                      width: ((width - 50)/3 - 11 - 20)/2 - 5,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Danh sách sản phẩm',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.all(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            title: Text('Danh sách sản phẩm trong ' + widget.type.name),
                            content: type_view_product_list(id: widget.type.id, productType: widget.type,),
                          );
                        },
                      );
                    },
                  ),

                  Container(width: 10,),

                  GestureDetector(
                    child: Container(
                      width: ((width - 50)/3 - 11 - 20)/2 - 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return change_product_type_name(type: widget.type);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
