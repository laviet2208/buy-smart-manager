import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/otherdata/Time.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/Product.dart';
import '../../../../../../general_ingredient/textfield_type_1.dart';
import '../../controller.dart';

class change_product_cost extends StatefulWidget {
  final Product product;
  const change_product_cost({super.key, required this.product});

  @override
  State<change_product_cost> createState() => _change_product_costState();
}

class _change_product_costState extends State<change_product_cost> {
  bool loading = false;
  final costController = TextEditingController();
  final costSaleController = TextEditingController();
  final limitController = TextEditingController();

  Future<void> _selectDate(TextEditingController controller, Time time) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        time.day = selectedDate.day;
        time.month = selectedDate.month;
        time.year = selectedDate.year;
        controller.text = getDayTimeString(time);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    costController.text = widget.product.cost.toStringAsFixed(0);
    costSaleController.text = widget.product.costBeforeSale.toStringAsFixed(0);
    if (widget.product.saleLimit.month == 0) {

    } else {
      limitController.text = getDayTimeString(widget.product.saleLimit);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return AlertDialog(
      title: Text('Chỉnh sửa giá tiền'),
      content: Container(
        width: width/3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Lưu ý 1: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: 'Nếu muốn sản phẩm hiển thị dưới dạng giảm giá, nhập cả 2 mục khác 0. Nếu nhập mục 2 là 0, sản phẩm sẽ hiển thị giá bình thường',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Lưu ý 2: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: 'Nếu nhập 0 ở cả 2 mục, giá sản phẩm sẽ hiện là LIÊN HỆ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Lưu ý 3: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: 'Nếu chọn ngày giới hạn giảm giá, sản phẩm sẽ có mặt trong mục "Sale có giới hạn", nếu không muốn sale giới hạn, bỏ trống mục này',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(height: 5,),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: textfield_type_1(title: 'Giá tiền thực', hint: 'Nhập giá tiền thực', controller: costController),
            ),

            Container(height: 8,),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: textfield_type_1(title: 'Giá tiền trước khi giảm', hint: 'Nhập giá tiền trước giảm', controller: costSaleController),
            ),

            Container(height: 8,),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Text(
                'Ngày giới hạn SALE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'muli',
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(
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
                    controller: limitController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'muli',
                    ),
                    readOnly: true,
                    placeholder: 'Click chọn giới hạn SALE',
                    placeholderStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'muli',
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    onTap: () {
                      _selectDate(limitController, widget.product.saleLimit,);
                      setState(() {

                      });
                    },
                  ),
                ),
              ),
            ),

            Container(height: 20,),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (loading) {

            } else {
              if (costController.text.isNotEmpty && costSaleController.text.isNotEmpty) {
                setState(() {
                  loading = true;
                });
                widget.product.cost = double.parse(costController.text.toString());
                widget.product.costBeforeSale = double.parse(costSaleController.text.toString());
                await product_manager_controller.change_productDateLimit(widget.product);
                await product_manager_controller.change_productCost(widget.product);
                await product_manager_controller.change_productCostBefore(widget.product);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              }
            }
          },
          child: Text(
            'Lưu thông tin',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        TextButton(
          onPressed: () async {
            if (loading) {

            } else {
              limitController.clear();
              widget.product.saleLimit.day = 0;
              widget.product.saleLimit.month = 0;
              widget.product.saleLimit.year = 0;
              setState(() {

              });
            }
          },
          child: Text(
            'Xóa giới hạn Sale',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),

        !loading ? TextButton(
          onPressed: () {
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
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
