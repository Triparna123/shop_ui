import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/customer_interaction.dart';

class OwnerCustomerInteraction extends StatefulWidget {
  const OwnerCustomerInteraction({super.key});

  @override
  OwnerCustomerInteractionState createState() =>
      OwnerCustomerInteractionState();
}

class OwnerCustomerInteractionState extends State<OwnerCustomerInteraction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Interact with your customers',
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
                              Icons.location_on,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${interation.newVisits} New Visits',
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
                              Icons.perm_device_info,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${interation.priceChecks} Price Checks',
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
                  padding:
                      const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.question_answer,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${interation.unanswered} Unanswered Q&A',
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
                              Icons.rate_review,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${interation.newReviews} New Reviews',
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
