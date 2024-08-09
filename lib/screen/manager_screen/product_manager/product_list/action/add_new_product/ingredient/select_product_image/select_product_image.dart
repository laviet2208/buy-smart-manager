import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../../../../../../general_ingredient/utils.dart';

class select_product_image extends StatefulWidget {
  final List<Uint8List> imageList;
  const select_product_image({super.key, required this.imageList});

  @override
  State<select_product_image> createState() => _select_product_imageState();
}

class _select_product_imageState extends State<select_product_image> {

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

        children: [
          Container(height: 20,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ảnh sản phẩm',
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
                      text: 'Lưu ý: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'muli',
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: 'Ảnh đầu tiên của sản phẩm sẽ là ảnh đại diện',
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

          Container(height: 10,),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: widget.imageList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Container(
                            width: 80,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10), // Bo tròn với bán kính 50
                                  child: Image.memory(
                                    widget.imageList[index],
                                    fit: BoxFit.fill,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                // Thêm các thành phần khác chồng lên ảnh tại đây
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      widget.imageList.removeAt(index);
                                      setState(() {

                                      });
                                      toastMessage('Xóa thành công');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  GestureDetector(
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          )
                      ),
                      child: Center(
                        child: Icon(
                          Icons.photo_camera_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () async {
                      final Uint8List? image = await galleryImagePicker();

                      if (image != null) {
                        Uint8List? registrationImage;
                        registrationImage = image;
                        widget.imageList.add(registrationImage);
                        toastMessage('Thêm ảnh thành công');
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          Container(height: 20,),
        ],
      ),
    );
  }
}
