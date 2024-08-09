import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../data/product/Product.dart';
import 'product_type_search.dart';

class select_product_type extends StatefulWidget {
  final Product product;
  const select_product_type({super.key, required this.product,});

  @override
  State<select_product_type> createState() => _select_product_typeState();
}

class _select_product_typeState extends State<select_product_type> {
  String productType = 'Chưa chọn phân loại sản phẩm';
  void get_type_name() {
    if (widget.product.productType == '') {

    } else {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productType").child(widget.product.productType).child('name').onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        if (data != null) {
          productType = data.toString();
        } else {
          productType = 'Chưa chọn phân loại sản phẩm';
        }
        setState(() {

        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_type_name();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;

    return Container(
      width: width/4,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // màu của shadow
            spreadRadius: 5, // bán kính của shadow
            blurRadius: 7, // độ mờ của shadow
            offset: Offset(0, 3), // vị trí của shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Text(
              'Phân loại sản phẩm',
              style: TextStyle(
                fontFamily: 'muli',
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Phân loại sản phẩm: ',
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    TextSpan(
                      text: productType,
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ]
              ),
            ),
          ),

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Chọn phân loại sản phẩm'),
                        content: Container(
                          width: 400,
                          height: 300,
                          child: product_type_search(product: widget.product, event: () {setState(() {get_type_name();});  Navigator.of(context).pop();},),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Chọn phân loại sản phẩm',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),

          Container(height: 10,),
        ],
      ),
    );
  }
}
