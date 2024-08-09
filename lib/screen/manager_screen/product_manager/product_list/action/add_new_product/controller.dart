import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/otherdata/Tool.dart';
import '../../../../../../data/product/ProductDirectory.dart';
import '../../../../../../data/product/ProductType.dart';

class add_product_controller {
  static Future<ProductDirectory> get_directory(String id) async {
    ProductDirectory directory = ProductDirectory(id: '', status: 0, name: '', createTime: getCurrentTime(), productList: []);
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("productDirectory").child(id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null) {
        directory = ProductDirectory.fromJson(data);
      } else {
        directory.name = 'Danh mục không tồn tại';
      }
    });
    return directory;
  }

  static Future<void> push_new_productdirect(ProductDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productDirectory').child(directory.id).set(directory.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> directory_handle(String id, String productId) async {
    ProductDirectory directory = await get_directory(id);
    directory.productList.add(productId);
    await push_new_productdirect(directory);
  }

  static Future<ProductType> get_type(String id) async {
    ProductType type = ProductType(id: '', name: '', createTime: getCurrentTime(), productList: []);
    final reference = FirebaseDatabase.instance.ref();
    await reference.child("productType").child(id).onValue.listen((event) {
      final dynamic data = event.snapshot.value;
      if (data != null) {
        type = ProductType.fromJson(data);
      } else {

      }
    });
    return type;
  }

  static Future<void> push_new_producttype(ProductType type) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productType').child(type.id).set(type.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> type_handle(String id, String productId) async {
    ProductType type = await get_type(id);
    type.productList.add(productId);
    await push_new_producttype(type);
  }
}