import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../../../../../../data/product/Product.dart';
import '../../../../../../general_ingredient/rich_text_editor_type_1.dart';
import '../../../../../../general_ingredient/utils.dart';
import '../../controller.dart';

class change_sub_description extends StatefulWidget {
  final Product product;
  const change_sub_description({super.key, required this.product});

  @override
  State<change_sub_description> createState() => _change_sub_descriptionState();
}

class _change_sub_descriptionState extends State<change_sub_description> {
  bool loading = false;
  QuillEditorController controller = QuillEditorController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width1 = MediaQuery.of(context).size.width - 60;
    double height = MediaQuery.of(context).size.height - 50;

    return AlertDialog(
      title: Text('Cập nhật nội dung phụ'),
      content: Container(
        width: width1/2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nội dung phụ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'muli',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: height - 300,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    )
                ),
                child: rich_text_editor_type_1(controller: controller, height: height - 300,),
              ),
            ),

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await controller.setText(widget.product.subdescription);
            toastMessage('load thành công');
          },
          child: Text(
            'Load nội dung ban đầu',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),

        !loading ? TextButton(
          onPressed: () async {
            if (loading) {

            } else {
              setState(() {
                loading = true;
              });
              widget.product.subdescription = await controller.getText();
              await product_manager_controller.change_productSubDescription(widget.product);
              setState(() {
                loading = false;
              });
              toastMessage('Cập nhật thành công');
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Lưu sản phẩm',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        !loading ? TextButton(
          onPressed: () async {
            if (loading) {

            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Đóng',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.redAccent,),
      ],
    );
  }
}
