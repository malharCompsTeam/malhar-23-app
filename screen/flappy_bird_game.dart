// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'package:gsheets/gsheets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:malhar_2023/constants/constants.dart';
import 'package:malhar_2023/util/util.dart';
import 'package:malhar_2023/widgets/flappy_bird.dart';
import 'package:flutter/material.dart';
import '../credentials/credentials.dart';
import '../dimen/game_dimen.dart';

enum GameState { welcome, playing, ending, ended }

enum PipeColor { green, red }

enum BackgroundState { day, night }

class FlappyBirdGame extends StatefulWidget {
  const FlappyBirdGame({Key? key}) : super(key: key);

  @override
  State<FlappyBirdGame> createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<FlappyBirdGame> {
  AudioPlayer wingPlayer = AudioPlayer();
  AudioPlayer diePlayer = AudioPlayer();
  AudioPlayer hitPlayer = AudioPlayer();
  AudioPlayer pointPlayer = AudioPlayer();

  Future<void> playWing() {
    if (wingPlayer.state == PlayerState.playing) wingPlayer.stop();
    return wingPlayer.play(AssetSource('audio/wing.wav'));
  }

  Future<void> playDie() {
    if (diePlayer.state == PlayerState.playing) diePlayer.stop();
    return diePlayer.play(AssetSource('audio/die.wav'));
  }

  Future<void> playHit() {
    if (hitPlayer.state == PlayerState.playing) hitPlayer.stop();
    return hitPlayer.play(AssetSource('audio/hit.wav'));
  }

  Future<void> playPoint() {
    if (pointPlayer.state == PlayerState.playing) pointPlayer.stop();
    return pointPlayer.play(AssetSource('audio/point.wav'));
  }

  var gameState = GameState.welcome;
  var backgroundState = BackgroundState.values[Random().nextInt(2)];
  var pipeColor = PipeColor.values[Random().nextInt(2)];
  var isUpdating = false;
  var baseShiftX = 0.0;

  double visibleRotation = 0;

  @override
  void dispose() {
    wingPlayer.dispose();
    diePlayer.dispose();
    hitPlayer.dispose();
    pointPlayer.dispose();
    super.dispose();
  }

  var playerScore = 0;
  var highScore = "0";

  var pipes = <Pipes>[];
  final pipeLocation = <Map<String, double>>[];
  final wingLocations = [0, 1, 2, 1];
  var wingPosIndex = 1;
  var flappyBirdState = {
    flappyBirdX: flappyBirdStartingPos['x']!,
    flappyBirdY: flappyBirdStartingPos['y']!,
    flappyBirdRotationDeg: 0.0,
    flappyBirdColor: BirdColor.values[Random().nextInt(3)],
    flappyBirdFlightStage: FlightStage.mid,
    flappyBirdIsJumping: false,
    flappyBirdDir: 1,
    heightToJump: 0,
    flappyBirdIsFalling: false,
  };

  // player velocity, max velocity, downward acceleration, acceleration on flap
  var playerVelY =
      -9; // player's velocity along Y, default same as playerFlapped
  var playerMaxVelY = 10; // max vel along Y, max descend speed
  var playerMinVelY = -8; // min vel along Y, max ascend speed
  var playerAccY = 1; // players downward acceleration
  // var playerRot = 45; // player's rotation
  var playerVelRot = 1.2; // angular speed
  var playerRotThr = -20.0; // rotation threshold
  var playerFlapAcc = -9; // players speed on flapping
  // var playerFlapped = false; True when player flaps

  static const scoreAssets = [
    "assets/images/0.png",
    "assets/images/1.png",
    "assets/images/2.png",
    "assets/images/3.png",
    "assets/images/4.png",
    "assets/images/5.png",
    "assets/images/6.png",
    "assets/images/7.png",
    "assets/images/8.png",
    "assets/images/9.png"
  ];
  final audioAssets = [
    "assets/audio/wing.wav",
    "assets/audio/die.wav",
    "assets/audio/hit.wav",
    "assets/audio/point.wav",
    "assets/audio/swoosh.wav"
  ];

  var mobile = TextEditingController();

  // Game sheet details
  final sheetsId = '1t_rLlbvVin90G8Z6Jg5Gy0NOCBFY_jOwvxzz0R9QORA';
  final worksheetId = 0;

  final gsheets = GSheets(credentials);

  Future<bool> insertData(int mobile, int score, Worksheet workSheet) {
    return workSheet.values
        .appendRow([mobile, score, DateTime.now().toString()]);
  }

  Future<String> fetchScore() async {
    // Open sheet
    print("Fetching score");
    final sheet = await gsheets.spreadsheet(sheetsId);
    var workSheet = sheet.worksheetById(worksheetId);
    var result = await workSheet!.values.value(column: 5, row: 2);
    print(result);
    highScore = result;
    return result;
  }

  @override
  void initState() {
    super.initState();
    fetchScore();
    Timer.periodic(const Duration(milliseconds: 33), (timer) {
      //should be 33
      if (!isUpdating) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    isUpdating = true;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
    final width = MediaQuery.of(context).size.width;
    if (gameState == GameState.playing) {
      updatePipe();
      checkCollision();
    }
    updateBird();
    isUpdating = false;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) => handleTap(1),
          onTapUp: (TapUpDetails details) => handleTap(0),
          child: Center(
            child: Container(
              width: min(width, screenDimen['x']!),
              height: min(height, screenDimen['y']!),
              color: const Color.fromARGB(0, 228, 22, 22),
              child: Stack(
                children: [
                  //get new background
                  Positioned(top: 0, left: 0, child: drawBackgroundTop()),

                  //todo: get new pipes
                  if (true)
                    ...(pipes.mapIndexed((int index, Pipes item) => Positioned(
                          left: pipeLocation[index]['x']!,
                          top: 0,
                          child: item.drawPipe(context),
                        ))),
                  Positioned(
                      left: baseShiftX, bottom: 0, child: drawBackgroundBase()),
                  //todo: get new bird
                  Positioned(
                    left: flappyBirdState[flappyBirdX] as double,
                    top: flappyBirdState[flappyBirdY] as double,
                    child: FlappyBird(
                        birdColor:
                            flappyBirdState[flappyBirdColor]! as BirdColor,
                        flightStage: flappyBirdState[flappyBirdFlightStage]
                            as FlightStage,
                        rotationDeg: visibleRotation),
                  ),
                  //todo: if game over, show the game over banner
                  //get new score
                  if (gameState == GameState.playing)
                    Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: drawScores(),
                    ),
                  if (gameState == GameState.ended)
                    IgnorePointer(
                        ignoring: false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 64),
                          child: Center(
                            child: SizedBox(
                              height: 350,
                              width: 350,
                              child: Card(
                                // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // Set the clip behavior of the card
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                // Define the child widgets of the card
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 15, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Display the card's title using a font size of 24 and a dark grey color

                                          Text(
                                            "Your Score: " +
                                                playerScore.toString(),
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.purple[900],
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Add a space between the title and the text
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // Display the card's text using a font size of 15 and a light grey color
                                          Divider(
                                            color: Colors.purple[900],
                                          ),
                                          // Add a space between the title and the text
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          // High Score
                                          Text(
                                            "High Score: $highScore",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.purple[900],
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Add a row with two buttons spaced apart and aligned to the right side of the card
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
                                                                  color: Colors
                                                                          .purple[
                                                                      900],
                                                                  fontSize: 26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            content:
                                                                TextFormField(
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .purple[
                                                                    900],
                                                              ),
                                                              controller:
                                                                  mobile,
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
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                        null ||
                                                                    value
                                                                        .isEmpty) {
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
                                                                fillColor: Colors
                                                                    .purple[50],

                                                                alignLabelWithHint:
                                                                    true,
                                                                hintText:
                                                                    'Mobile Number',
                                                                prefixText:
                                                                    '+91 | ',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .purple[
                                                                      100],
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
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderSide: const BorderSide(
                                                                        color: Colors
                                                                            .deepPurple),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                // prefixText: '+91 | ',
                                                                prefixStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .purple[
                                                                      900],
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
                                                                            .all(
                                                                        8.0),
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
                                                                            await gsheets.spreadsheet(sheetsId);
                                                                        var workSheet =
                                                                            sheet.worksheetById(worksheetId);

                                                                        // Insert data into sheet
                                                                        insertData(
                                                                            int.parse(mobile.value.text),
                                                                            playerScore,
                                                                            workSheet!);
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          const SnackBar(
                                                                              content: Text('Data received successfully !')),
                                                                        );
                                                                      } catch (e) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(
                                                                          const SnackBar(
                                                                              content: Text('Unexpected error occured !')),
                                                                        );
                                                                      }

                                                                      Navigator.pop(
                                                                          context);
                                                                      resetGame();
                                                                    }, //This prop for beautiful expressions
                                                                    child: const Text(
                                                                        "Submit"), // This child can be everything. I want to choose a beautiful Text Widget
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      textStyle: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      minimumSize:
                                                                          const Size(
                                                                              200,
                                                                              100), //change size of this beautiful button
                                                                      // We can change style of this beautiful elevated button thanks to style prop
                                                                      // surface color
                                                                      shadowColor:
                                                                          Colors
                                                                              .grey, //shadow prop is a very nice prop for every button or card widgets.
                                                                      elevation:
                                                                          5,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .purple[900], // we can set elevation of this beautiful button
                                                                      side: const BorderSide(
                                                                          color: Color(0xff4a148c), //change border color
                                                                          width: 2, //change border width
                                                                          style: BorderStyle.solid), // change border side of this beautiful button
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30), //change border radius of this beautiful button thanks to BorderRadius.circular function
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
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                                                        Colors.purple[800],
                                                    side: const BorderSide(
                                                        color: Color(
                                                            0xff6a1b9a), //change border color
                                                        width:
                                                            2, //change border width
                                                        style: BorderStyle
                                                            .solid), // change border side of this beautiful button
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                  onPressed:
                                                      resetGame, //This prop for beautiful expressions
                                                  child: const Text(
                                                      "Try again"), // This child can be everything. I want to choose a beautiful Text Widget
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                                                    backgroundColor: Colors
                                                            .purple[
                                                        800], // we can set elevation of this beautiful button
                                                    side: const BorderSide(
                                                        color: Color(
                                                            0xff6a1b9a), //change border color
                                                        width:
                                                            2, //change border width
                                                        style: BorderStyle
                                                            .solid), // change border side of this beautiful button
                                                    shape:
                                                        RoundedRectangleBorder(
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

                  // if welcome show welcome banner
                  if (gameState == GameState.welcome)
                    Positioned(
                        right: width / 2 - welcomeMessageDimen['x']! / 2,
                        top: gameAreaHeight * .1,
                        child: drawWelcome()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleTap(int upDown) {
    switch (gameState) {
      case GameState.welcome:
        gameState = GameState.playing;
        break;
      case GameState.playing:
        if (upDown == 1) {
          flappyBirdState[flappyBirdIsJumping] = true;
          playWing();
        }
        break;
      case GameState.ended:
        // showModalBottomSheet(
        //   context: context,
        //   builder:
        // );
        // resetGame();
        return;
      // break;
      case GameState.ending:
        break;
    }
  }

  Widget drawWelcome() {
    return Image.asset(
      "assets/images/message blank.png",
      width: welcomeMessageDimen['x']!,
      height: welcomeMessageDimen['y']!,
      fit: BoxFit.cover,
    );
  }

  Widget drawScores() {
    if (pipeLocation.isNotEmpty &&
        (flappyBirdState[flappyBirdX] as double).inRange(
            pipeLocation[0]['x']! + pipeWidth,
            pipeLocation[0]['x']! + 4 + pipeWidth)) {
      playPoint();
      playerScore++;
    }

    final scoreToString = playerScore.toString();
    final digitImage = <Widget>[];
    for (String digit in scoreToString.split("")) {
      digitImage.add(Image.asset(scoreAssets[int.parse(digit)]));
      digitImage.add(const SizedBox(
        width: 4,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: digitImage,
    );
  }

  Widget drawBackgroundTop() => Image.asset(
        "assets/images/background-${backgroundState.name}.png",
        width: backgroundDimen['x']!,
        height: backgroundDimen['y'],
        fit: BoxFit.contain,
      );

  Widget drawBackgroundBase() {
    if (gameState == GameState.welcome || gameState == GameState.playing) {
      baseShiftX = -((-baseShiftX + 4) % baseXOffset);
    }
    return Image.asset(
      "assets/images/base.png",
      height: baseDimen['y'],
      width: baseDimen['x']! + baseXOffset,
      fit: BoxFit.cover,
      // repeat: ImageRepeat.repeatX,
    );
  }

  void updatePipe() {
    if (pipes.isEmpty || pipeLocation.last['x']! <= screenDimen['x']!) {
      pipes.add(Pipes(pipeColor));
      pipes.last.initDimen();
      pipeLocation.add({'x': screenDimen['x']! + pipeGapHorizontal, 'y': 0.0});
    }
    for (var location in pipeLocation) {
      location['x'] = location['x']! - 4;
    }
    pipeLocation.removeWhere(
        (Map<String, double> location) => location['x']! < -pipeWidth);
    pipes.removeRange(0, pipes.length - pipeLocation.length);
  }

  void updateBird() {
    if (gameState == GameState.welcome || gameState == GameState.playing) {
      wingPosIndex = wingPosIndex == 3 ? 0 : wingPosIndex + 1;
      flappyBirdState[flappyBirdFlightStage] =
          FlightStage.values[wingLocations[wingPosIndex]];
    }
    switch (gameState) {
      case GameState.welcome:
        if (abs((flappyBirdState[flappyBirdY] as double) -
                (flappyBirdStartingPos['y'] as double)) ==
            10.0) {
          flappyBirdState[flappyBirdDir] =
              (flappyBirdState[flappyBirdDir] as int) * -1;
        }
        if (flappyBirdState[flappyBirdDir] == -1) {
          flappyBirdState[flappyBirdY] =
              (flappyBirdState[flappyBirdY] as double) - 1;
        }
        if (flappyBirdState[flappyBirdDir] == 1) {
          flappyBirdState[flappyBirdY] =
              (flappyBirdState[flappyBirdY] as double) + 1;
        }
        break;
      case GameState.playing: //update the rotation angle
        //check if the player flapped
        if (flappyBirdState[flappyBirdIsJumping] as bool) {
          flappyBirdState[flappyBirdRotationDeg] = -45.0;
          playerVelY = playerFlapAcc;
          flappyBirdState[flappyBirdIsJumping] = true;
        }
        //update rotation
        flappyBirdState[flappyBirdRotationDeg] =
            (flappyBirdState[flappyBirdRotationDeg] as double) + playerVelRot;
        if ((flappyBirdState[flappyBirdRotationDeg] as double) >= 90) {
          flappyBirdState[flappyBirdRotationDeg] = 90.0;
        }
        visibleRotation = playerRotThr.toDouble();
        if ((flappyBirdState[flappyBirdRotationDeg] as double) >=
            playerRotThr) {
          visibleRotation = flappyBirdState[flappyBirdRotationDeg] as double;
        }
        flappyBirdState[flappyBirdRotationDeg] =
            (flappyBirdState[flappyBirdRotationDeg] as double) + playerVelRot;
        //update the height
        if (playerVelY < playerMaxVelY &&
            !(flappyBirdState[flappyBirdIsJumping] as bool)) {
          playerVelY += playerAccY;
        }
        if ((flappyBirdState[flappyBirdIsJumping] as bool)) {
          flappyBirdState[flappyBirdIsJumping] = false;
        }
        flappyBirdState[flappyBirdY] = min(
            gameAreaHeight - flappyBirdDimen['y']!,
            (flappyBirdState[flappyBirdY] as double) + playerVelY.toDouble());

        break;
      case GameState.ending:
        //update rotation
        flappyBirdState[flappyBirdRotationDeg] =
            (flappyBirdState[flappyBirdRotationDeg] as double) + playerVelRot;
        if ((flappyBirdState[flappyBirdRotationDeg] as double) >= 90) {
          flappyBirdState[flappyBirdRotationDeg] = 90.0;
        }
        visibleRotation = playerRotThr.toDouble();
        if ((flappyBirdState[flappyBirdRotationDeg] as double) >=
            playerRotThr) {
          visibleRotation = flappyBirdState[flappyBirdRotationDeg] as double;
        }
        flappyBirdState[flappyBirdRotationDeg] =
            (flappyBirdState[flappyBirdRotationDeg] as double) +
                playerVelRot +
                1.8; //rotate faster when falling
        //update height
        if ((flappyBirdState[flappyBirdIsFalling] as bool) &&
            (flappyBirdState[flappyBirdY] as double) + 15 <=
                gameAreaHeight - flappyBirdDimen['y']!) {
          flappyBirdState[flappyBirdY] =
              (flappyBirdState[flappyBirdY] as double) +
                  20; //play ending animation
        } else {
          gameState = GameState.ended;
        }
        break;
      case GameState.ended:
        break;
    }
  }

  void checkCollision() async {
    if (gameState == GameState.playing) {
      // get the bird bounds
      final flappyBirdTop = flappyBirdState[flappyBirdY] as double;
      final flappyBirdLeft = flappyBirdState[flappyBirdX] as double;
      final flappyBirdRight = flappyBirdLeft + (flappyBirdDimen['x'] as double);
      final flappyBirdBottom = flappyBirdTop + (flappyBirdDimen['y'] as double);
      var isColliding = false;
      //check floor collision
      if (flappyBirdBottom >= gameAreaHeight) {
        // print("$flappyBirdBottom ${baseDimen['y']!}");
        print('floor');
        flappyBirdState[flappyBirdIsFalling] = false;
        isColliding = true;
      }
      for (int i = 0; i < pipes.length && !isColliding; i++) {
        //break the loop if colliding
        final upperPipeY = pipes[i].topHeight;
        final lowerPipeY = gameAreaHeight - pipes[i].bottomHeight;
        final pipesX = pipeLocation[i]['x'] as double;
        //check right collision
        if (flappyBirdRight.inRange(pipesX, pipesX + 4) &&
            (flappyBirdBottom.inRange(
                    lowerPipeY, gameAreaHeight + flappyBirdDimen['y']!) ||
                flappyBirdTop <= upperPipeY)) {
          flappyBirdState[flappyBirdIsFalling] = true;
          isColliding = true;
          break;
        }
        //check pipe collision
        if (flappyBirdRight.inRange(
            pipesX, pipesX + pipeWidth + flappyBirdDimen['x']!)) {
          //check top collision
          if (flappyBirdTop <= upperPipeY) {
            flappyBirdState[flappyBirdIsFalling] = false;
            isColliding = true;
            break;
          }
          //check bottom collision
          if (flappyBirdBottom >= lowerPipeY) {
            flappyBirdState[flappyBirdIsFalling] = false;
            isColliding = true;
            break;
          }
        }
      }

      if (isColliding) {
        gameState = GameState.ending;
        await playHit();
        if (flappyBirdState[flappyBirdIsFalling] as bool) playDie();
      }
    }
  }

  void resetGame() {
    gameState = GameState.playing;
    backgroundState = BackgroundState.values[Random().nextInt(2)];
    pipeColor = PipeColor.values[Random().nextInt(2)];
    isUpdating = false;
    baseShiftX = 0.0;

    visibleRotation = 0;
    playerScore = 0;
    pipes.clear();
    pipeLocation.clear();
    wingPosIndex = 1;
    flappyBirdState = {
      flappyBirdX: flappyBirdStartingPos['x']!,
      flappyBirdY: flappyBirdStartingPos['y']!,
      flappyBirdRotationDeg: 0.0,
      flappyBirdColor: BirdColor.values[Random().nextInt(3)],
      flappyBirdFlightStage: FlightStage.mid,
      flappyBirdIsJumping: false,
      flappyBirdDir: 1,
      heightToJump: 0,
    };
    // player velocity, max velocity, downward acceleration, acceleration on flap
    playerVelY = -9; // player's velocity along Y, default same as playerFlapped
  }
}
