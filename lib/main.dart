import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lyshoppingmanager/screen/main_screen/main_manager_screen.dart';
import 'package:lyshoppingmanager/screen/manager_screen/product_manager/product_list/action/add_new_product/add_new_product.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC6JdUqnd_7iIzehRlQ3w47j_mT7heI8no",
        authDomain: "ly-s-shopping.firebaseapp.com",
        databaseURL: "https://ly-s-shopping-default-rtdb.firebaseio.com",
        projectId: "ly-s-shopping",
        storageBucket: "ly-s-shopping.appspot.com",
        messagingSenderId: "217543052939",
        appId: "1:217543052939:web:fb73cee1903e5822a40e8e",
        measurementId: "G-6ZWKBQERB7"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Buy Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'admin/mainscreen',
      routes: {
        'admin/mainscreen': (context) => const main_manager_screen(),
        'admin/addproduct': (context) => const add_new_product(),
      },
    );
    // return Container();
  }
}
