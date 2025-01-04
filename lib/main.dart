// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_ui/Pages/register.dart';
import 'package:shop_ui/Pages/shop_details_register_by_shopOwner.dart';
// import 'package:shop_ui/Pages/shop_home_employee.dart';
// import 'package:shop_ui/Pages/shop_register.dart';
import 'package:shop_ui/Pages/login.dart';
// import 'package:shop_ui/Pages/shop_home_employee.dart';
// import 'package:shop_ui/Pages/shop_home_owner.dart';
// import 'package:shop_ui/Pages/schedular.dart';
// import 'package:shop_ui/Pages/shop_home_employee.dart';
// import 'package:shop_ui/Pages/shop_home_owner.dart';
// import 'package:shop_ui/Pages/shop_intro.dart';
// import 'package:shop_ui/Pages/shop_register.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with FirebaseOptions for Flutter Web
  // try {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyAa6CsNxbi8d0xI54GjxDWVrXMZTy4exig",
  //         authDomain: "shopui-b7d2f.firebaseapp.com",
  //         projectId: "shopui-b7d2f",
  //         storageBucket: "shopui-b7d2f.firebasestorage.app",
  //         messagingSenderId: "83666892278",
  //         appId: "1:83666892278:web:897f1b36feecd8e7c043d7",
  //         measurementId: "G-89T1CQJHHY"),
  //   );
  runApp(MyApp());
  // } catch (e) {
  //   print("Error initializing Firebase: $e");
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // "/":(context)=>ShopIntro(),q

         "/":(context)=>RegistrationPage(),
        "/login": (context) => Login(),

        // // "/":(context)=>ShopHomeOwner(),

        // "/":(context)=>Schedular(),
        //  '/ownerHome': (context) => ShopHomeOwner(),
         '/shopDetails': (context) => ShopDetailsPage(),
      },
    );
  }
}
