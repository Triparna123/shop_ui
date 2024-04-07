// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/holidays.dart';

class ManageHolidays extends StatefulWidget {
  const ManageHolidays({super.key});

  @override
  ManageHolidaysState createState() => ManageHolidaysState();
}

class ManageHolidaysState extends State<ManageHolidays> {
  final shopStatus = 'Closed';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Manage Holidays',
                style: TextStyle(color: ShopColor.shopUiColor, fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 13, right: 20),
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Column(
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      shopStatus,
                      style: TextStyle(
                          color: ShopColor.shopUiColor1, fontSize: 14),
                    ),
                  ),
                ]),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      holidays[0].date,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        '${holidays[1].date} - ${holidays[1].ocassion}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                              '${holidays[2].date} - ${holidays[2].ocassion}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15,bottom: 15),
                          child: Text(
                              '${holidays[3].date} - ${holidays[3].ocassion}'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ShopColor.shopUiColor1,
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
