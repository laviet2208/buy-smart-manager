import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield_type_2 extends StatelessWidget {
  final TextStyle titleStyle;
  final TextStyle hintStyle;
  final TextStyle edittextStyle;
  final bool readOnly;
  final int maxLine;
  final VoidCallback onchange;
  final double textfieldHeight;
  final String title;
  final String hint;
  final TextEditingController controller;
  const textfield_type_2({super.key, required this.titleStyle, required this.hintStyle, required this.readOnly, required this.maxLine, required this.onchange, required this.textfieldHeight, required this.title, required this.hint, required this.controller, required this.edittextStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),

        SizedBox(height: 8),

        Container(
          height: textfieldHeight,
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
              style: edittextStyle,
              maxLines: maxLine == 0 ? null : maxLine,
              readOnly: readOnly,
              placeholder: hint,
              placeholderStyle: hintStyle,
              onChanged: (value) {
                onchange();
              },
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
