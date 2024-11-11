import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_ui/model/shop_products.dart';
import 'package:shop_ui/model/shop_services.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController ratingController = TextEditingController();
  // TextEditingController distanceController = TextEditingController();
  // TextEditingController imagePathController = TextEditingController();
  final String backendUrl = 'http://localhost:8080/api';

  List<ShopServices> availableServices = [];
  // List<ShopProducts> availableProducts = [];
  List<ShopServices> selectedServices = [];
  // List<ShopProducts> selectedProducts = [];
  // List<String> selectedWorkingDays = [];
  // Map<String, Map<String, String>> workingDayTimes = {};
  // List<String> weekdays = [];
  // double? rating;
  // double? distance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? selectedDayDropdownValue;
  // String? selectedOpenTime;
  // String? selectedCloseTime;
  ShopServices? selectedServiceDropdownValue;
  // ShopProducts? selectedProductsDropdownValue;

  @override
  void initState() {
    super.initState();
    // fetchDays();
    fetchServices();
    // fetchProducts();
  }

  // Future<void> fetchDays() async {
  //   final response = await http.get(Uri.parse('$backendUrl/days'));
  //   if (response.statusCode == 200) {
  //     final List<String> data = jsonDecode(response.body).cast<String>();
  //     setState(() {
  //       weekdays = data;
  //     });
  //   } else {
  //     throw Exception('Failed to load weekdays');
  //   }
  // }

  Future<void> fetchServices() async {
    final response = await http.get(Uri.parse('$backendUrl/getallservices'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        availableServices = data
            .map((serviceJson) => ShopServices.fromJson(serviceJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load services');
    }
  }

  // Future<void> fetchProducts() async {
  //   final response = await http.get(Uri.parse('$backendUrl/getallproducts'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     setState(() {
  //       availableProducts = data
  //           .map((productJson) => ShopProducts.fromJson(productJson))
  //           .toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  // List<String> generateTimeOptions() {
  //   final List<String> timeOptions = [];
  //   for (int hour = 0; hour < 24; hour++) {
  //     for (int minute = 0; minute < 60; minute += 30) {
  //       final time = DateTime(2000, 1, 1, hour, minute);
  //       final formattedTime =
  //           DateFormat.jm().format(time); // Format time in 12-hour format
  //       timeOptions.add(formattedTime);
  //     }
  //   }
  //   return timeOptions;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: shopNameController,
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: ratingController,
                //   decoration: const InputDecoration(labelText: 'Rating'),
                //   keyboardType: const TextInputType.numberWithOptions(
                //       decimal: true), // Allow decimal input
                //   onChanged: (value) {
                //     setState(() {
                //       rating = double.tryParse(value);
                //     });
                //   },
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: distanceController,
                //   decoration: const InputDecoration(labelText: 'Distance'),
                //   keyboardType: const TextInputType.numberWithOptions(
                //       decimal: true), // Allow decimal input
                //   onChanged: (value) {
                //     setState(() {
                //       distance = double.tryParse(value);
                //     });
                //   },
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: imagePathController,
                //   decoration: const InputDecoration(labelText: 'ImagePath'),
                // ),
                const SizedBox(height: 16),
                _buildServices(),
                // const SizedBox(height: 16),
                // _buildProducts(),
                // const SizedBox(height: 16),
                // _buildWorkingDaysAndTimesForm(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    registerShop(context);
                  },
                  child: const Text('Register Shop'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Services', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<ShopServices>(
                value: selectedServiceDropdownValue,
                items: availableServices.map((service) {
                  return DropdownMenuItem<ShopServices>(
                    value: service,
                    child: Text(service.serviceName),
                  );
                }).toList(),
                onChanged: (selectedService) {
                  setState(() {
                    selectedServiceDropdownValue = selectedService;
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Service'),
                isDense: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedServiceDropdownValue != null) {
                  final selectedService = selectedServiceDropdownValue!;
                  if (!selectedServices.contains(selectedService)) {
                    setState(() {
                      selectedServices.add(selectedService);
                      selectedServiceDropdownValue = null;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${selectedService.serviceName} already selected.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Selected Services:'),
        _buildSelectedServicesList(),
      ],
    );
  }

  Widget _buildSelectedServicesList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (ShopServices service in selectedServices)
          _buildServiceItem(service),
      ],
    );
  }

  Widget _buildServiceItem(ShopServices service) {
    return Slidable(
      key: ValueKey(service),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              setState(() {
                selectedServices.remove(service);
              });
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                service.serviceName,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildProducts() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Products', style: TextStyle(fontSize: 18)),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: DropdownButtonFormField<ShopProducts>(
  //               value: selectedProductsDropdownValue,
  //               items: availableProducts.map((product) {
  //                 return DropdownMenuItem<ShopProducts>(
  //                   value: product,
  //                   child: Text(product.productName),
  //                 );
  //               }).toList(),
  //               onChanged: (selectedProduct) {
  //                 setState(() {
  //                   selectedProductsDropdownValue = selectedProduct;
  //                 });
  //               },
  //               decoration: const InputDecoration(labelText: 'Select Product'),
  //               isDense: true,
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               if (selectedProductsDropdownValue != null) {
  //                 setState(() {
  //                   selectedProducts.add(selectedProductsDropdownValue!);
  //                   selectedProductsDropdownValue = null;
  //                 });
  //               }
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 16),
  //       const Text('Selected Products:'),
  //       _buildSelectedProductsList(),
  //     ],
  //   );
  // }

  // Widget _buildSelectedProductsList() {
  //   return Column(
  //     children: [
  //       for (ShopProducts product in selectedProducts)
  //         Container(
  //           margin: const EdgeInsets.symmetric(vertical: 8.0),
  //           child: Text(
  //             product.productName,
  //             style: const TextStyle(fontSize: 18.0),
  //           ),
  //         ),
  //     ],
  //   );
  // }

  // Widget _buildWorkingDaysAndTimesForm() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('Working Days and Times', style: TextStyle(fontSize: 18)),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: DropdownButtonFormField<String>(
  //               value: selectedDayDropdownValue,
  //               items: weekdays.map((day) {
  //                 return DropdownMenuItem<String>(
  //                   value: day,
  //                   child: Text(day),
  //                 );
  //               }).toList(),
  //               onChanged: (selectedDay) {
  //                 setState(() {
  //                   selectedDayDropdownValue = selectedDay;
  //                   selectedOpenTime = null;
  //                   selectedCloseTime = null;
  //                 });
  //               },
  //               decoration: const InputDecoration(labelText: 'Select Day'),
  //               isDense: true,
  //             ),
  //           ),
  //           const SizedBox(width: 16),
  //         ],
  //       ),
  //       const SizedBox(height: 16),
  //       if (selectedDayDropdownValue != null)
  //         Column(
  //           children: [
  //             const Text('Open Time'),
  //             DropdownButtonFormField<String>(
  //               value: selectedOpenTime,
  //               items: generateTimeOptions().map((time) {
  //                 return DropdownMenuItem<String>(
  //                   value: time,
  //                   child: Text(time),
  //                 );
  //               }).toList(),
  //               onChanged: (openTime) {
  //                 setState(() {
  //                   selectedOpenTime = openTime;
  //                 });
  //               },
  //               decoration: const InputDecoration(),
  //             ),
  //             const SizedBox(height: 16),
  //             const Text('Close Time'),
  //             DropdownButtonFormField<String>(
  //               value: selectedCloseTime,
  //               items: generateTimeOptions().map((time) {
  //                 return DropdownMenuItem<String>(
  //                   value: time,
  //                   child: Text(time),
  //                 );
  //               }).toList(),
  //               onChanged: (closeTime) {
  //                 setState(() {
  //                   selectedCloseTime = closeTime;
  //                 });
  //               },
  //               decoration: const InputDecoration(),
  //             ),
  //           ],
  //         ),
  //     ],
  //   );
  // }

  Future<void> registerShop(BuildContext context) async {
  if (_formKey.currentState?.validate() ?? false) {
    final shop = {
      'laundryShop': {
        'name': shopNameController.text,
        'address': addressController.text,
        // 'rating': rating,
        // 'distance': distance,
        // 'imagePath': imagePathController.text,
      },
      'shopWithServices': {
        'services': selectedServices.map((service) => {
          'serviceName': service.serviceName
        }).toList(),
      },
    };

    final response = await http.post(
      Uri.parse('$backendUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(shop),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop registered successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to register shop')),
      );
    }
  }
}

}
