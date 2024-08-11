import 'package:flutter/material.dart';

import '../../../../data/noticeData/noticeData.dart';
import '../../../../data/otherdata/Tool.dart';
import '../../../../general_ingredient/text_line_in_item.dart';

class item_notice extends StatefulWidget {
  final int index;
  final noticeData notice;
  const item_notice({super.key, required this.index, required this.notice});

  @override
  State<item_notice> createState() => _item_noticeState();
}

class _item_noticeState extends State<item_notice> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    return Container(
      height: 150,
      width: width,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
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
                  Container(height: 15,),

                  text_line_in_item(title: 'Tiêu đề: ', content: widget.notice.title, color: Colors.black),

                  Container(height: 15,),

                  text_line_in_item(title: 'Tiêu đề phụ: ', content: widget.notice.sub, color: Colors.black),

                  Container(height: 15,),
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
                  Container(height: 15,),

                  text_line_in_item(title: 'Nội dung thông báo: ', content: widget.notice.content, color: Colors.black),

                  Container(height: 15,),
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
                  Container(height: 15,),

                  text_line_in_item(title: 'Ngày khởi tạo: ', content: getAllTimeString(widget.notice.create), color: Colors.black),

                  Container(height: 10,),

                  text_line_in_item(title: 'Gửi lần cuối: ', content: getAllTimeString(widget.notice.send), color: Colors.black),

                  Container(height: 10,),

                  text_line_in_item(title: 'Trạng thái: ', content: widget.notice.status == 1 ? 'Chưa đẩy' : 'Đang thông báo', color: widget.notice.status == 1 ? Colors.redAccent : Colors.green),

                  Container(height: 20,),
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
                  Container(height: 5,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Cập nhật thông báo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {

                    },
                  ),

                  Container(height: 5,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                      ),
                      child: Center(
                        child: Text(
                          'Xóa thông báo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {

                    },
                  ),

                  Container(height: 5,),

                  GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Đẩy,dừng thông báo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(height: 5,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
