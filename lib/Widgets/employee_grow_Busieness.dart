import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/employee_grow_business.dart';

class EmployeeGrowBusiness extends StatefulWidget {
  const EmployeeGrowBusiness({super.key});

  @override
  EmployeeGrowBusinessState createState() => EmployeeGrowBusinessState();
}

class EmployeeGrowBusinessState extends State<EmployeeGrowBusiness> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Grow your Business',
                style: TextStyle(color: ShopColor.shopUiColor, fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 13),
          child: SizedBox(
            height: 130,
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: business.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final businessData = business[index];
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
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(),
                                  child: Icon(
                                    businessData.iconData,
                                    color: Colors.black,
                                    size: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  businessData.details,
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
