import 'package:flutter/material.dart';
import 'package:shop_ui/Widgets/api_services.dart';
import 'package:shop_ui/model/shop_details.dart';

class ShopDetailsPage extends StatefulWidget {
  const ShopDetailsPage({super.key});

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  late String shopName;
  late Future<LaundryShopRequest> shopDetails;
  final ApiService apiService = ApiService();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ratingsController = TextEditingController();
  final TextEditingController workingDaysController = TextEditingController();
  final TextEditingController workingTimeController = TextEditingController();

  List<String> workingDays = [];
  String? selectedDay;
  String? selectedOpenTime;
  String? selectedCloseTime;
  List<Map<String, String>> selectedWorkingDaysAndTimes = [];

  // Generate available times in 12-hour format with AM/PM
  List<String> generate12HourTimes() {
    List<String> times = [];
    for (int hour = 1; hour <= 12; hour++) {
      String period = hour < 12 ? 'AM' : 'PM';
      for (int minute = 0; minute < 60; minute += 30) {
        String formattedTime = '${hour.toString().padLeft(2, '0')}:${minute == 0 ? '00' : '30'} $period';
        times.add(formattedTime);
      }
    }
    return times;
  }

  // Available times generated
  List<String> availableTimes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    shopName = ModalRoute.of(context)?.settings.arguments as String;
    shopDetails = apiService.fetchShopDetails(shopName);
    availableTimes = generate12HourTimes(); // Generate available times once on load
    fetchWorkingDays(); // Fetch working days from the backend
  }

  // Function to fetch working days
  Future<void> fetchWorkingDays() async {
    try {
      List<String> days = await apiService.fetchWorkingDays();
      setState(() {
        workingDays = days;
      });
    } catch (e) {
      print('Error fetching working days: $e');
    }
  }

  // Function to convert 12-hour format time to 24-hour format
  String convertTo24HourFormat(String time) {
    final timeParts = time.split(" ");
    final hourMinute = timeParts[0].split(":");
    int hour = int.parse(hourMinute[0]);
    final minute = hourMinute[1];
    final period = timeParts[1];

    if (period == "PM" && hour != 12) {
      hour += 12;
    } else if (period == "AM" && hour == 12) {
      hour = 0;
    }

    return "${hour.toString().padLeft(2, '0')}:${minute}";
  }

  // Function to add working day and time to the list
  void addWorkingDayTime() {
    if (selectedDay != null && selectedOpenTime != null && selectedCloseTime != null) {
      setState(() {
        selectedWorkingDaysAndTimes.add({
          "day": selectedDay!,
          "openTime": convertTo24HourFormat(selectedOpenTime!),
          "closeTime": convertTo24HourFormat(selectedCloseTime!),
        });
      });
    }
  }

  // Function to submit the form
  Future<void> submitDetails() async {
    final description = descriptionController.text;
    final ratingsText = ratingsController.text;

    final List<Map<String, String>> workingDaysAndTimes = selectedWorkingDaysAndTimes;

    final Map<String, dynamic> payload = {
      "laundryShop": {"name": shopName},
      "shopAdditionalDetails": {
        "description": description,
        "ratings": [ratingsText],
      },
      "workingDaysAndTimes": workingDaysAndTimes,
    };

    try {
      await apiService.addDetails(payload);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to $shopName!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            FutureBuilder<LaundryShopRequest>(
              future: shopDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final shop = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${shop.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Address: ${shop.address}',
                                  style: const TextStyle(fontSize: 18)),
                              const SizedBox(height: 20),
                              const Text('Services:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              ...shop.services
                                  .map((service) => ListTile(
                                        leading: Icon(Icons
                                            .image), // Adjust this to use service.iconName for icons
                                        title: Text(service.serviceName),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No details available.'));
                }
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
            const Text('Add Additional Shop Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: ratingsController,
                      decoration: const InputDecoration(
                        labelText: 'Ratings (comma-separated)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Heading for Working Days and Time on a single line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Working Days and Time:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: addWorkingDayTime,
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Ensure that workingDays list is not empty
                    workingDays.isEmpty
                        ? const CircularProgressIndicator()
                        : DropdownButton<String>(
                            value: selectedDay,
                            hint: Text("Select Day"),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDay = newValue;
                              });
                            },
                            items: workingDays.map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                          ),
                    const SizedBox(height: 16),

                    // Ensure availableTimes is not empty
                    availableTimes.isEmpty
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                value: selectedOpenTime,
                                hint: const Text("Select Open Time"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedOpenTime = newValue;
                                  });
                                },
                                items: availableTimes.map((String time) {
                                  return DropdownMenuItem<String>(
                                    value: time,
                                    child: Text(time),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<String>(
                                value: selectedCloseTime,
                                hint: const Text("Select Close Time"),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCloseTime = newValue;
                                  });
                                },
                                items: availableTimes.map((String time) {
                                  return DropdownMenuItem<String>(
                                    value: time,
                                    child: Text(time),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),

                    // Display the selected working days and times
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedWorkingDaysAndTimes.length,
                      itemBuilder: (context, index) {
                        var entry = selectedWorkingDaysAndTimes[index];
                        return ListTile(
                          title: Text("${entry['day']}"),
                          subtitle: Text(
                              "Open: ${entry['openTime']}, Close: ${entry['closeTime']}"),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: submitDetails,
                      child: const Text('Submit Details'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
