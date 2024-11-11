// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:shop_ui/model/shop_products.dart';
// import 'package:shop_ui/model/shop_services.dart';

// class ShopRegistrationPage extends StatefulWidget {
//   const ShopRegistrationPage({Key? key}) : super(key: key);

//   @override
//   _ShopRegistrationPageState createState() => _ShopRegistrationPageState();
// }

// class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
//   TextEditingController shopNameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController ratingController = TextEditingController();
//   TextEditingController distanceController = TextEditingController();
//   TextEditingController imagePathController = TextEditingController();
//   final String backendUrl = 'http://localhost:8080/api';

//   List<ShopServices> availableServices = [];
//   List<ShopProducts> availableProducts = [];
//   List<ShopServices> selectedServices = [];
//   List<ShopProducts> selectedProducts = [];
//   List<String> selectedWorkingDays = [];
//   Map<String, Map<String, String>> workingDayTimes = {};
//   List<String> weekdays = [];
//   double? rating;
//   double? distance;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? selectedDayDropdownValue;
//   String? selectedOpenTime;
//   String? selectedCloseTime;
//   ShopServices? selectedServiceDropdownValue;
//   ShopProducts? selectedProductsDropdownValue;

//   @override
//   void initState() {
//     super.initState();
//     fetchDays();
//     fetchServices();
//     fetchProducts();
//   }

//   Future<void> fetchDays() async {
//     final response = await http.get(Uri.parse('$backendUrl/days'));
//     if (response.statusCode == 200) {
//       final List<String> data = jsonDecode(response.body).cast<String>();
//       setState(() {
//         weekdays = data;
//       });
//     } else {
//       throw Exception('Failed to load weekdays');
//     }
//   }

//   Future<void> fetchServices() async {
//     final response = await http.get(Uri.parse('$backendUrl/getallservices'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         availableServices = data
//             .map((serviceJson) => ShopServices.fromJson(serviceJson))
//             .toList();
//       });
//     } else {
//       throw Exception('Failed to load services');
//     }
//   }

//   Future<void> fetchProducts() async {
//     final response = await http.get(Uri.parse('$backendUrl/getallproducts'));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         availableProducts = data
//             .map((productJson) => ShopProducts.fromJson(productJson))
//             .toList();
//       });
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   List<String> generateTimeOptions() {
//     final List<String> timeOptions = [];
//     for (int hour = 0; hour < 24; hour++) {
//       for (int minute = 0; minute < 60; minute += 30) {
//         final time = DateTime(2000, 1, 1, hour, minute);
//         final formattedTime =
//             DateFormat.jm().format(time); // Format time in 12-hour format
//         timeOptions.add(formattedTime);
//       }
//     }
//     return timeOptions;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shop Registration'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: shopNameController,
//                   decoration: const InputDecoration(labelText: 'Shop Name'),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: ratingController,
//                   decoration: const InputDecoration(labelText: 'Rating'),
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true), // Allow decimal input
//                   onChanged: (value) {
//                     setState(() {
//                       rating = double.tryParse(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: distanceController,
//                   decoration: const InputDecoration(labelText: 'Distance'),
//                   keyboardType: const TextInputType.numberWithOptions(
//                       decimal: true), // Allow decimal input
//                   onChanged: (value) {
//                     setState(() {
//                       distance = double.tryParse(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: imagePathController,
//                   decoration: const InputDecoration(labelText: 'ImagePath'),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildServices(),
//                 const SizedBox(height: 16),
//                 _buildProducts(),
//                 const SizedBox(height: 16),
//                 _buildWorkingDaysAndTimesForm(),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     registerShop(context);
//                   },
//                   child: const Text('Register Shop'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildServices() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Services', style: TextStyle(fontSize: 18)),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: DropdownButtonFormField<ShopServices>(
//                 value: selectedServiceDropdownValue,
//                 items: availableServices.map((service) {
//                   return DropdownMenuItem<ShopServices>( 
//                     value: service,
//                     child: Text(service.serviceName),
//                   );
//                 }).toList(),
//                 onChanged: (selectedService) {
//                   setState(() {
//                     selectedServiceDropdownValue = selectedService;
//                   });
//                 },
//                 decoration: const InputDecoration(labelText: 'Select Service'),
//                 isDense: true,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedServiceDropdownValue != null) {
//                   final selectedService = selectedServiceDropdownValue!;
//                   if (!selectedServices.contains(selectedService)) {
//                     setState(() {
//                       selectedServices.add(selectedService);
//                       selectedServiceDropdownValue = null;
//                     });
//                   } else {
//                     // Show warning message if the service is already selected
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                             '${selectedService.serviceName} already selected.'),
//                         backgroundColor: Colors.red,
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         const Text('Selected Services:'),
//         _buildSelectedServicesList(),
//       ],
//     );
//   }

//   Widget _buildSelectedServicesList() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         for (ShopServices service in selectedServices)
//           _buildServiceItem(service),
//       ],
//     );
//   }

//   Widget _buildServiceItem(ShopServices service) {
//     return Slidable(
//       actionPane: const SlidableDrawerActionPane(),
//       actionExtentRatio: 0.25,
//       secondaryActions: [
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red,
//           icon: Icons.delete,
//           onTap: () {
//             setState(() {
//               selectedServices.remove(service);
//             });
//           },
//         ),
//       ],
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 service.serviceName,
//                 style: const TextStyle(fontSize: 18.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProducts() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Products', style: TextStyle(fontSize: 18)),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Expanded(
//               child: DropdownButtonFormField<ShopProducts>(
//                 value: selectedProductsDropdownValue,
//                 items: availableProducts.map((product) {
//                   return DropdownMenuItem<ShopProducts>(
//                     value: product,
//                     child: Text(product.productName),
//                   );
//                 }).toList(),
//                 onChanged: (selectedProduct) {
//                   setState(() {
//                     selectedProductsDropdownValue = selectedProduct;
//                   });
//                 },
//                 decoration: const InputDecoration(labelText: 'Select Product'),
//                 isDense: true,
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (selectedProductsDropdownValue != null) {
//                   setState(() {
//                     selectedProducts.add(selectedProductsDropdownValue!);
//                     selectedProductsDropdownValue = null;
//                   });
//                 }
//               },
//               child: const Text('Add'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         const Text('Selected Products:'),
//         _buildSelectedProductsList(),
//       ],
//     );
//   }

//   Widget _buildSelectedProductsList() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         for (ShopProducts product in selectedProducts)
//           _buildProductItem(product),
//       ],
//     );
//   }

//   Widget _buildProductItem(ShopProducts product) {
//     return Slidable(
//       actionPane: const SlidableDrawerActionPane(),
//       actionExtentRatio: 0.25,
//       secondaryActions: [
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red,
//           icon: Icons.delete,
//           onTap: () {
//             setState(() {
//               selectedProducts.remove(product);
//             });
//           },
//         ),
//       ],
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 product.productName,
//                 style: const TextStyle(fontSize: 18.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWorkingDaysAndTimesForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Working Days & Times', style: TextStyle(fontSize: 18)),
//         const SizedBox(height: 8),
//         DropdownButton<String>(
//           value: selectedDayDropdownValue,
//           hint: const Text('Select Day'),
//           onChanged: (value) {
//             setState(() {
//               selectedDayDropdownValue = value;
//             });
//           },
//           items: weekdays.map((day) {
//             return DropdownMenuItem<String>(
//               value: day,
//               child: Text(day),
//             );
//           }).toList(),
//         ),
//         if (selectedDayDropdownValue != null)
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: DropdownButton<String>(
//                       value: selectedOpenTime,
//                       hint: const Text('Select Open Time'),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedOpenTime = value;
//                         });
//                       },
//                       items: generateTimeOptions().map((time) {
//                         return DropdownMenuItem<String>(
//                           value: time,
//                           child: Text(time),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: DropdownButton<String>(
//                       value: selectedCloseTime,
//                       hint: const Text('Select Close Time'),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCloseTime = value;
//                         });
//                       },
//                       items: generateTimeOptions().map((time) {
//                         return DropdownMenuItem<String>(
//                           value: time,
//                           child: Text(time),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedDayDropdownValue != null &&
//                       selectedOpenTime != null &&
//                       selectedCloseTime != null) {
//                     setState(() {
//                       workingDayTimes[selectedDayDropdownValue!] = {
//                         'open': selectedOpenTime!,
//                         'close': selectedCloseTime!,
//                       };
//                       selectedWorkingDays.add(selectedDayDropdownValue!);
//                       selectedDayDropdownValue = null;
//                       selectedOpenTime = null;
//                       selectedCloseTime = null;
//                     });
//                   }
//                 },
//                 child: const Text('Add Working Day'),
//               ),
//             ],
//           ),
//         const SizedBox(height: 16),
//         const Text('Selected Working Days:'),
//         _buildSelectedWorkingDaysList(),
//       ],
//     );
//   }

//   Widget _buildSelectedWorkingDaysList() {
//     return Column(
//       children: [
//         for (String day in selectedWorkingDays)
//           _buildWorkingDayItem(day),
//       ],
//     );
//   }

//   Widget _buildWorkingDayItem(String day) {
//     return Slidable(
//       actionPane: const SlidableDrawerActionPane(),
//       actionExtentRatio: 0.25,
//       secondaryActions: [
//         IconSlideAction(
//           caption: 'Delete',
//           color: Colors.red,
//           icon: Icons.delete,
//           onTap: () {
//             setState(() {
//               selectedWorkingDays.remove(day);
//               workingDayTimes.remove(day);
//             });
//           },
//         ),
//       ],
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 '$day - Open: ${workingDayTimes[day]?['open']} - Close: ${workingDayTimes[day]?['close']}',
//                 style: const TextStyle(fontSize: 18.0),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> registerShop(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       final shopData = {
//         'shopName': shopNameController.text,
//         'description': descriptionController.text,
//         'rating': ratingController.text,
//         'distance': distanceController.text,
//         'imagePath': imagePathController.text,
//         'services': selectedServices.map((e) => e.toJson()).toList(),
//         'products': selectedProducts.map((e) => e.toJson()).toList(),
//         'workingDays': selectedWorkingDays,
//       };

//       try {
//         final response = await http.post(
//           Uri.parse('$backendUrl/registerShop'),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: jsonEncode(shopData),
//         );

//         if (response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Shop registered successfully!')),
//           );
//         } else {
//           throw Exception('Failed to register shop');
//         }
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $error')),
//         );
//       }
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_ui/model/shop_products.dart';
import 'package:shop_ui/model/shop_services.dart';

class ShopRegistrationPage extends StatefulWidget {
  const ShopRegistrationPage({Key? key}) : super(key: key);

  @override
  _ShopRegistrationPageState createState() => _ShopRegistrationPageState();
}

class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();
  final String backendUrl = 'http://localhost:8080/api';

  List<ShopServices> availableServices = [];
  List<ShopProducts> availableProducts = [];
  List<ShopServices> selectedServices = [];
  List<ShopProducts> selectedProducts = [];
  List<String> selectedWorkingDays = [];
  Map<String, Map<String, String>> workingDayTimes = {};
  List<String> weekdays = [];
  double? rating;
  double? distance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedDayDropdownValue;
  String? selectedOpenTime;
  String? selectedCloseTime;
  ShopServices? selectedServiceDropdownValue;
  ShopProducts? selectedProductsDropdownValue;

  @override
  void initState() {
    super.initState();
    fetchDays();
    fetchServices();
    fetchProducts();
  }

  Future<void> fetchDays() async {
    final response = await http.get(Uri.parse('$backendUrl/days'));
    if (response.statusCode == 200) {
      final List<String> data = jsonDecode(response.body).cast<String>();
      setState(() {
        weekdays = data;
      });
    } else {
      throw Exception('Failed to load weekdays');
    }
  }

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

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('$backendUrl/getallproducts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        availableProducts = data
            .map((productJson) => ShopProducts.fromJson(productJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  List<String> generateTimeOptions() {
    final List<String> timeOptions = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        final time = DateTime(2000, 1, 1, hour, minute);
        final formattedTime =
            DateFormat.jm().format(time); // Format time in 12-hour format
        timeOptions.add(formattedTime);
      }
    }
    return timeOptions;
  }

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
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: ratingController,
                  decoration: const InputDecoration(labelText: 'Rating'),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // Allow decimal input
                  onChanged: (value) {
                    setState(() {
                      rating = double.tryParse(value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: distanceController,
                  decoration: const InputDecoration(labelText: 'Distance'),
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true), // Allow decimal input
                  onChanged: (value) {
                    setState(() {
                      distance = double.tryParse(value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: imagePathController,
                  decoration: const InputDecoration(labelText: 'ImagePath'),
                ),
                const SizedBox(height: 16),
                _buildServices(),
                const SizedBox(height: 16),
                _buildProducts(),
                const SizedBox(height: 16),
                _buildWorkingDaysAndTimesForm(),
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
                        content: Text('${selectedService.serviceName} already selected.'),
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

  Widget _buildProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Products', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<ShopProducts>(
                value: selectedProductsDropdownValue,
                items: availableProducts.map((product) {
                  return DropdownMenuItem<ShopProducts>(
                    value: product,
                    child: Text(product.productName),
                  );
                }).toList(),
                onChanged: (selectedProduct) {
                  setState(() {
                    selectedProductsDropdownValue = selectedProduct;
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Product'),
                isDense: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedProductsDropdownValue != null) {
                  setState(() {
                    selectedProducts.add(selectedProductsDropdownValue!);
                    selectedProductsDropdownValue = null;
                  });
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Selected Products:'),
        _buildSelectedProductsList(),
      ],
    );
  }

  Widget _buildSelectedProductsList() {
    return Column(
      children: [
        for (ShopProducts product in selectedProducts)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              product.productName,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
      ],
    );
  }

  Widget _buildWorkingDaysAndTimesForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Working Days and Times', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedDayDropdownValue,
                items: weekdays.map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
                onChanged: (selectedDay) {
                  setState(() {
                    selectedDayDropdownValue = selectedDay;
                    selectedOpenTime = null;
                    selectedCloseTime = null;
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Day'),
                isDense: true,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
        if (selectedDayDropdownValue != null)
          Column(
            children: [
              const Text('Open Time'),
              DropdownButtonFormField<String>(
                value: selectedOpenTime,
                items: generateTimeOptions().map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (openTime) {
                  setState(() {
                    selectedOpenTime = openTime;
                  });
                },
                decoration: const InputDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Close Time'),
              DropdownButtonFormField<String>(
                value: selectedCloseTime,
                items: generateTimeOptions().map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (closeTime) {
                  setState(() {
                    selectedCloseTime = closeTime;
                  });
                },
                decoration: const InputDecoration(),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> registerShop(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final shop = {
        'shopName': shopNameController.text,
        'description': descriptionController.text,
        'rating': rating,
        'distance': distance,
        'selectedServices': selectedServices.map((service) => service.toJson()).toList(),
        'selectedProducts': selectedProducts.map((product) => product.toJson()).toList(),
        'workingDays': selectedWorkingDays,
        'workingDayTimes': workingDayTimes,
        'imagePath': imagePathController.text,
      };
      
      final response = await http.post(
        Uri.parse('$backendUrl/savelaundryshop'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(shop),
      );

      if (response.statusCode == 200) {
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
