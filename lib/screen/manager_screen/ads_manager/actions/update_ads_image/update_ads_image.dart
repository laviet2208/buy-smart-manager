import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../../../../general_ingredient/utils.dart';

class update_ads_image extends StatefulWidget {
  final String id;
  final VoidCallback event;
  const update_ads_image({super.key, required this.id, required this.event});

  @override
  State<update_ads_image> createState() => _update_ads_imageState();
}

class _update_ads_imageState extends State<update_ads_image> {
  bool loading = false;
  Uint8List? registrationImage;

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('Ads/$imageName.png');

      // Đặt loại (MIME type) là 'image/png'
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

      // Upload dữ liệu của ảnh lên Firebase Storage với metadata
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);

      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cập nhật ảnh quảng cáo', style: TextStyle(fontFamily: 'muli'),),
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                child: Container(
                  height: 140,
                  width: 280,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child:registrationImage == null
                        ? Icon(Icons.image_outlined, size: 20.0, color: Colors.black,)
                        : Image.memory(registrationImage!, fit: BoxFit.fitWidth,),
                  ),
                ),
                onTap: () async {
                  final Uint8List? image = await galleryImagePicker();

                  if (image != null) {
                    registrationImage = image;
                    toastMessage('Thêm ảnh thành công');
                    setState(() {});
                  }
                },
              ),
            ),

            SizedBox(height: 10,),

            Container(
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
                      text: 'Nên chọn ảnh đại diện quảng cáo là ảnh có tỷ lệ ngang/dọc = 2/1',
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
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          child: Text('Đồng ý', style: TextStyle(color: Colors.blue),),
          onPressed: () async {
            if (!loading) {
              setState(() {
                loading = true;
              });
              await uploadImageToFirebaseStorage(registrationImage!, widget.id);
              setState(() {
                loading = false;
              });
              toastMessage('Cập nhật thành công');
              widget.event();
              Navigator.of(context).pop();
            } else {

            }
          },
        ) : CircularProgressIndicator(color: Colors.blue,),

        !loading ? TextButton(
          child: Text('Hủy', style: TextStyle(color: Colors.red),),
          onPressed: () async {
            if (!loading) {
              Navigator.of(context).pop();
            } else {

            }
          },
        ) : CircularProgressIndicator(color: Colors.red,),
      ],
    );
  }
}
