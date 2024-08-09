import 'package:firebase_database/firebase_database.dart';

import '../../../../data/product/Product.dart';

class product_manager_controller {
  static Future<void> change_productType(Product product) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('productType').set(product.productType);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productCost(Product product) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('cost').set(product.cost);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productCostBefore(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('costBeforeSale').set(product.costBeforeSale);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productDateLimit(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('saleLimit').set(product.saleLimit.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productName(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('name').set(product.name);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productDescription(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('description').set(product.description);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productSubDescription(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('subdescription').set(product.subdescription);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productDirectory(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('directoryList').set(product.directoryList.map((e) => e).toList());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productShowStatus(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('showStatus').set(product.showStatus);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  static Future<void> change_productInventory(Product product) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
      await databaseRef.child('productList').child(product.id).child('inventory').set(product.inventory);
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }
}