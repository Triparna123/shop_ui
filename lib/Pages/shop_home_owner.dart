// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:shop_ui/Widgets/owner_customer_interactions.dart';
// import 'package:shop_ui/Widgets/owner_earnings.dart';
// import 'package:shop_ui/Widgets/owner_grow_business.dart';
// import 'package:shop_ui/Widgets/owner_manage_holiday.dart';
// import 'package:shop_ui/Widgets/owner_pending_tasks.dart';
// import 'package:shop_ui/Widgets/owner_services.dart';
// import 'package:shop_ui/misc/shop_color.dart';

// class ShopHomeOwner extends StatefulWidget {
//   const ShopHomeOwner({super.key});

//   @override
//   ShopHomeOwnerState createState() => ShopHomeOwnerState();
// }

// class ShopHomeOwnerState extends State<ShopHomeOwner> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 20,left: 20,bottom: 5),
//                 child: CircleAvatar(
//                   backgroundColor: Colors.grey.shade300,
//                   // foregroundImage: AssetImage(''),
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(right: 10,top:10),
//                 child: IconButton(
//                     onPressed: () {}, icon: const Icon(Icons.notifications)),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 5, left: 15, bottom: 20),
//             child: Text(
//               "Hey Admin",
//               style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 fontSize: 15,
//                 color: ShopColor.shopUiColor1,
//               ),
//             ),
//           ),
//           OwnerServices(),
//           OwnerPendingTasks(),
//           OwnerEarnings(),
//           OwnerCustomerInteraction(),
//           OwnerGrowBusiness(),
//           ManageHolidays(),
//         ],
//       ),
//     );
//   }
// }
