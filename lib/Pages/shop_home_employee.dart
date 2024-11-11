// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:shop_ui/Widgets/employee_customer_interaction.dart';
// import 'package:shop_ui/Widgets/employee_grow_Busieness.dart';
// import 'package:shop_ui/Widgets/employee_pending_tasks.dart';
// import 'package:shop_ui/Widgets/employee_services.dart';
// import 'package:shop_ui/misc/shop_color.dart';

// class ShopHomeEmployee extends StatefulWidget {
//   const ShopHomeEmployee({super.key});

//   @override
//   ShopHomeEmployeeState createState() => ShopHomeEmployeeState();
// }

// class ShopHomeEmployeeState extends State<ShopHomeEmployee> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//               "Hey Amrita",
//               style: TextStyle(
//                 // fontWeight: FontWeight.bold,
//                 fontSize: 15,
//                 color: ShopColor.shopUiColor1,
//               ),
//             ),
//           ),
//           EmployeeServices(),
//           EmployeePendingTasks(),
//           EmployeeCustomerInteraction(),
//           EmployeeGrowBusiness(),
//         ],
//       ),
//     );
//   }
// }
