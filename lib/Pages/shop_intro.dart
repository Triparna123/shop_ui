// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:shop_ui/Pages/login.dart';
// import 'package:shop_ui/misc/shop_color.dart';

// class ShopIntro extends StatefulWidget {
//   const ShopIntro({super.key});

//   @override
//   ShopIntroState createState() => ShopIntroState();
// }

// class ShopIntroState extends State<ShopIntro> {
//   // final PageController _pageController = PageController(initialPage: 0);

//   int _currentPage = 0;
//   final List<String> imageList = [
//     "images/wash.png",
//     "images/wash.png",
//     "images/wash.png",
//   ];
//   final List<List<Widget>> textContents = [
//     [const Text("Text for Page 1")],
//     [const Text("Text for Page 2")],
//     [
//       Text(
//         "Manage Customers",
//         style: TextStyle(
//             color: ShopColor.shopUiColor,
//             fontSize: 25,
//             fontWeight: FontWeight.bold),
//       ),
//       Text(
//         "and Business",
//         style: TextStyle(
//             color: ShopColor.shopUiColor,
//             fontSize: 25,
//             fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(
//         height: 10,
//       ),
//       const Text(
//         "We care about customers first."
//         "\n After submitting order,we will pick up your"
//         "\n clothes as you set the time",
//         style: TextStyle(color: Colors.black, fontSize: 14),
//         textAlign: TextAlign.center,
//       ),
//     ],
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//       CarouselSlider(
//         options: CarouselOptions(
//           height: MediaQuery.of(context).size.height,
//           enableInfiniteScroll: false,
//           viewportFraction: 1.0,
//           onPageChanged: (index, reason) {
//             setState(() {
//               _currentPage = index;
//             });
//           },
//         ),
//         items: imageList.map((imagePath) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Column(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height / 2,
//                     decoration: BoxDecoration(
//                       color: ShopColor.shopUiColor1,
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(30.0),
//                         bottomRight: Radius.circular(30.0),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height / 2,
//                     color: Colors.white,
//                     padding: const EdgeInsets.all(16.0),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ...textContents[_currentPage],
//                           if (_currentPage < imageList.length - 1)
//                             GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   if (_currentPage < imageList.length - 1) {
//                                     _currentPage++;
//                                   }
//                                 });
//                               },
//                               child: const Icon(
//                                 Icons.arrow_forward,
//                                 size: 36,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                           if (_currentPage == imageList.length - 1)
//                             GestureDetector(
//                               onTap: () {
//                                 // Navigate to the home page when on the last page
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>Login(),
//                                     ),

//                                 );
//                               },
//                               child: const Icon(
//                                 Icons.arrow_forward,
//                                 size: 36, // Customize the icon size
//                                 color: Colors.blue, // Customize the icon color
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         }).toList(),
//       ),

//       // Page number in top left corner
//       Positioned(
//         top: 20.0,
//         left: 20.0,
//         child: Text(
//           "${_currentPage + 1}/${imageList.length}",
//           style: TextStyle(color: ShopColor.shopUiColor),
//         ),
//       ),
//       // Skip
//       Positioned(
//         top: 20.0,
//         right: 20.0,
//         child: GestureDetector(
//           onTap: () {
//             setState(() {});
//             // Handle skip button action
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>Login(),
                
//               ),
//             );
//           },
//           child: const Text('Skip'),
//         ),
//       )
//     ]));
//   }
// }
