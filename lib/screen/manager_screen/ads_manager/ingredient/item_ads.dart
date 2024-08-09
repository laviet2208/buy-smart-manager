import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/AdsData/AdsData.dart';
import 'package:lyshoppingmanager/data/otherdata/Tool.dart';
import 'package:lyshoppingmanager/general_ingredient/feature_button.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ads_manager/actions/add_new_ads/product_search_ads.dart';
import 'package:lyshoppingmanager/screen/manager_screen/ads_manager/actions/update_ads_image/update_ads_image.dart';

import '../../../../general_ingredient/text_line_in_item.dart';

class item_ads extends StatefulWidget {
  final String id;
  final int index;
  const item_ads({super.key, required this.id, required this.index});

  @override
  State<item_ads> createState() => _item_adsState();
}

class _item_adsState extends State<item_ads> {
  AdsData adsData = AdsData(id: '', productId: '', createTime: getCurrentTime(), status: 0);
  String product_name = 'Lỗi tên sản phẩm';
  String url = '';
  void get_ads() {
    if (widget.id != '') {
      final reference = FirebaseDatabase.instance.ref();

      reference.child("adsData").child(widget.id).onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        adsData = AdsData.fromJson(data);
        _getImageURL();
        get_product_name();
        setState(() {

        });
      });
    }
  }

  void _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('Ads').child(widget.id + '.png');
    url = await ref.getDownloadURL();
    setState(() {

    });
  }

  void get_product_name() {
    if (adsData.productId != '') {
      final reference = FirebaseDatabase.instance.ref();
      reference.child("productList").child(adsData.productId).child('name').onValue.listen((event) {
        final dynamic data = event.snapshot.value;
        product_name = data.toString();
        setState(() {

        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_ads();
    get_product_name();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double height = 150;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: Colors.black,title: 'Mã quảng cáo: ', content: adsData.id),

                  Container(height: 8,),

                  text_line_in_item(color: adsData.status == 0 ? Colors.redAccent : Colors.green,title: 'Trạng thái: ', content: adsData.status == 0 ? 'Đang tạm ẩn' : 'Đang hiển thị'),

                  Container(height: 8,),

                  text_line_in_item(color: Colors.black, title: 'Thời gian tạo: ', content: getAllTimeString(adsData.createTime)),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: 260,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(url),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/4-1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  text_line_in_item(color: adsData.productId == '' ? Colors.redAccent : Colors.black, title: 'Sản phẩm đại diện: ', content: adsData.productId == '' ? 'Chưa chọn sản phẩm' : product_name),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: (width - 50)/4 - 10,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                children: [
                  Container(height: 4,),

                  feature_button(title: 'Cập nhật sản phẩm', textColor: Colors.black, backgroundColor: Colors.yellow, event: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return product_search_ads(id: widget.id);
                      },
                    );
                  }),

                  Container(height: 8,),

                  feature_button(title: 'Cập nhật ảnh đại diện', textColor: Colors.black, backgroundColor: Colors.white, event: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return update_ads_image(id: widget.id, event: () { setState(() {}); },);
                      },
                    );
                  }),

                  Container(height: 8,),

                  feature_button(title: adsData.status == 0 ? 'Hiện quảng cáo' : 'Ẩn quảng cáo', textColor: Colors.black, backgroundColor: Colors.white, event: () async {
                    if (adsData.status == 0) {
                      adsData.status = 1;
                      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
                      await databaseRef.child('adsData').child(adsData.id).child('status').set(adsData.status);
                    } else {
                      adsData.status = 0;
                      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
                      await databaseRef.child('adsData').child(adsData.id).child('status').set(adsData.status);
                    }
                  }),

                  Container(height: 8,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
