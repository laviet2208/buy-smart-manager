import 'package:flutter/material.dart';

import '../../../../../../../data/chatData/messenger.dart';

class Item_messenger extends StatefulWidget {
  final messenger mes;
  const Item_messenger({Key? key, required this.mes}) : super(key: key);

  @override
  State<Item_messenger> createState() => _Item_messengerState();
}

class _Item_messengerState extends State<Item_messenger> {

  @override
  Widget build(BuildContext context) {
    double width = 400;
    return Container(
      width: width,
      child:Row(
        mainAxisAlignment: widget.mes.type == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width*2/3, // Đặt giới hạn chiều rộng của container là 200
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.mes.type != 1 ? Colors.grey.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                widget.mes.content,
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
