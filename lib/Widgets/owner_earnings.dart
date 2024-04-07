// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';

class OwnerEarnings extends StatefulWidget {
  const OwnerEarnings({super.key});

  @override
  OwnerEarningsState createState() => OwnerEarningsState();
}

class OwnerEarningsState extends State<OwnerEarnings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Earnings',
                style: TextStyle(color: ShopColor.shopUiColor, fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Card(
            elevation: 5,
            // child: Text('Next Fulfillment Date : '),
          ),
        )
      ],
    );
  }}