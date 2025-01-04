import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_ui/model/shop_details.dart';

class ApiService {
  final String backendUrl = 'http://localhost:8080/api';
  Future<LaundryShopRequest> fetchShopDetails(String shopName) async {
    final response =
        await http.get(Uri.parse('$backendUrl/get-details?shopName=$shopName'));
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Handling the nested JSON structure correctly
      return LaundryShopRequest.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load shop details');
    }
  }

Future<void> addDetails(Map<String, dynamic> payload) async {
    final response = await http.put(
      Uri.parse('$backendUrl/add-details/${payload["laundryShop"]["name"]}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add details');
    }
  }

    Future<List<String>> fetchWorkingDays() async {
    try {
      final response = await http.get(Uri.parse('$backendUrl/days'));
      if (response.statusCode == 200) {
        List<String> workingDays = List<String>.from(json.decode(response.body));
        return workingDays;
      } else {
        throw Exception('Failed to load working days');
      }
    } catch (e) {
      throw Exception('Failed to load working days: $e');
    }
  }
}
