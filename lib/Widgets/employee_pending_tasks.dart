import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/pending_tasks.dart';

class EmployeePendingTasks extends StatefulWidget {
  const EmployeePendingTasks({super.key});

  @override
  EmployeePendingTasksState createState() => EmployeePendingTasksState();
}

class EmployeePendingTasksState extends State<EmployeePendingTasks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Pending Tasks',
                style: TextStyle(color: ShopColor.shopUiColor, fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Card(
            color: Colors.white,
            elevation: 5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_dissatisfied_outlined,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfDeliveryDelayed} Delivery Delayed',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_dissatisfied_outlined,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfPickupDelayed} Pickup Delayed',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfDeliveryPending} Delivery Pending',
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfPickupPending} Pickup Pending',
                              style: const TextStyle(
                                  color: Colors.purple, fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10,bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_satisfied_alt_outlined,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfDeliveryScheduled} Delivery Scheduled',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10,left: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sentiment_satisfied_alt_outlined,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${tasks.noOfPickupScheduled} Pickup Scheduled',
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
