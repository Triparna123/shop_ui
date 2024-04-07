// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/shop_services.dart';

class EmployeeServices extends StatefulWidget {
  const EmployeeServices({super.key});

  @override
  EmployeeServicesState createState() => EmployeeServicesState();
}

class EmployeeServicesState extends State<EmployeeServices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Services you provide',
                style: TextStyle(color: ShopColor.shopUiColor, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                    color: ShopColor.shopUiColor1,
                    borderRadius: BorderRadius.circular(3)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 13),
          child: SizedBox(
            height: 130,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: shopServices.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final service = shopServices[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.only(right: 15),
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 110,
                                height: 90,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    service.iconData,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  service.serviceName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                    color: ShopColor.shopUiColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
