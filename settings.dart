// Settings page
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:malhar_2023/login_page.dart';
import 'package:malhar_2023/main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  

  var isNotifEnabled = Hive.box('settings').get('isNotifEnabled');

  final _advancedDrawerController = AdvancedDrawerController();
  // bool isNotifEnabled = true;

  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
      disableGestures: false,
      drawerController: _advancedDrawerController,
      scaffold: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
          title: Text("Settings",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(255, 255, 255, 1),
              ))),
          backgroundColor: Color.fromARGB(255, 32, 3, 48),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: Color.fromARGB(255, 32, 3, 48)),
          child: Column(
            children: [
              // User instructions
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              color: Color.fromARGB(31, 211, 211, 211))
                        ],
                        color: Color.fromARGB(255, 204, 153, 209)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.brush_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Personalise your experience",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Row 1 on settings
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                    
                  },
                  child : FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              color: Color.fromARGB(31, 211, 211, 211))
                        ],
                        color: Color.fromARGB(255, 204, 153, 209)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Contingent Login",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          IconButton.outlined(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.login))
                        ],
                      ),
                    ),
                  ),
                )),
              ),
              // Row 2
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Color.fromARGB(255, 204, 153, 209)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Notifications & Reminders"),
                        ),
                        CupertinoSwitch(
                          value: isNotifEnabled,
                          onChanged: (value2) {
                            setState(() {
                              isNotifEnabled = value2;
                              print(isNotifEnabled);
                            });
                            final myBox = Hive.box('settings');
                            myBox.put('isNotifEnabled', isNotifEnabled);
                            
                            setNotif(myBox.get('isNotifEnabled'));
                            print(myBox.get('isNotifEnabled'));
                          },
                          trackColor: Color.fromARGB(255, 185, 133, 223),
                          activeColor: Color.fromARGB(255, 13, 0, 48),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              // Row 3
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: FractionallySizedBox(
              //     widthFactor: 0.9,
              //     child: Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(3),
              //         boxShadow: [
              //           BoxShadow(
              //               spreadRadius: 1.5,
              //               blurRadius: 4,
              //               color: Color.fromARGB(31, 211, 211, 211))
              //         ],
              //         color: Color.fromARGB(255, 204, 153, 209),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(16.0),
              //               child: Text("Something else"),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              color: Color.fromARGB(31, 211, 211, 211))
                        ]),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.secondary,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("DONE"),
                          )),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
