import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_ui/model/shop_services.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final String backendUrl = 'http://localhost:8080/api';
  List<ShopServices> availableServices = [];
  List<ShopServices> selectedServices = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ShopServices? selectedServiceDropdownValue;

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  Future<void> fetchServices() async {
    final response = await http.get(Uri.parse('$backendUrl/getallservices'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        availableServices = data
            .map((serviceJson) => ShopServices.fromJson(serviceJson))
            .toList();
        // Set the first available service as the selected service
        if (availableServices.isNotEmpty) {
          selectedServiceDropdownValue = availableServices[0];
        }
      });
    } else {
      throw Exception('Failed to load services');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Registration'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Icon for navigation
            tooltip: 'Go to Login',
            onPressed: () {
              Navigator.pushNamed(
                  context, '/login'); // Replace '/login' with your login route
            },
          ),
        ],
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
                const SizedBox(height: 16),
                _buildServices(),
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
                hint: const Text('Select a service'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedServiceDropdownValue != null) {
                  final selectedService = selectedServiceDropdownValue!;
                  if (!selectedServices.contains(selectedService)) {
                    setState(() {
                      selectedServices.add(selectedService);
                      selectedServiceDropdownValue =
                          null; // Reset dropdown selection
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
      children: selectedServices.map((service) {
        return _buildServiceItem(service);
      }).toList(),
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

  Future<void> registerShop(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final shop = {
        'laundryShop': {
          'name': shopNameController.text,
          'address': addressController.text,
        },
        'services': selectedServices
            .map((service) => {
                  'id': service.id,
                  'serviceName': service.serviceName,
                  'iconName': service.iconName
                })
            .toList(),
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
