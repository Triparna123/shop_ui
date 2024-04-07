import 'package:flutter/material.dart';

class ShopServices {
  final int id;
  final String serviceName;
  final String iconName;

  ShopServices({
    required this.id,
    required this.serviceName,
    required this.iconName,
  });

  static final Map<String, IconData> iconMapping = {
    'wash': Icons.wash,
    'washAndIron': Icons.iron,
    'dry clean': Icons.dry_cleaning,
    // Add more mappings as needed
  };

  IconData get iconData {
    return iconMapping[iconName] ?? Icons.error; // Default icon for unknown iconName
  }

  factory ShopServices.fromJson(Map<String, dynamic> json) {
    return ShopServices(
      id: json['id'] as int,
      serviceName: json['serviceName'] as String,
      iconName: json['iconName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'iconName': iconName,
    };
  }
}
