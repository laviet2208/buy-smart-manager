import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../data/otherdata/Time.dart';
import '../../../../../../../../data/otherdata/Tool.dart';
import '../../../../../../../../data/product/Product.dart';
import '../../../../../../../../general_ingredient/textfield_type_1.dart';

class select_cost extends StatefulWidget {
  final TextEditingController costController;
  final TextEditingController costSaleController;
  final Product product;
  const select_cost({super.key, required this.costController, required this.costSaleController, required this.product,});

  @override
  State<select_cost> createState() => _select_costState();
}

class _select_costState extends State<select_cost> {
  TimeOfDay selectedTime = TimeOfDay.now();
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
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Giá tiền sản phẩm',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'muli',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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
            child: textfield_type_1(title: 'Giá tiền thực', hint: 'Nhập giá tiền thực', controller: widget.costController),
          ),

          Container(height: 8,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: textfield_type_1(title: 'Giá tiền trước khi giảm', hint: 'Nhập giá tiền trước giảm', controller: widget.costSaleController),
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
    );
  }
}
