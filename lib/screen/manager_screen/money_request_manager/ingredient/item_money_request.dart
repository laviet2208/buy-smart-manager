import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/Account/Account.dart';
import 'package:lyshoppingmanager/data/MoneyRequest/MoneyRequest.dart';
import 'package:lyshoppingmanager/data/otherdata/Tool.dart';
import 'package:lyshoppingmanager/screen/manager_screen/money_request_manager/actions/handle_deny_request.dart';
import '../../../../general_ingredient/text_line_in_item.dart';
import '../actions/handle_accept_request.dart';

class item_money_request extends StatefulWidget {
  final String id;
  final int index;
  const item_money_request({super.key, required this.id, required this.index});

  @override
  State<item_money_request> createState() => _item_money_requestState();
}

class _item_money_requestState extends State<item_money_request> {
  MoneyRequest moneyRequest = MoneyRequest(id: '', owner: Account(id: '', username: '', password: '', address: '', createTime: getCurrentTime(), money: 0, firstName: '', lastName: '', phoneNum: '', lockstatus: 0, voucherList: []), status: '', createTime: getCurrentTime(), money: 0, type: 0);
  String status = '';
  Color statusColor = Colors.white;

  void get_status() {
    if (moneyRequest.status == 'A') {
      status = 'Chưa xử lý';
      statusColor = Colors.orange;
    }

    if (moneyRequest.status == 'B') {
      status = 'Đã duyệt';
      statusColor = Colors.green;
    }

    if (moneyRequest.status == 'C') {
      status = 'Từ chối duyệt';
      statusColor = Colors.redAccent;
    }
  }

  void get_request() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("MoneyRequest").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        moneyRequest = MoneyRequest.fromJson(data);
        setState(() {
          get_status();
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_request();
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
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Mã tài khoản : ', content: moneyRequest.owner.id),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black, title: 'Tên tài khoản: ', content: moneyRequest.owner.firstName + ' ' + moneyRequest.owner.lastName),

                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Email: ', content: moneyRequest.owner.username),

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

                  text_line_in_item(color: Colors.black,title: 'Mã yêu cầu : ', content: moneyRequest.id),

                  Container(height: 8,),

                  text_line_in_item(color: moneyRequest.type == 1 ? Colors.green : Colors.red, title: 'Loại yêu cầu: ', content: moneyRequest.type == 1 ? 'Yêu cầu nạp' : 'Yêu cầu rút'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black,title: 'Số tiền yêu cầu: ', content: getStringNumber(moneyRequest.money) + ' .USDT'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Thời gian tạo: ', content: getAllTimeString(moneyRequest.createTime)),

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
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: statusColor,
                    width: 2
                  ),
                ),
                child: Center(
                  child: Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'muli',
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
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

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Xóa yêu cầu',
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
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Xóa'),
                                  onPressed: () async {
                                    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
                                    await databaseRef.child('MoneyRequest').child(widget.id).remove();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 10,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: moneyRequest.status == 'A' ? 30 : 0,
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'Phê duyệt yêu cầu',
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
                            return handle_accept_request(moneyRequest: moneyRequest);
                          },
                        );
                      },
                    ),
                  ),

                  Container(height: 10,),

                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: GestureDetector(
                      child: Container(
                        height: moneyRequest.status == 'A' ? 30 : 0,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                          child: Text(
                            'Từ chối yêu cầu',
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
                            return handle_deny_request(moneyRequest: moneyRequest);
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
