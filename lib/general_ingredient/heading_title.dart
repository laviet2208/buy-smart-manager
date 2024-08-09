import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class heading_title extends StatelessWidget {
  final int numberColumn;
  final List<String> listTitle;
  final double width;
  final double height;
  const heading_title({super.key, required this.numberColumn, required this.listTitle, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 250, 255),
          border: Border.all(
              width: 0.5,
              color: Color.fromARGB(255, 225, 225, 226)
          )
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: width - 50,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listTitle.length,
              itemBuilder: (context, index) {
                return Container(
                  width: (width - 50)/(listTitle.length.toDouble()),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: (width - 50)/(listTitle.length.toDouble()) - 1,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                              child: AutoSizeText(
                                listTitle[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'muli',
                                    color: Colors.black,
                                    fontSize: 100
                                ),
                              )
                          ),
                        ),
                      ),

                      Container(
                        width: 1,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 225, 226)
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}