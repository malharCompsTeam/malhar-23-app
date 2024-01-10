import 'package:animate_gradient/animate_gradient.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:malhar_2023/pages/events/events_dept_page.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class CrossoverEventsPage extends StatefulWidget {
  const CrossoverEventsPage({super.key});

  @override
  State<CrossoverEventsPage> createState() => _CrossoverEventsPage();
}

class _CrossoverEventsPage extends State<CrossoverEventsPage> {
  final List<Widget> styleCards = [
    for (int i = 1; i < 3; i++)
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
                  if (i == 1)
                    Text(
                      'Dastaan-e-Filmy',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  if (i == 2)
                    Text(
                      'Mere Sapno ki Kahani',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: 24,
                        color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                  //Text

                  if (i == 1)
                    Text(
                        "In eliminations, participants select two Bollywood characters and create a storyline. Finals consists of a breathtaking theatrical wonder featuring dance, drama, and music, featuring 8 teams creating a unique cinematic world with unique character combinations and original storylines.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoCondensed(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )),
                  if (i == 2)
                    Text(
                        "The event features a captivating duet between dancers and narrators, focusing on the theme of 'Sapne', a dream-related theme. The narrator narrates the story, while the classical dancer portrays the theme through movement and instrumental music.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoCondensed(
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
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      Text("Contingents and PRNCs",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020)))
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Type number: ",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text("Group Event(6-8 members)",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                      if (i == 2)
                        Text("Duet Event(2 participants: 1 narrator, 1 dancer)",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020)))
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Audience:",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text(" Allowed for finals",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                      if (i == 2)
                        Text(" Allowed",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Event Cap:",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      if (i == 1)
                        Text(" 15 entries, Finals: 8 entries",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                      if (i == 2)
                        Text(" 10 entries",
                            style: GoogleFonts.robotoCondensed(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xff200020))),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("Max reg. per contingent:",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff200020))),
                      Text("1 entry",
                          style: GoogleFonts.robotoCondensed(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xff200020)))
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
                            style: GoogleFonts.robotoCondensed(
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

  PageController csController = PageController();
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
          //       "Crossover Events",
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
                            "assets/icons/events_dept_icons/crossover.png")),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Crossover",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 550,
                      child: StackedCardCarousel(
                        pageController: csController,
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
