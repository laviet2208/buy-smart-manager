import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/otherdata/Time.dart';
import '../../../../../data/otherdata/Tool.dart';
import '../../../../../data/product/Product.dart';
import '../../../../../general_ingredient/text_line_in_item.dart';
import '../action/change_directory/change_directory.dart';
import '../action/change_name_and_description/change_name_and_description.dart';
import '../action/change_product_cost/change_product_cost.dart';
import '../action/change_product_type/change_product_type.dart';
import '../action/change_sub_description/change_sub_description.dart';
import '../controller.dart';
import 'item_directory_name.dart';

class item_product extends StatefulWidget {
  final String id;
  final int index;
  const item_product({super.key, required this.index, required this.id});

  @override
  State<item_product> createState() => _item_productState();
}

class _item_productState extends State<item_product> {
  String productType = 'Lỗi tên phân loại';
  Product product = Product(id: generateID(15), name: '', productType: '', showStatus: 0, createTime: getCurrentTime(), description: '', directoryList: [], cost: 0, costBeforeSale: 0, inventory: 0, saleLimit: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), subdescription: '', viName: '');

  void get_product() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();

      reference.child("productList").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        product = Product.fromJson(data);
        get_type_name();
        setState(() {

        });
      });
    }
  }

  void get_type_name() {
    if (product.productType != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productType").child(product.productType).child('name').onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        productType = data.toString();
        setState(() {

        });
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product();
    get_type_name();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Mã sản phẩm: ', content: product.id),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Tên sản phẩm: ', content: product.name),

                  Container(height: 8,),

                  text_line_in_item(color: product.showStatus == 0 ? Colors.redAccent : Colors.blueAccent, title: 'Trạng thái hiển thị: ', content: product.showStatus == 0 ? 'Đang ẩn' : 'Đang hiện'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Tạo lúc: ', content: getAllTimeString(product.createTime)),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Số lượng tồn kho: ', content: product.inventory.toString()),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Giá tiền thực: ', content: getStringNumber(product.cost) + '.usdt'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Giá tiền trước giảm: ', content: getStringNumber(product.costBeforeSale) + '.usdt'),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text(
                        'Cập nhật giá tiền',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_product_cost(product: product);
                          },
                        );
                      },
                    ),
                  ),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Phân loại: ', content: productType),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text(
                        'Sửa phân loại',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Chọn phân loại sản phẩm'),
                              content: Container(
                                width: 400,
                                height: 300,
                                child: change_product_type(product: product,),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text(
                        'Sửa nhà cung cấp',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return AlertDialog(
                        //       title: Text('Chọn nhà cung cấp'),
                        //       content: Container(
                        //         width: 400,
                        //         height: 300,
                        //         child: change_product_brand(product: product,),
                        //       ),
                        //     );
                        //   },
                        // );
                      },
                    ),
                  ),

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
            width: (width - 50)/5-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: product.directoryList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: item_directory_name(id: product.directoryList[index], index: index, width: ((width - 50)/5-1) - 20, product: product,),
                        );
                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      child: Text(
                        'Thêm danh mục',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Thêm danh mục sản phẩm'),
                              content: Container(
                                width: 400,
                                height: 300,
                                child: change_directory(product: product,),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
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
            width: (width - 50)/5 - 10,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cập nhật nội dung',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_name_and_description(product: product);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 8,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cập nhật nội dung phụ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return change_sub_description(product: product);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 8,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Text(
                            product.showStatus == 0 ? 'Hiện sản phẩm' : 'Ẩn sản phẩm',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (product.showStatus == 0) {
                          product.showStatus = 1;
                          await product_manager_controller.change_productShowStatus(product);
                        } else {
                          product.showStatus = 0;
                          await product_manager_controller.change_productShowStatus(product);
                        }
                      },
                    ),
                  ),

                  Container(height: 8,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Colors.red
            ),
          ),
        ],
      ),
    );
  }
}
