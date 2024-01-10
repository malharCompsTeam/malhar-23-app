import 'package:animate_gradient/animate_gradient.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:malhar_2023/pages/events/events_dept_page.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class FaEventsPage extends StatefulWidget {
  const FaEventsPage({super.key});

  @override
  State<FaEventsPage> createState() => _FaEventsPage();
}

class _FaEventsPage extends State<FaEventsPage> {
  final List<Widget> styleCards = [
    for (int i = 1; i < 4; i++)
      FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: Card(
          elevation: 50,
          shadowColor: Colors.purple[50],
          color: Colors.purple[50],
          child: SizedBox(
            width: 300,
            height: 450,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //SizedBox

                  if (i == 1)
                    Text(
                      'The Artsy Relay',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  if (i == 2)
                    Text(
                      'Guess and Paint',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  if (i == 3)
                    Text(
                      'News Up!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                  if (i == 1)
                    Text(
                        "Teams of three participants showcase their collaborative skills by taking turns seated in the venue, with the topic revealed on the spot. They pour their creativity onto a canvas, repeating the cycle until all three participants create a unique collective masterpiece.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )),
                  if (i == 2)
                    Text(
                        "The event involves two rounds: Rapid Fire, where participants identify famous Vincent Van Gogh paintings with a buzzer, and Recreation, where they recreate the paintings with a surprise prompt before the painting round.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )),
                  //Text
                  if (i == 3)
                    Text(
                        " Create a unique mosaic collage on an A4 sheet using newspaper set, promoting environmental sustainability by using scissors, glue, and old newspapers for an eye-catching project.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )),

                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff200020).withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                          //more than 50% of width makes circle
                          ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Click here for more info",
                            style: GoogleFonts.ptSans(
                                color: Color(0xff200020),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ),
        back: Card(
          elevation: 50,
          shadowColor: Colors.purple[50],
          color: Colors.purple[50],
          child: SizedBox(
            width: 300,
            height: 450,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text("Open to: ",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text("Contingents and PRNCs",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                                if(i==2)
                      Text("Contingents and PRNCs and OTSE",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020))),
                              if(i==3)
                      Text("Contingents and PRNCs and OTSE",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020)))
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Type number:",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text("Group Event",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                                if (i == 2)
                      Text("Individual Event",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020))),
                              if (i == 3)
                      Text("Individual Event",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020)))
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Audience:",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      Text(" Not Allowed",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020)))
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Event Cap:",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text(" 20 Teams",
                            style: GoogleFonts.ptSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                      Text(" 20 Entries",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020))),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Max reg. per contingent: ",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      Text("1 entry",
                          style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020))),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff200020).withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                          //more than 50% of width makes circle
                          ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Tap to flip back",
                            style: GoogleFonts.ptSans(
                                color: Color(0xff200020),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ),
      ),
  ];
  PageController faController = PageController();
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
        disableGestures: false,
        drawerController: _advancedDrawerController,
        scaffold: Scaffold(
          // backgroundColor: Color(0xff311b92),
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(80.0),
          //   child: AppBar(
          //     elevation: 0,
          //     automaticallyImplyLeading: false,
          //     centerTitle: true,
          //     leading: IconButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => EventsPage()),
          //           );
          //         },
          //         icon: Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.white,
          //         )),
          //     backgroundColor: Color(0xff311b92),
          //     title: Text(
          //       "FA Events",
          //       style: GoogleFonts.ptSans(
          //                   color: Colors.white,
          //                     fontSize: 30,
          //                     fontWeight: FontWeight.bold
          //                 ),
          //     ),
          //   ),
          // ),
          body: AnimateGradient(
            primaryBegin: Alignment.topLeft,
            primaryEnd: Alignment.bottomLeft,
            secondaryBegin: Alignment.bottomLeft,
            secondaryEnd: Alignment.topRight,
            primaryColors: [
              const Color.fromARGB(255, 41, 1, 42),
              Color.fromARGB(255, 64, 4, 72),
              Color.fromARGB(255, 35, 26, 35),
            ],
            secondaryColors: [
              const Color.fromARGB(255, 41, 1, 42),
              Color.fromARGB(255, 64, 4, 72),
              Color.fromARGB(255, 141, 74, 143),
            ],
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EventsPage()),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            "assets/icons/events_dept_icons/fa.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Fine Arts",
                      style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 590,
                      child: StackedCardCarousel(
                        pageController: faController,
                        initialOffset: 40,
                        spaceBetweenItems: 460,
                        items: styleCards,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
