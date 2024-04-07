// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:shop_ui/misc/shop_color.dart';

// class Schedular extends StatefulWidget {
//   const Schedular({super.key});

//   @override
//   SchedularState createState() => SchedularState();
// }

// class SchedularState extends State<Schedular> {
//   bool isPickupClicked = false;
//   bool isDeliveryClicked  = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20, top: 20),
//               child: Icon(
//                 Icons.arrow_back,
//                 size: 40,
//                 color: ShopColor.shopUiColor1,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: Text(
//                 'Scheduler',
//                 style: TextStyle(
//                     fontSize: 24,
//                     color: ShopColor.shopUiColor1,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 20, top: 20),
//               child: Column(
//                 children: [
//                   Icon(Icons.add_task_outlined,
//                       size: 30, color: Colors.green.shade900),
//                   Text(
//                     'New Task',
//                     style: TextStyle(color: Colors.green.shade900),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 15),
//           child: Container(
//             height: 30,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(right: BorderSide(color: Colors.black)),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Delivery',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'Pick up',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/details.dart';

import 'package:shop_ui/model/delivery_dates.dart';
import 'package:shop_ui/model/pickup_date.dart';

class Schedular extends StatefulWidget {
  const Schedular({Key? key}) : super(key: key);

  @override
  SchedularState createState() => SchedularState();
}

class SchedularState extends State<Schedular> {
  bool isPickupClicked = false;
  bool isDeliveryClicked = true;
  int selectedDateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: ShopColor.shopUiColor1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Scheduler',
                  style: TextStyle(
                    fontSize: 24,
                    color: ShopColor.shopUiColor1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_task_outlined,
                      size: 30,
                      color: Colors.green.shade900,
                    ),
                    Text(
                      'New Task',
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeliveryClicked = true;
                          isPickupClicked = false;
                          selectedDateIndex = 0; // Reset selected date
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.black)),
                          color:
                              isDeliveryClicked ? ShopColor.shopUiColor1 : null,
                        ),
                        child: Center(
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 18,
                              color: isDeliveryClicked ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPickupClicked = true;
                          isDeliveryClicked = false;
                          selectedDateIndex = 0; // Reset selected date
                        });
                      },
                      child: Container(
                        color: isPickupClicked ? ShopColor.shopUiColor1 : null,
                        child: Center(
                          child: Text(
                            'Pick up',
                            style: TextStyle(
                              fontSize: 18,
                              color: isPickupClicked ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Show the list of dates for Delivery or Pickup
          _buildDateList(isPickupClicked ? pickupDates : deliveryDates),
          // Show details for the selected date
          
          if (selectedDateIndex != -1)
            _buildDetailsList(isPickupClicked ? pickupDates : deliveryDates),
        ],
      ),
    );
  }

  // Helper method to build date list
  Widget _buildDateList(List<dynamic> dates) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, bottom: 15),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDateIndex = index;
                });
              },
              child: Container(
                width: 60,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: isDeliveryClicked
                      ? selectedDateIndex == index
                          ? ShopColor.shopUiColor1
                          : Colors.grey.shade300
                      : selectedDateIndex == index
                          ? ShopColor.shopUiColor1
                          : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dates[index].day,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDeliveryClicked
                            ? selectedDateIndex == index
                                ? Colors.white
                                : null
                            : selectedDateIndex == index
                                ? Colors.white
                                : null,
                      ),
                    ),
                    Text(
                      dates[index].date,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDeliveryClicked
                            ? selectedDateIndex == index
                                ? Colors.white
                                : null
                            : selectedDateIndex == index
                                ? Colors.white
                                : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to build details list
  Widget _buildDetailsList(List<dynamic> dates) {
    if (selectedDateIndex >= 0 && selectedDateIndex < dates.length) {
      List<Details> detailsList = dates[selectedDateIndex].details;

      return Column(
        children: detailsList
            .map(
              (details) => Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 5,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            details.name,
                            style: TextStyle(color: ShopColor.shopUiColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Rs. ${details.price}'),
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
                              child: Text('${details.address}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 15, bottom: 15),
                              child: Text('${details.phoneNumber}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch),
                            Text('${details.time}')
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5),
                        //   child: Text(
                        //     details.address,
                        //     style: TextStyle(color: ShopColor.shopUiColor),
                        //   ),
                        // ), HERE WILL COME THE SERVICES THAT THE USER CHOOSES FROM THE USER UI
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('${details.distance}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Container(); // Empty container if no date is selected
    }
  }
}
