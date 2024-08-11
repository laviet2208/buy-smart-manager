import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/product/ProductType.dart';

class demo_area_type extends StatelessWidget {
  final ProductType productType;
  final String url;
  const demo_area_type({super.key, required this.productType, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 60,),

          Padding(
            padding: EdgeInsets.only(left: 60, right: 60),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(url),
                ),
              ),
            ),
          ),

          SizedBox(height: 24,),

          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Container(
              height: 45,
              child: AutoSizeText(
                productType.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'sf',
                  color: Colors.grey,
                  fontSize: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

