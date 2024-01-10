// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malhar_2023/data/data.dart';
import 'package:malhar_2023/flappy.dart';
import 'package:malhar_2023/login_page.dart';
import 'package:malhar_2023/pages/calender.dart';

import 'models/date_model.dart';
import 'models/event_type_model.dart';
import 'models/events_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DateModel> dates = [];
  List<EventTypeModel> eventsType = [];
  List<EventsModel> events = [];

  String todayDateIs = "12";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = getDates();
    eventsType = getEventTypes();
    events = getEvents();
  }

  final DateTime eventDate = DateTime(2023, 8, 13);
  bool showCustomContent = false;
  int selectedDateIndex = -1; // Default to no date selected

  List<DateTime> specificEventDates = [
    DateTime(2023, 7, 30),
    DateTime(2023, 8, 7),
    DateTime(2023, 8, 8),
  ];

  bool isCustomDate(DateTime date) {
    return specificEventDates.contains(date);
  }

//Sectiion 3
  Widget _buildSection3Content() {
    // Replace these lists with your actual data
    List<String> dates = ["30 July", "7 August", "10 August"];
    List<String> descriptions = [
      "Event description for 30 July",
      "Event description for 7 August",
      "Event description for 10 August",
    ];
    List<String> eventNames = ["Event A", "Event B", "Event C"];

    // Get the current date
    DateTime currentDate = DateTime.now();
    String currentDateString =
        "${currentDate.day} ${_getMonth(currentDate.month)}";
    bool hasEventToday = dates.contains(currentDateString);
    int index = dates.indexOf(currentDateString);
    String eventName = hasEventToday ? eventNames[index] : "Event Coming Soon";
    String eventDescription =
        hasEventToday ? descriptions[index] : "Stay Connected";

    return Card(
      elevation: 6,
      shadowColor: const Color.fromARGB(252, 159, 158, 158),
      color: const Color.fromARGB(255, 161, 110, 184),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with the dynamic heading and changing background color
          Container(
            color: hasEventToday
                ? const Color.fromARGB(255, 119, 73, 122)
                : Color.fromARGB(255, 59, 46, 76),
            padding: const EdgeInsets.all(12.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Event",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Container for the current date event or "Event Coming Soon" message
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasEventToday ? dates[index] : currentDateString,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasEventToday
                            ? _getDayOfWeek(currentDate.weekday)
                            : _getDayOfWeek(DateTime(currentDate.year,
                                    currentDate.month, currentDate.day + 1)
                                .weekday), // Get the day of the week for the next day
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        eventDescription,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    List<String> months = [
      "", // Empty string added for index 0
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month];
  }

  String _getDayOfWeek(int day) {
    List<String> daysOfWeek = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ];
    return daysOfWeek[day - 1];
  }

  //section 4

  Widget _buildSection4Content() {
    return Card(
      elevation: 6,
      shadowColor: const Color.fromARGB(252, 159, 158, 158),
      color: const Color.fromARGB(255, 32, 4, 50),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Games",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 180, // Adjust the height as needed
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: _buildGameCard(
                          Colors.deepPurpleAccent,
                          'assets/game1.png',
                          // "Action Game",

                          _onActionGameTap)),
                  Expanded(
                      child: _buildGameCard(
                          Colors.deepPurpleAccent,
                          'assets/game2.jpeg',

                          // "Explore the unknown.",
                          _onAdventureGameTap)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
      Color color, String imagePath, VoidCallback onTapFunction) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Card(
        elevation: 6, shadowColor: const Color.fromARGB(252, 159, 158, 158),
        color: Color.fromARGB(255, 183, 181, 249),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _onActionGameTap,
                child: Image.asset(
                  imagePath,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: onTapFunction,
            //   child: const Text("Tap to Play"),
            //   style: ElevatedButton.styleFrom(
            //     primary: Color.fromARGB(255, 43, 1, 46),
            //     // shape: const RoundedRectangleBorder(
            //     //   borderRadius:
            //     //       BorderRadius.vertical(bottom: Radius.circular(12.0)),
            //     // ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _onActionGameTap() {
    //   Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ActionGamePage()),
    // );
    Get.to(FlappyWindow());

    print("Action Game Tapped");
  }

  void _onAdventureGameTap() {
    //   Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ActionGamePage()),
    // );
    print("Adventure Game Tapped");
  }
  //Section 5

  Widget _buildSection5Content() {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height *
              0.25, // Adjust the height as needed
          child: GestureDetector(
            onTap: () {
              // Add your navigation or any other logic here
              // For example, navigate to a new page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewPage(),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhPyiLORK5xln2axERbqwFlYJW40O0Cvji9BXUPD9VAxX0uyf4RoRtlycVK9874jCBPZk&usqp=CAU', // Replace 'assets/image.png' with your image path
                fit:
                    BoxFit.fitWidth, // Fit the image width within the container
              ),
            ),
          ),
        ),
      ),
    );
  }

  //SECTION 6
  Widget _buildSection6Content() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 16, 7, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 15, 2, 23),
              ),
              onPressed: () {
                // Show a modal bottom sheet saying "Will be out soon" and some related content
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Will be out soon",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Something related to the event",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: const Text(
                  "Get Your Passes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //SEction 1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBodyBehindAppBar: false,
      /*appBar: AppBar(
        backgroundColor : Colors.transparent,
        centerTitle: true,
      ),*/
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 35, 1, 52),              
              Color.fromARGB(255, 91, 2, 136),
              //Color.fromARGB(255, 91, 2, 136),              
              Color.fromARGB(255, 105, 3, 156),
            ],
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  // Section 2: Text with IconButton
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30.0,),
                                    Text(
                                      'Hello User',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      'Lets explore it!',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.to(const CalendarScreen());
                                },
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Section 1: Timer till 13 August 2023
                  Card(
                    elevation: 6,
                    shadowColor: const Color.fromARGB(252, 159, 158, 158),
                    color: const Color.fromARGB(255, 123, 32, 163),
                    child: Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Meet you in',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_alarm_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                    width:
                                        8), // Add space between the icon and countdown
                                CountdownTimer(
                                  targetDate: eventDate,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildSection3Content(),

                  const SizedBox(
                    height: 5,
                  ),
                  // Section 4 - Games
                  _buildSection4Content(),

                  const SizedBox(
                    height: 5,
                  ),
                  // Section 5 - Upcoming Event Cards
                  _buildSection5Content(),

                  // Section 6 - Coming Soon Button
                  _buildSection6Content(),

                  //event section
                ],
              ),
            ),
          )),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;

  const CountdownTimer({required this.targetDate});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _timeRemaining;

  @override
  void initState() {
    super.initState();
    _updateTimeRemaining();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (_) => _updateTimeRemaining());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimeRemaining() {
    final now = DateTime.now();
    final diff = widget.targetDate.difference(now);
    setState(() {
      _timeRemaining = diff;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_timeRemaining.inDays}d, ${_timeRemaining.inHours.remainder(24)}h, '
      '${_timeRemaining.inMinutes.remainder(60)}m, ${_timeRemaining.inSeconds.remainder(60)}s',
      style: const TextStyle(fontSize: 17, color: Colors.white),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: const Center(
        child: Text('This is page is coming soon.'),
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  String weekDay;
  String date;
  bool isSelected;
  DateTile(
      {required this.weekDay, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: isSelected ? const Color(0xffFCCD00) : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            date,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            weekDay,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  Icon icon;
  String eventType;
  Widget page;
  EventTile({required this.icon, required this.eventType, required this.page});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(page);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 173, 107, 179),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            const SizedBox(
              height: 12,
            ),
            Text(
              eventType,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class PopularEventTile extends StatelessWidget {
  String desc;
  String date;
  String address;
  String imgeAssetPath;

  /// later can be changed with imgUrl
  PopularEventTile(
      {required this.address,
      required this.date,
      required this.imgeAssetPath,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 161, 78, 142),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    desc,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/calender.png",
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        date,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/location.png",
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        address,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: Image.asset(
                imgeAssetPath,
                height: 100,
                width: 120,
                fit: BoxFit.fill,
              )),
        ],
      ),
    );
  }
}
