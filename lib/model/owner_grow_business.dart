import 'package:flutter/material.dart';

class EmployeeGrowBusiness {
  final int id;
  final IconData iconData;
  final String details;

  EmployeeGrowBusiness(
      {required this.id, required this.iconData, required this.details});
}

final List<EmployeeGrowBusiness> ownerBusiness = [
  EmployeeGrowBusiness(
      id: 1, iconData: Icons.person_add_alt_1, details: 'Employee'),
  EmployeeGrowBusiness(id: 2, iconData: Icons.report, details: 'Revenue'),
  EmployeeGrowBusiness(
      id: 3, iconData: Icons.attach_money, details: 'Pricing'),
  EmployeeGrowBusiness(id: 4, iconData: Icons.report, details: 'Reports'),
];
