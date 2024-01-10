// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:malhar_2023/constants/dino_constants.dart';
import 'package:malhar_2023/credentials/credentials.dart';
import 'package:malhar_2023/dino_run_components.dart/cactus.dart';
import 'package:malhar_2023/dino_run_components.dart/cloud.dart';
import 'package:malhar_2023/dino_run_components.dart/dino.dart';
import 'package:malhar_2023/dino_run_components.dart/game_object.dart';
import 'package:malhar_2023/dino_run_components.dart/ground.dart';
import 'package:gsheets/gsheets.dart';
// import 'cactus.dart';
// import 'cloud.dart';
// import 'dino.dart';
// import 'game_object.dart';
// import 'ground.dart';
// import 'constants.dart';

//change my home page to DinoRunGame
class DinoRunGame extends StatefulWidget {
  const DinoRunGame({Key? key}) : super(key: key);
  @override
  _DinoRunGame createState() => _DinoRunGame();
}

class _DinoRunGame extends State<DinoRunGame>
    with SingleTickerProviderStateMixin {
  Dino dino = Dino();
  double runVelocity = initialVelocity;
  double runDistance = 0;
  int highScore = 0;
  TextEditingController gravityController =
      TextEditingController(text: gravity.toString());
  TextEditingController accelerationController =
      TextEditingController(text: acceleration.toString());
  TextEditingController jumpVelocityController =
      TextEditingController(text: jumpVelocity.toString());
  TextEditingController runVelocityController =
      TextEditingController(text: initialVelocity.toString());
  TextEditingController dayNightOffestController =
      TextEditingController(text: dayNightOffest.toString());

  late AnimationController worldController;
  Duration lastUpdateCall = const Duration();

  List<Cactus> cacti = [Cactus(worldLocation: const Offset(200, 0))];

  List<Ground> ground = [
    Ground(worldLocation: const Offset(0, 0)),
    Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
  ];

  List<Cloud> clouds = [
    Cloud(worldLocation: const Offset(100, 20)),
    Cloud(worldLocation: const Offset(200, 10)),
    Cloud(worldLocation: const Offset(350, -10)),
  ];

  var mobile = TextEditingController();

  Future<bool> insertData(int mobile, int score, Worksheet workSheet) {
    return workSheet.values
        .appendRow([mobile, score, DateTime.now().toString()]);
  }

  final sheetsId = '1t_rLlbvVin90G8Z6Jg5Gy0NOCBFY_jOwvxzz0R9QORA';
  final worksheetId = 136977839;
  final gsheets = GSheets(credentials);

  var leaderHighScore = "";

  Future<String> fetchScore() async {
    // Open sheet
    print("Fetching score");
    final sheet = await gsheets.spreadsheet(sheetsId);
    var workSheet = sheet.worksheetById(worksheetId);
    var result = await workSheet!.values.value(column: 5, row: 2);
    print(result);
    leaderHighScore = result;
    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchScore();
    worldController =
        AnimationController(vsync: this, duration: const Duration(days: 99));
    worldController.addListener(_update);
    // worldController.forward();
    _welcome();
  }

  void _welcome() {
    setState(() {
      worldController.forward();
    });
  }

  void _die() {
    setState(() {
      worldController.stop();
      dino.die();
    });
  }

  void _newGame() {
    setState(() {
      highScore = max(highScore, runDistance.toInt());
      runDistance = 0;
      runVelocity = initialVelocity;
      dino.state = DinoState.running;
      dino.dispY = 0;
      worldController.reset();
      cacti = [
        Cactus(worldLocation: const Offset(200, 0)),
        Cactus(worldLocation: const Offset(300, 0)),
        Cactus(worldLocation: const Offset(450, 0)),
      ];

      ground = [
        Ground(worldLocation: const Offset(0, 0)),
        Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
      ];

      clouds = [
        Cloud(worldLocation: const Offset(100, 20)),
        Cloud(worldLocation: const Offset(200, 10)),
        Cloud(worldLocation: const Offset(350, -15)),
        Cloud(worldLocation: const Offset(500, 10)),
        Cloud(worldLocation: const Offset(550, -10)),
      ];

      worldController.forward();
    });
  }

  void _retry() {
    setState(() {
      highScore = max(highScore, runDistance.toInt());
      runDistance = 0;
      runVelocity = initialVelocity + 20;
      dino.state = DinoState.running;
      dino.dispY = 0;
      worldController.reset();
      cacti = [
        Cactus(worldLocation: const Offset(200, 0)),
        Cactus(worldLocation: const Offset(300, 0)),
        Cactus(worldLocation: const Offset(450, 0)),
      ];

      ground = [
        Ground(worldLocation: const Offset(0, 0)),
        Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
      ];

      clouds = [
        Cloud(worldLocation: const Offset(100, 20)),
        Cloud(worldLocation: const Offset(200, 10)),
        Cloud(worldLocation: const Offset(350, -15)),
        Cloud(worldLocation: const Offset(500, 10)),
        Cloud(worldLocation: const Offset(550, -10)),
      ];

      worldController.forward();
    });
  }

  _update() {
    try {
      double elapsedTimeSeconds;
      dino.update(lastUpdateCall, worldController.lastElapsedDuration);
      try {
        elapsedTimeSeconds =
            (worldController.lastElapsedDuration! - lastUpdateCall)
                    .inMilliseconds /
                1000;
      } catch (_) {
        elapsedTimeSeconds = 0;
      }

      runDistance += runVelocity * elapsedTimeSeconds;
      if (runDistance < 0) runDistance = 0;
      runVelocity += acceleration * elapsedTimeSeconds;

      Size screenSize = MediaQuery.of(context).size;

      Rect dinoRect = dino.getRect(screenSize, runDistance);
      for (Cactus cactus in cacti) {
        Rect obstacleRect = cactus.getRect(screenSize, runDistance);
        if (dinoRect.overlaps(obstacleRect.deflate(20))) {
          _die();
        }

        if (obstacleRect.right < 0) {
          setState(() {
            cacti.remove(cactus);
            cacti.add(Cactus(
                worldLocation: Offset(
                    runDistance +
                        Random().nextInt(200) +
                        MediaQuery.of(context).size.width / worlToPixelRatio,
                    0)));
          });
        }
      }

      for (Ground groundlet in ground) {
        if (groundlet.getRect(screenSize, runDistance).right < 0) {
          setState(() {
            ground.remove(groundlet);
            ground.add(
              Ground(
                worldLocation: Offset(
                  ground.last.worldLocation.dx + groundSprite.imageWidth / 10,
                  0,
                ),
              ),
            );
          });
        }
      }

      for (Cloud cloud in clouds) {
        if (cloud.getRect(screenSize, runDistance).right < 0) {
          setState(() {
            clouds.remove(cloud);
            clouds.add(
              Cloud(
                worldLocation: Offset(
                  clouds.last.worldLocation.dx +
                      Random().nextInt(200) +
                      MediaQuery.of(context).size.width / worlToPixelRatio,
                  Random().nextInt(50) - 25.0,
                ),
              ),
            );
          });
        }
      }

      lastUpdateCall = worldController.lastElapsedDuration!;
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    gravityController.dispose();
    accelerationController.dispose();
    jumpVelocityController.dispose();
    runVelocityController.dispose();
    dayNightOffestController.dispose();
    super.dispose();
  }

  int randomBg = Random().nextInt(1);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];

    for (GameObject object in [...clouds, ...ground, ...cacti, dino]) {
      children.add(
        AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            Rect objectRect = object.getRect(screenSize, runDistance);
            return Positioned(
              left: objectRect.left,
              top: objectRect.top,
              width: objectRect.width,
              height: objectRect.height,
              child: object.render(),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 5000),
        color: (runDistance ~/ dayNightOffest) % 2 == 0
            ? Colors.white
            : Colors.black,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (dino.state != DinoState.dead) {
              dino.jump();
            }
            if (dino.state == DinoState.dead) {
              _newGame();
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(
              //   left: 0,
              //   right: 0,
              //   top: 450,
              //   bottom: 0,
              //   child: Container(
              //       width: double.infinity,
              //       height: 200,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage("assets/images/cacti/dino_water.png"),
              //           fit: BoxFit.cover,
              //         ),
              //       )),
              // ),

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xff0001000),
                    )),
              ),

              ...children,
              AnimatedBuilder(
                animation: worldController,
                builder: (context, _) {
                  return Positioned(
                    left: screenSize.width / 2 - 30,
                    top: 100,
                    child: Text(
                      'Score: ' + runDistance.toInt().toString(),
                      style: TextStyle(
                        color:
                            //  (runDistance ~/ dayNightOffest) % 2 == 0
                            //     ? Colors.black
                            //     :
                            Colors.white,
                      ),
                    ),
                  );
                },
              ),
              // AnimatedBuilder(
              //   animation: worldController,
              //   builder: (context, _) {
              //     return Positioned(
              //       left: screenSize.width / 2 - 65,
              //       top: 120,
              //       child: Text(
              //         'Player High Score: ' + highScore.toString(),
              //         style: TextStyle(
              //           color:
              //           //  (runDistance ~/ dayNightOffest) % 2 == 0
              //           //     ? Colors.black
              //           //     :
              //                Colors.white,
              //         ),
              //       ),
              //     );
              //   },
              // ),

              // if (dino.state == DinoState.welcome)
              //   Center(
              //     child: Container(
              //       height: 300,
              //       width: 300,
              //       color: Colors.pink,
              //     ),
              //   ),
              if (dino.state == DinoState.dead)
                IgnorePointer(
                    ignoring: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: Center(
                        child: SizedBox(
                          height: 350,
                          width: 350,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Set the clip behavior of the card
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define the child widgets of the card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/game over.png',
                                      height: 60,
                                      width: 280,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Add a container with padding that contains the card's title, text, and buttons
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Display the card's title using a font size of 24 and a dark grey color

                                      Text(
                                        "Your Score: " +
                                            runDistance.toInt().toString(),
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Color(0xff001900),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Add a space between the title and the text
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "High Score: $leaderHighScore",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff001900),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // A
                                      // Display the card's text using a font size of 15 and a light grey color
                                      Divider(
                                        color: Color(0xff001900),
                                      ),
                                      // Add a space between the title and the text
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // High Score
                                      // Text(
                                      //   "High Score: $highScore",
                                      //   style: TextStyle(
                                      //       fontSize: 20,
                                      //       color: Colors.purple[900],
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                      // // Add a row with two buttons spaced apart and aligned to the right side of the card
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // Add a spacer to push the buttons to the right side of the card

                                          // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text

                                          SizedBox(
                                            width: 145,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          'Enter mobile number',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff001900),
                                                              fontSize: 26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        content: TextFormField(
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xff001900),
                                                          ),
                                                          controller: mobile,
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please enter some text';
                                                            } else if (value
                                                                    .length !=
                                                                10) {
                                                              return 'Please enter valid mobile number';
                                                            }
                                                            return null;
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            filled: true,
                                                            fillColor: Color(
                                                                    0xff001900)
                                                                .withOpacity(
                                                                    0.2),

                                                            alignLabelWithHint:
                                                                true,
                                                            hintText:
                                                                'Mobile Number',
                                                            prefixText:
                                                                '+91 | ',
                                                            hintStyle:
                                                                TextStyle(
                                                              color: Color(
                                                                      0xff001900)
                                                                  .withOpacity(
                                                                      0.2),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),

                                                            isDense: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(15),

                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xff001900)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            // prefixText: '+91 | ',
                                                            prefixStyle:
                                                                TextStyle(
                                                              color: Color(
                                                                  0xff001900),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 40,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    // Open sheet
                                                                    final sheet =
                                                                        await gsheets
                                                                            .spreadsheet(sheetsId);
                                                                    var workSheet =
                                                                        sheet.worksheetById(
                                                                            worksheetId);

                                                                    // Insert data into sheet
                                                                    insertData(
                                                                        int.parse(mobile
                                                                            .value
                                                                            .text),
                                                                        runDistance
                                                                            .toInt(),
                                                                        workSheet!);
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Data received successfully !')),
                                                                    );
                                                                  } catch (e) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                          content:
                                                                              Text('Unexpected error occured !')),
                                                                    );
                                                                  }

                                                                  Navigator.pop(
                                                                      context);
                                                                  // resetGame();
                                                                }, //This prop for beautiful expressions
                                                                child: const Text(
                                                                    "Submit"), // This child can be everything. I want to choose a beautiful Text Widget
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  minimumSize:
                                                                      const Size(
                                                                          200,
                                                                          100), //change size of this beautiful button
                                                                  // We can change style of this beautiful elevated button thanks to style prop
                                                                  // surface color
                                                                  shadowColor:
                                                                      Colors
                                                                          .grey, //shadow prop is a very nice prop for every button or card widgets.
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xff001900), // we can set elevation of this beautiful button
                                                                  side: const BorderSide(
                                                                      color: Color(0xff001900), //change border color
                                                                      width: 2, //change border width
                                                                      style: BorderStyle.solid), // change border side of this beautiful button
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }, //This prop for beautiful expressions
                                              child: const Text(
                                                  "Submit Score"), // This child can be everything. I want to choose a beautiful Text Widget
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minimumSize: const Size(200,
                                                    100), //change size of this beautiful button
                                                // We can change style of this beautiful elevated button thanks to style prop
                                                // surface color
                                                shadowColor: Colors
                                                    .grey, //shadow prop is a very nice prop for every button or card widgets.
                                                elevation:
                                                    5, // we can set elevation of this beautiful button
                                                backgroundColor:
                                                    Color(0xff001900),
                                                side: const BorderSide(
                                                    color: Color(
                                                        0xff001900), //change border color
                                                    width:
                                                        2, //change border width
                                                    style: BorderStyle
                                                        .solid), // change border side of this beautiful button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                          SizedBox(
                                            width: 145,
                                            height: 40,
                                            child: ElevatedButton(
                                              onPressed: _retry,
                                              child: const Text(
                                                  "Try again"), // This child can be everything. I want to choose a beautiful Text Widget
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                minimumSize: const Size(200,
                                                    100), //change size of this beautiful button
                                                // We can change style of this beautiful elevated button thanks to style prop
                                                // surface color
                                                shadowColor: Colors
                                                    .grey, //shadow prop is a very nice prop for every button or card widgets.
                                                elevation: 5,
                                                backgroundColor: Color(
                                                    0xff001900), // we can set elevation of this beautiful button
                                                side: const BorderSide(
                                                    color: Color(
                                                        0xff001900), //change border color
                                                    width:
                                                        2, //change border width
                                                    style: BorderStyle
                                                        .solid), // change border side of this beautiful button
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30), //change border radius of this beautiful button thanks to BorderRadius.circular function
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Add a small space between the card and the next widget
                                Container(height: 5),
                              ],
                            ),
                          ),
                        ),
                        // child: Container(
                        //   height: height / 4,
                        //   width: width / 2,
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(12),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             blurRadius: 1,
                        //             spreadRadius: 2,
                        //             color: Colors.black26)
                        //       ]),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text("Score: " + playerScore.toString()),
                        //       ElevatedButton(
                        //           onPressed: () {
                        //             showDialog(
                        //                 context: context,
                        //                 builder: (context) {
                        //                   return AlertDialog(
                        //                     title:
                        //                         Text('Enter mobile number'),
                        //                     content: TextFormField(
                        //                       controller: mobile,
                        //                       decoration: InputDecoration(
                        //                           hintText: "Mobile"),
                        //                       validator: (value) {
                        //                         if (value == null ||
                        //                             value.isEmpty) {
                        //                           return 'Please enter some text';
                        //                         } else if (value.length !=
                        //                             10) {
                        //                           return 'Please enter valid mobile number';
                        //                         }
                        //                         return null;
                        //                       },
                        //                     ),
                        //                     actions: [
                        //                       ElevatedButton(
                        //                           onPressed: () async {
                        //                             try {
                        //                               // Open sheet
                        //                               final sheet =
                        //                                   await gsheets
                        //                                       .spreadsheet(
                        //                                           sheetsId);
                        //                               var workSheet = sheet
                        //                                   .worksheetById(
                        //                                       worksheetId);

                        //                               // Insert data into sheet
                        //                               insertData(
                        //                                   int.parse(mobile
                        //                                       .value.text),
                        //                                   playerScore,
                        //                                   workSheet!);
                        //                               ScaffoldMessenger.of(
                        //                                       context)
                        //                                   .showSnackBar(
                        //                                 const SnackBar(
                        //                                     content: Text(
                        //                                         'Data received successfully !')),
                        //                               );
                        //                             } catch (e) {
                        //                               ScaffoldMessenger.of(
                        //                                       context)
                        //                                   .showSnackBar(
                        //                                 const SnackBar(
                        //                                     content: Text(
                        //                                         'Unexpected error occured !')),
                        //                               );
                        //                             }

                        //                             Navigator.pop(context);
                        //                             resetGame();
                        //                           },
                        //                           child: Text("Submit"))
                        //                     ],
                        //                   );
                        //                 });
                        //           },
                        //           child: Text("Submit Score")),
                        //       ElevatedButton(
                        //           onPressed: resetGame,
                        //           child: Text("Try again")),
                        //     ],
                        //   ),
                        // ),
                      ),
                    )),

              // Positioned(
              //   right: 20,
              //   top: 20,
              //   child: IconButton(
              //     icon: const Icon(Icons.settings),
              //     onPressed: () {
              //       _die();
              //       showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: const Text("Change Physics"),
              //             actions: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SizedBox(
              //                   height: 25,
              //                   width: 280,
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const Text("Gravity:"),
              //                       SizedBox(
              //                         child: TextField(
              //                           controller: gravityController,
              //                           key: UniqueKey(),
              //                           keyboardType: TextInputType.number,
              //                           decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                           ),
              //                         ),
              //                         height: 25,
              //                         width: 75,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SizedBox(
              //                   height: 25,
              //                   width: 280,
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const Text("Acceleration:"),
              //                       SizedBox(
              //                         child: TextField(
              //                           controller: accelerationController,
              //                           key: UniqueKey(),
              //                           keyboardType: TextInputType.number,
              //                           decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                           ),
              //                         ),
              //                         height: 25,
              //                         width: 75,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SizedBox(
              //                   height: 25,
              //                   width: 280,
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const Text("Initial Velocity:"),
              //                       SizedBox(
              //                         child: TextField(
              //                           controller: runVelocityController,
              //                           key: UniqueKey(),
              //                           keyboardType: TextInputType.number,
              //                           decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                           ),
              //                         ),
              //                         height: 25,
              //                         width: 75,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SizedBox(
              //                   height: 25,
              //                   width: 280,
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const Text("Jump Velocity:"),
              //                       SizedBox(
              //                         child: TextField(
              //                           controller: jumpVelocityController,
              //                           key: UniqueKey(),
              //                           keyboardType: TextInputType.number,
              //                           decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                           ),
              //                         ),
              //                         height: 25,
              //                         width: 75,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SizedBox(
              //                   height: 25,
              //                   width: 280,
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       const Text("Day-Night Offset:"),
              //                       SizedBox(
              //                         child: TextField(
              //                           controller: dayNightOffestController,
              //                           key: UniqueKey(),
              //                           keyboardType: TextInputType.number,
              //                           decoration: InputDecoration(
              //                             border: OutlineInputBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(5),
              //                             ),
              //                           ),
              //                         ),
              //                         height: 25,
              //                         width: 75,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               TextButton(
              //                 onPressed: () {
              //                   gravity = int.parse(gravityController.text);
              //                   acceleration =
              //                       double.parse(accelerationController.text);
              //                   initialVelocity =
              //                       double.parse(runVelocityController.text);
              //                   jumpVelocity =
              //                       double.parse(jumpVelocityController.text);
              //                   dayNightOffest =
              //                       int.parse(dayNightOffestController.text);
              //                   Navigator.of(context).pop();
              //                 },
              //                 child: const Text(
              //                   "Done",
              //                   style: TextStyle(color: Colors.grey),
              //                 ),
              //               )
              //             ],
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              // Positioned(
              //   bottom: 10,
              //   child: TextButton(
              //     onPressed: () {
              //       _die();
              //     },
              //     child: const Text(
              //       "Force Kill Dino",
              //       style: TextStyle(color: Colors.red),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
