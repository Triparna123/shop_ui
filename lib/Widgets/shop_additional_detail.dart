import 'package:flutter/material.dart';
import 'package:shop_ui/Widgets/api_services.dart';

class AddDetailsPage extends StatelessWidget {
  final String shopName;

  AddDetailsPage({Key? key, required this.shopName}) : super(key: key);

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ratingsController = TextEditingController();
  final TextEditingController workingDaysController = TextEditingController();
  final ApiService apiService = ApiService();

  Future<void> submitDetails() async {
    final payload = {
      "laundryShop": {"name": shopName},
      "shopAdditionalDetails": {
        "description": descriptionController.text,
        "ratings": ratingsController.text.split(','),
      },
      "workingDaysAndTimes": workingDaysController.text.split(',').map((day) => {"day": day}).toList(),
    };

    try {
      await apiService.addDetails(payload);
      print('Details added successfully');
    } catch (e) {
      print('Error adding details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Shop Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: ratingsController,
              decoration: const InputDecoration(labelText: 'Ratings (comma-separated)'),
            ),
            TextField(
              controller: workingDaysController,
              decoration: const InputDecoration(labelText: 'Working Days (comma-separated)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await submitDetails();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Details added successfully!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
