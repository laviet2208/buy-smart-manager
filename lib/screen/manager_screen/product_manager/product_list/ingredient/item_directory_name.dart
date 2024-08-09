import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../data/product/Product.dart';
import '../../../../../data/product/ProductDirectory.dart';
import '../../../../../general_ingredient/utils.dart';
import '../action/add_new_product/controller.dart';
import '../controller.dart';

class item_directory_name extends StatefulWidget {
  final String id;
  final int index;
  final double width;
  final Product product;
  const item_directory_name({super.key, required this.id, required this.index, required this.width, required this.product});

  @override
  State<item_directory_name> createState() => _item_directory_nameState();
}

class _item_directory_nameState extends State<item_directory_name> {
  String name = 'Danh mục không tồn tại';
  bool loading = false;
  void get_type_name() {
    if (widget.id == '') {

    } else {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productDirectory").child(widget.id).child('name').onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        if (data != null) {
          name = data.toString();
        } else {
          name = 'Danh mục không tồn tại';
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
    return Container(
      width: widget.width,
      child: Row(
        children: [
          Container(
            width: widget.width - 25,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'muli',
                color: Colors.black,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Container(width: 5,),

          GestureDetector(
            child: Container(
              height: 15,
              width: 15,
              child: Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
                size: 15,
              ),
            ),
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Xác nhận xóa'),
                    content: Text('Bạn có chắc chắn muốn xóa?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Không',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

                      !loading ? TextButton(
                        onPressed: () async {
                          if (widget.product.directoryList.length > 1) {
                            setState(() {
                              loading = true;
                            });
                            ProductDirectory directory = await add_product_controller.get_directory(widget.id);
                            directory.productList.remove(widget.product.id);
                            await add_product_controller.push_new_productdirect(directory);
                            widget.product.directoryList.remove(widget.id);
                            await product_manager_controller.change_productDirectory(widget.product);
                            setState(() {
                              loading = false;
                            });
                            toastMessage('Xóa thành công');
                            Navigator.of(context).pop();
                          } else {
                            toastMessage('Không thể xóa');
                          }
                        },
                        child: Text(
                          'Đồng ý',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ) : CircularProgressIndicator(color: Colors.blueAccent,),
                    ],
                  );
                },
              );

            },
          ),
        ],
      ),
    );
  }
}
