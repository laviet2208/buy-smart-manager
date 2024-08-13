import 'package:flutter/material.dart';
import '../../../../../data/Account/Account.dart';
import '../../../../../general_ingredient/heading_title.dart';
import 'add_voucher_for_customer.dart';
import 'item_voucher_customer.dart';

class voucher_manager extends StatefulWidget {
  final Account account;
  const voucher_manager({super.key, required this.account});

  @override
  State<voucher_manager> createState() => _voucher_managerState();
}

class _voucher_managerState extends State<voucher_manager> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/7*6;
    double height = MediaQuery.of(context).size.height/7*6;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Danh sách voucher', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      content: Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                child: Container(
                  height: 40,
                  width: 210,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all()
                  ),
                  child: Center(
                    child: Text(
                      '+ Thêm Voucher',
                      style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return add_voucher_for_customer(account: widget.account);
                    },
                  );
                },
              ),
            ),

            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 255),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 225, 225, 226)
                    )
                ),
                child: heading_title(numberColumn: 5, listTitle: ['Thông tin sự kiện', 'Thời gian khả dụng', 'Giá trị voucher', 'Thông tin khách hàng','Thao tác',], width: width, height: 50),
              ),
            ),

            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)
                ),
                child: ListView.builder(
                  itemCount: widget.account.voucherList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return item_voucher_customer(index: index, voucher: widget.account.voucherList[index], account: widget.account,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
