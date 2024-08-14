import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../data/orderData/Order.dart';
import '../../../../data/orderData/Receiver.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../data/voucherData/Voucher.dart';
import '../../../../general_ingredient/text_line_in_item.dart';
import '../../../../general_ingredient/utils.dart';
import '../actions/update_status.dart';
import '../actions/view_product_list.dart';


class item_order extends StatefulWidget {
  final String id;
  final int index;
  const item_order({super.key, required this.id, required this.index});

  @override
  State<item_order> createState() => _item_orderState();
}

class _item_orderState extends State<item_order> {
  Order order = Order(id: '', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', type: 0, perCustom: 0, CustomList: [], maxSale: 0), note: '', productList: [], receiver: Receiver(name: '', nation: '', phoneNumber: '', city: '', district: '', podcode: '', province: '', address: ''), createTime: getCurrentTime(), status: '', owner: '');
  String status = '';
  Color statusColor = Colors.white;

  void get_status() {
    if (order.status == 'A') {
      status = 'Chưa xử lý';
      statusColor = Colors.orange;
    }

    if (order.status == 'B') {
      status = 'Đang xử lý';
      statusColor = Colors.orange;
    }

    if (order.status == 'C') {
      status = 'Hoàn thành';
      statusColor = Colors.blueAccent;
    }

    if (order.status == 'D') {
      status = 'Bị hủy';
      statusColor = Colors.red;
    }
  }

  void get_order() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("Order").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        print(data.toString());
        order = Order.fromJson(data);
        setState(() {
          get_status();
        });
      });
    }
  }

  Future<void> delete_order(String id) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef.child('Order').child(id).remove();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_order();
    get_status();
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

                  text_line_in_item(color: Colors.black,title: 'Tên : ', content: order.receiver.name),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black, title: 'Sđt: ', content: order.receiver.phoneNumber),


                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Địa chỉ: ', content: order.receiver.address),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Phường/Xã: ', content: order.receiver.district),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black, title: 'Quận/Huyện: ', content: order.receiver.city),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black, title: 'Tỉnh/Tp: ', content: order.receiver.province),

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

                  text_line_in_item(color: Colors.black,title: 'Mã đơn : ', content: order.id),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Thời gian tạo: ', content: getAllTimeString(order.createTime)),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Ghi chú: ', content: order.note != '' ? order.note : 'Không có'),

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

                  text_line_in_item(color: Colors.black,title: 'Giá gốc : ', content: getStringNumber(calculatetotalMoney(order)) + '.usd'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Voucher: ', content: getStringNumber(getVoucherSale(order.voucher, calculatetotalMoney(order))) + '.usd'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Thực thu: ', content: getStringNumber(calculatetotalMoney(order) - getVoucherSale(order.voucher, calculatetotalMoney(order))) + '.usd'),

                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return view_product_list(order: order,);
                        },
                      );
                    },
                    child: Text(
                      'Xem danh sách',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
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

                  text_line_in_item(color: statusColor, title: 'Trạng thái đơn : ', content: status),

                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return update_status(order: order,);
                        },
                      );
                    },
                    child: Text(
                      'Cập nhật trạng thái',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
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
            width: (width - 50)/5-1,
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
                            'Xóa đơn hàng',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Xác Nhận Xóa'),
                              content: Text('Bạn có chắc chắn muốn xóa không?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Hủy'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                ),
                                TextButton(
                                  child: Text('Xóa'),
                                  onPressed: () async {
                                    await delete_order(order.id);
                                    toastMessage("Xóa thành công");
                                    Navigator.of(context).pop(); // Đóng dialog
                                  },
                                ),
                              ],
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
        ],
      ),
    );
  }
}
