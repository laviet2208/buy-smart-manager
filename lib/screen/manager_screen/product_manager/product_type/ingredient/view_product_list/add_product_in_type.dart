import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/data/product/ProductType.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../../../data/otherdata/Time.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/Product.dart';
import '../../../../../../general_ingredient/rich_text_editor_type_1.dart';
import '../../../../../../general_ingredient/textfield_type_1.dart';
import '../../../../../../general_ingredient/utils.dart';
import '../../../product_list/action/add_new_product/controller.dart';
import '../../../product_list/action/add_new_product/ingredient/select_cost/select_cost.dart';
import '../../../product_list/action/add_new_product/ingredient/select_product_directory/select_product_directory.dart';
import '../../../product_list/action/add_new_product/ingredient/select_product_image/select_product_image.dart';
import '../../../product_list/action/add_new_product/ingredient/select_product_type/select_product_type.dart';
import '../../../product_list/action/add_new_product/ingredient/show_hide_product.dart';

class add_product_in_type extends StatefulWidget {
  final ProductType productType;
  const add_product_in_type({super.key, required this.productType});

  @override
  State<add_product_in_type> createState() => _add_product_in_typeState();
}

class _add_product_in_typeState extends State<add_product_in_type> {
  bool showStatus = false;
  QuillEditorController controller = QuillEditorController();
  QuillEditorController controller1 = QuillEditorController();
  final nameController = TextEditingController();
  final costController = TextEditingController();
  final costSaleController = TextEditingController();
  bool loading = false;
  final List<Uint8List> imageList = [];
  Product product = Product(id: '', name: '', productType: '', showStatus: 0, createTime: getCurrentTime(), description: '', directoryList: [], cost: 0, costBeforeSale: 0, inventory: 0, saleLimit: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), subdescription: '', viName: '');

  bool check_if_fill_all() {
    if (nameController.text.isNotEmpty && costController.text.isNotEmpty && costSaleController.text.isNotEmpty && imageList.isNotEmpty && product.directoryList.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> push_new_product(Product product) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).set(product.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imagePath) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);
      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String id = (DateTime.now().day >= 10 ? DateTime.now().day.toString() : ('0' + DateTime.now().day.toString())) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : ('0' + DateTime.now().month.toString())) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : ('0' + DateTime.now().year.toString())) + (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : ('0' + DateTime.now().hour.toString())) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : ('0' + DateTime.now().minute.toString())) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : ('0' + DateTime.now().second.toString()));
    product.id = 'SP' + id;
    product.productType = widget.productType.id;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/8*7;
    double width1 = width - 60;
    double height = MediaQuery.of(context).size.height/8*7;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 242, 245),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  child: Container(
                    height: 15,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      '< Quay về trang chính',
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 140,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'admin/mainscreen');
                  },
                ),
              ),

              Positioned(
                top: 25,
                left: 0,
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'Thêm mới sản phẩm',
                      style: TextStyle(
                        fontFamily: 'muli',
                        fontSize: 100,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, 'admin/mainscreen');
                  },
                ),
              ),

              Positioned(
                top: 75,
                bottom: 0,
                left: 0,
                child: Container(
                  width: width1/2,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
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
                            Container(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: textfield_type_1(title: 'Tên sản phẩm mới', hint: 'Nhập tên sản phẩm', controller: nameController),
                            ),

                            Container(height: 10,),

                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nội dung',
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

                      Container(height: 5,),

                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                ),
                                child: !loading ? Center(
                                  child: Text(
                                    'Thêm sản phẩm mới',
                                    style: TextStyle(
                                      fontFamily: 'muli',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ) : Container(width: 15, height: 15, child: CircularProgressIndicator(color: Colors.white),),
                              ),
                              onTap: () async {
                                if (check_if_fill_all()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  String id = (DateTime.now().hour >= 10 ? DateTime.now().hour.toString() : '0' + DateTime.now().hour.toString()) + (DateTime.now().minute >= 10 ? DateTime.now().minute.toString() : '0' + DateTime.now().minute.toString()) + (DateTime.now().second >= 10 ? DateTime.now().second.toString() : '0' + DateTime.now().second.toString()) + (DateTime.now().day >= 10 ? DateTime.now().day.toString() : '0' + DateTime.now().day.toString()) + (DateTime.now().month >= 10 ? DateTime.now().month.toString() : '0' + DateTime.now().month.toString()) + (DateTime.now().year >= 10 ? DateTime.now().year.toString() : '0' + DateTime.now().year.toString());
                                  product.id = 'SP' + id;
                                  product.description = await controller.getText();
                                  product.subdescription = await controller1.getText();
                                  product.name = nameController.text.toString();
                                  product.costBeforeSale = double.parse(costSaleController.text.toString());
                                  product.cost = double.parse(costController.text.toString());
                                  product.createTime = getCurrentTime();
                                  await push_new_product(product);
                                  for (int i = 0; i < imageList.length; i++) {
                                    String imageName = product.id + '_' + i.toString() + '.png';
                                    String imageUrl = 'product/' + product.id + '/' + imageName;
                                    await uploadImageToFirebaseStorage(imageList[i], imageUrl);
                                  }
                                  for (int i = 0; i < product.directoryList.length; i++) {
                                    await add_product_controller.directory_handle(product.directoryList[i], product.id);
                                  }
                                  await add_product_controller.type_handle(product.productType, product.id);
                                  setState(() {
                                    loading = false;
                                  });
                                  toastMessage('Tạo sản phẩm thành công');
                                  Navigator.pushNamed(context, 'admin/mainscreen');
                                } else {
                                  toastMessage('Vui lòng hoàn thành đủ các thông tin');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 75,
                bottom: 0,
                left: width1/2 + 10,
                child: Container(
                  width: width1/4,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        child: show_hide_product(product: product),
                      ),

                      Container(height: 20,),

                      Container(
                        child: select_product_type(product: product,),
                      ),

                      Container(height: 20,),

                      Container(
                        child: select_product_directory(product: product,),
                      ),

                      Container(height: 20,),

                      Container(
                        child: select_product_image(imageList: imageList),
                      ),

                      Container(height: 30,),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 75,
                bottom: 0,
                left: width1/2 + 10 + width1/4 + 10,
                child: Container(
                  width: width1/4,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        child: select_cost(costController: costController, costSaleController: costSaleController, product: product,),
                      ),

                      SizedBox(height: 8),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 10),
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
                        padding: EdgeInsets.only(left: 20, right: 10),
                        child: Container(
                          height: height - 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )
                          ),
                          child: rich_text_editor_type_1(controller: controller1, height: height - 300,),
                        ),
                      ),

                      Container(height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
