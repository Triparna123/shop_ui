class LaundryShopRequest {
  final String name;
  final String address;
  final List<Service> services;

  LaundryShopRequest({required this.name, required this.address, required this.services});

  factory LaundryShopRequest.fromJson(Map<String, dynamic> json) {
    var list = json['services'] as List;
    List<Service> servicesList = list.map((i) => Service.fromJson(i)).toList();

    return LaundryShopRequest(
      name: json['laundryShop']['name'], // Accessing nested 'laundryShop' object
      address: json['laundryShop']['address'], // Accessing nested 'laundryShop' object
      services: servicesList,
    );
  }
}

class Service {
  final String serviceName;
  final String iconName;

  Service({required this.serviceName, required this.iconName});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceName: json['serviceName'],
      iconName: json['iconName'],
    );
  }
}
