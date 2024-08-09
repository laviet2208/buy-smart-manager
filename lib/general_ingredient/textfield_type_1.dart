import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield_type_1 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const textfield_type_1({super.key, required this.title, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: 'muli',
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),

        SizedBox(height: 8),

        Container(
          height: 40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.grey,
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: CupertinoTextField(
              controller: controller,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'muli',
              ),
              placeholder: hint,
              placeholderStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: 'muli',
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
