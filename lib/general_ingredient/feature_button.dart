import 'package:flutter/material.dart';

class feature_button extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback event;
  const feature_button({super.key, required this.title, required this.textColor, required this.backgroundColor, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
                width: 1,
                color: textColor,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
        onTap: event,
      ),
    );
  }
}
