import 'package:flutter/material.dart';

class feature_type_1 extends StatelessWidget {
  int selectButton;
  int thisIndex;
  String title;
  feature_type_1({required this.selectButton, required this.title, required this.thisIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: (selectButton == thisIndex) ? Colors.red : Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
