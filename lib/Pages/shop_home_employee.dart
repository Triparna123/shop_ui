// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_ui/Widgets/employee_services.dart';
import 'package:shop_ui/misc/shop_color.dart';

class ShopHomeEmployee extends StatefulWidget {
  const ShopHomeEmployee({Key? key}) : super(key: key);

  @override
  ShopHomeEmployeeState createState() => ShopHomeEmployeeState();
}

class ShopHomeEmployeeState extends State<ShopHomeEmployee> {
  @override
  Widget build(BuildContext context) {
    final String shopName = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        elevation: 0,
        title: const Text("Shop Home", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(Icons.person, size: 40, color: Colors.grey.shade600),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Hey Amrita",
                    style: TextStyle(
                      fontSize: 18,
                      color: ShopColor.shopUiColor1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: EmployeeServices(shopName: shopName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
