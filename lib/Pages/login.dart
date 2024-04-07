
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_ui/misc/shop_color.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
              child: Text(
            'Login to grow !',
            style: TextStyle(
                color: ShopColor.shopUiColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "Candara"),
          )),
        ),
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 50,
                width: 300,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Search for a Company name",
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 50,
                width: 300,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Username/Email Address",
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 50,
                width: 300,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
         Padding(
           padding: const EdgeInsets.only(left: 10),
           child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                ),
                Text("Are you an owner?"),
              ],
            ),
         ),
         SizedBox(height: 10,),
       ElevatedButton(
            onPressed: () {
              // Handle login based on the checkbox state
              if (isChecked) {
                 Navigator.pushReplacementNamed(context, '/ownerHome');
              } else {
                // Navigate to employee home page
                 Navigator.pushReplacementNamed(context, '/employeeHome');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ShopColor.shopUiColor1, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 60,
              height: 40,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: Text('OR',
                style: TextStyle(
                    color: ShopColor.shopUiColor,
                    // fontWeight: FontWeight.bold,
                    fontSize: 15))),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // First Image
            //  Expanded(
            //    child: Image.asset(
            //       'images/google.png', // replace with your image path
            //       // fit: BoxFit.contain,
            //       width: 30,
            //       height:30 // adjust the fit as needed
            //     ),
            //  ),
            


            // // Second Image
            //  Expanded(
            //    child: Image.asset(
            //       'images/linkedln.png', // replace with your image path
            //       // fit: BoxFit.contain,
            //       width: 30,
            //       height:30 // adjust the fit as needed
            //     ),
            //  ),
            
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: 250,
          height: 40,
        
          decoration: BoxDecoration(
            color: ShopColor.shopUiColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
              child: Text(
            'Want to register your Business',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ),
      ]),
    );
  }
}
