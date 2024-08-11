import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../data/noticeData/noticeData.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../general_ingredient/utils.dart';
class add_notice extends StatefulWidget {
  const add_notice({super.key});

  @override
  State<add_notice> createState() => _add_noticeState();
}

class _add_noticeState extends State<add_notice> {
  bool loading = false;
  final tieudecontrol = TextEditingController();
  final tieudephucontrol = TextEditingController();
  final noidungcontrol = TextEditingController();

  Future<void> push_notice(noticeData data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('Notification').child(data.id).set(data.toJson());
      toastMessage('thêm thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/2;
    double height = MediaQuery.of(context).size.height * (2/3);
    return AlertDialog(
        title: Text('Thêm thông báo mới'),
        content: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tiêu đề thông báo *',
                  style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent
                  ),
                ),
              ),

              Container(
                height: 10,
              ),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: tieudecontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tiêu đề thông báo',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Tiêu đề phụ thông báo *',
                  style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent
                  ),
                ),
              ),

              Container(
                height: 10,
              ),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: tieudephucontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tiêu đề thông báo',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(
                height: 10,
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Nội dung thông báo *',
                  style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent
                  ),
                ),
              ),

              Container(
                height: 10,
              ),

              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        )
                    ),

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Form(
                        child: TextFormField(
                          controller: noidungcontrol,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nội dung thông báo',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'muli',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              Container(
                height: 40,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
            onPressed: () {
              tieudecontrol.clear();
              noidungcontrol.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: loading ? CircularProgressIndicator() : Text('Thêm quảng cáo'),
            onPressed: loading ? null : () async {
              if (tieudecontrol.text.isNotEmpty && noidungcontrol.text.isNotEmpty) {
                setState(() {
                  loading = true;
                });
                String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                noticeData data = noticeData(
                  id: 'TB' + id,
                  title: tieudecontrol.text.toString(),
                  sub: tieudephucontrol.text.toString(),
                  send: getCurrentTime(),
                  status: 0,
                  content: noidungcontrol.text.toString(),
                  create: getCurrentTime(),
                );
                await push_notice(data);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              } else {
                toastMessage('Nhập đủ thông tin');
              }
            },
          ),
        ]
    );
  }
}
