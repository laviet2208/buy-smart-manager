import 'package:flutter/material.dart';

class text_line_in_item extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  const text_line_in_item({super.key, required this.title, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SelectableText.rich(
        TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'muli',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: content,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'muli',
                color: color,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
