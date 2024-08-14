import 'package:flutter/material.dart';
import '../../../../../data/Account/Account.dart';
import '../../../../../data/otherdata/Tool.dart';
import '../../../../../general_ingredient/text_line_in_item.dart';
import '../../actions/change_account_money.dart';
import '../../actions/view_account_info.dart';
import '../chat_manager/chat_room/chat_room.dart';
import '../voucher_manager/voucher_manager.dart';

class item_customer_search extends StatefulWidget {
  final Account account;
  final int index;
  const item_customer_search({super.key, required this.account, required this.index});

  @override
  State<item_customer_search> createState() => _item_customer_searchState();
}

class _item_customer_searchState extends State<item_customer_search> {
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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Mã KH: ', content: widget.account.id),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Email : ', content: widget.account.username),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black, title: 'Mật khẩu: ', content: widget.account.password),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Số dư: ', content: getStringNumber(widget.account.money) + '.usd'),

                  Container(height: 4,),
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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Tên KH : ', content: widget.account.firstName + ' ' + widget.account.lastName),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Địa chỉ: ', content: widget.account.address != '' ? widget.account.address : 'Chưa nhập'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Sđt: ', content: widget.account.phoneNum != '' ? widget.account.phoneNum : 'Chưa nhập'),

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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: widget.account.lockstatus == 0 ? Colors.red : Colors.green, title: 'Trạng thái : ', content: widget.account.lockstatus == 0 ? 'Tài khoản đang khóa' : 'Tài khoản đang mở'),

                  Container(height: 8,),

                  TextButton(
                    onPressed: () {

                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Khóa, mở tài khoản',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return change_account_money(account: widget.account);
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cộng, trừ tiền',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
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
            width: (width - 50)/4-1,
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
                            'Thông tin chi tiết',
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
                            return view_account_info(account: widget.account);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 4,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Quản lý voucher',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return voucher_manager(account: widget.account);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 4,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                              width: 1,
                              color: Colors.black
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Chat với KH',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                width: 400,
                                height: 800,
                                child: chatRoomScreen(account: widget.account),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {Navigator.of(context).pop();},
                                  child: Text('Đóng'),
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
