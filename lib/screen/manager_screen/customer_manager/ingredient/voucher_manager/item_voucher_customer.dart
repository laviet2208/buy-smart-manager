import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/Account/Account.dart';
import '../../../../../data/otherdata/Tool.dart';
import '../../../../../data/voucherData/Voucher.dart';
import '../../../../../general_ingredient/utils.dart';

class item_voucher_customer extends StatefulWidget {
  final int index;
  final Voucher voucher;
  final Account account;
  const item_voucher_customer({super.key, required this.index, required this.voucher, required this.account});

  @override
  State<item_voucher_customer> createState() => _item_voucher_customerState();
}

class _item_voucher_customerState extends State<item_voucher_customer> {
  bool loading = false;

  Future<void> push_voucher_data() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('Account').child(widget.account.id).set(widget.account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('cập nhật thành công');
    } catch (error) {
      toastMessage('Lỗi dữ liệu');
      Navigator.of(context).pop();
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/7*6;
    double height = 130;
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
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
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
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 5,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên sự kiện : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.eventName, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 7,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mã code : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.id, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 7,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 5,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Từ ngày : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getDayTimeString(widget.voucher.startTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tới ngày : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getDayTimeString(widget.voucher.endTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 7,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 5,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giảm giá : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: (widget.voucher.type == 1) ? (getStringNumber(widget.voucher.Money) + 'USD') : (getStringNumber(widget.voucher.Money) + '%'), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'cho đơn từ : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getStringNumber(widget.voucher.mincost) + 'USD', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giảm tối đa : ',
                            style: TextStyle(
                              fontSize: widget.voucher.type == 1 ? 0 : 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getStringNumber(widget.voucher.maxSale) + 'USD', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: widget.voucher.type == 1 ? 0 : 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
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
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đã sử dụng : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text:  widget.voucher.useCount.toString() + ' Lượt', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Giới hạn : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.maxCount.toString() + ' Lượt', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tối đa mỗi khách : ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.voucher.perCustom.toString() + ' Lượt', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'muli',
                              color: Colors.purple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 15,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 20,),
              child: ListView(
                children: [
                  Container(height: 10,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all()
                      ),
                      child: Center(
                        child: Text(
                          'Xóa voucher',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      widget.account.voucherList.removeAt(widget.index);
                      await push_voucher_data();
                      setState(() {

                      });
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
