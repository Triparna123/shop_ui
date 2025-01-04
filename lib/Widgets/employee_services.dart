import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';
import 'package:shop_ui/model/shop_services.dart';
import 'package:http/http.dart' as http;

class EmployeeServices extends StatefulWidget {
  final String shopName; // Pass shop name from login
  const EmployeeServices({required this.shopName, Key? key}) : super(key: key);

  @override
  EmployeeServicesState createState() => EmployeeServicesState();
}

class EmployeeServicesState extends State<EmployeeServices> {
  final String backendUrl = 'http://localhost:8080/api';

  Future<List<ShopServices>> fetchServices(String shopName) async {
    final response = await http.get(Uri.parse('$backendUrl/$shopName/services'));

    if (response.statusCode == 200) {
      List<dynamic> servicesJson = json.decode(response.body);
      return servicesJson.map((json) => ShopServices.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  late Future<List<ShopServices>> servicesFuture;

  @override
  void initState() {
    super.initState();
    servicesFuture = fetchServices(widget.shopName); // Initialize with shop name
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ShopServices>>(
      future: servicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No services available'));
        } else {
          final services = snapshot.data!;
          return SizedBox(
            height: 150, // Constrain the height for horizontal ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Card(
                        elevation: 3,
                        shadowColor: Colors.black,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                service.iconData,
                                color: Colors.black,
                                size: 40,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                service.serviceName,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ShopColor.shopUiColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
