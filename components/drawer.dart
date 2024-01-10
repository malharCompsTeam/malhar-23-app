import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malhar_2023/main.dart';
import '../pages/contact.dart';
import '../pages/blog.dart';
import '../pages/shop.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 169, 171, 220),
            Color.fromARGB(255, 212, 191, 212)
          ], transform: GradientRotation(5))),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: SizedBox(
                  height: AppBar().preferredSize.height,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Get.to(MyHomePage(title: "Home"));
                },
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: const Text('Blog'),
                onTap: () {
                  Get.to(Blog());
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_rounded),
                title: const Text('Shop'),
                onTap: () {
                  Get.to(Shop());
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: const Text('Contact us'),
                onTap: () {
                  Get.to(const Contact());
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      );
  }
}