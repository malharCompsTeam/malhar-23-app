import 'package:animate_gradient/animate_gradient.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:malhar_2023/pages/events/events_dept_page.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class EtcEventsPage extends StatefulWidget {
  const EtcEventsPage({super.key});

  @override
  State<EtcEventsPage> createState() => _EtcEventsPage();
}

class _EtcEventsPage extends State<EtcEventsPage> {
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
                  
                  //  for (int j = 1; j < 3;j++)
                  if (i == 1)
                    Text(
                      'Malhar\'s Got Talent',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                      
                          fontSize: 24,
                         color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  if (i == 2)
                    Text(
                      'Ball is in Your Court Now!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                      
                          fontSize: 24,
                         color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  if (i == 3)
                    Text(
                      'Midnight Murder: Crime Conspiracy and Improv',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                      
                          fontSize: 24,
                         color: Color(0xff200020),
                        fontWeight: FontWeight.w900,
                      ),
                    ),

               
                  if (i == 1)
                    Text(
                      "Eliminations feature participants pitching themselves as they showcase their unique talent(s). In finals, the event features a combination of talent, design, and general knowledge in two rounds. In the first round, two participants showcase their skills by wearing designed clothes and showcasing their upcycling journey in a 1-minute video. In the second round, the smartest and fastest team will score big points. ",
                      textAlign: TextAlign.center,
                      style:GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )
                    ),
                  if (i == 2)
                    Text(
                      "Eliminations involve Basketbowling, a basketball-inspired variation, involves knocking down cardboard boxes using a basketball instead of a traditional pin. Finals involves lowball, a game where teams work together to prevent opposing teams from returning the ball, with each bounce losing points. The first team to reach the goal wins.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )
                    ),
                  //Text
                  if (i == 3)
                    Text(
                      "Experience an epic Improv Comedy Competition featuring rapid-fire humor, improvisation, and comedic brilliance in a Murder Mystery theme. The event features four rounds on \"murder mystery,\" requiring participants to create improvisational sketches.",
                      textAlign: TextAlign.center,
                      style:GoogleFonts.ptSans(
                          color: Color(0xff200020),
                          fontSize: 16,
                        )
                    ),
                 //SizedBox
                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff200020).withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                          //more than 50% of width makes circle
                          ),
                      child:  Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Click here for more info",
                            style:  GoogleFonts.ptSans(
                           color: Color(0xff200020),
                         
                          fontWeight: FontWeight.bold
                        ),
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
                      Text(
                        "Open to: ",
                        style:GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
              
                      Text(
                        "Contingents and PRNC",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                    
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        "Type number:",
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==1)
                      Text(
                        "Group Event(4 participants per team)",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                if(i==2)
                      Text(
                        "Group Event(4 participants per team)",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==3)
                      Text(
                        "Individual Event",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      )
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(
                        "Audience:",
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==1)
                      Text(
                        " Allowed for finals",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==2)
                      Text(
                        " Allowed for both eliminations and finals",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==3)
                      Text(
                        " Allowed",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      )
                    ],
                  ),
                   Wrap(
                    children: [
                      Text(
                        "Event Cap:",
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==1)
                      Text(
                        " 25 Entries",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                    if(i==2)
                      Text(
                        " 25 Teams",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      if(i==3)
                      Text(
                        " 12 entries",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                    ],
                  ),

                   Wrap(
                    children: [
                      Text(
                        "Max reg. per contingent: ",
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                      
                      Text(
                        "1 entry",
                        style:
                            GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff200020)
                        )
                      ),
                    
                     
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
                      child:  Center(
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

  PageController etcController = PageController();
final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
      disableGestures: false,
      drawerController: _advancedDrawerController,
      scaffold: 
    Scaffold(
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
      //       "ETC Events",
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
          child:  Center(
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
                        onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventsPage()),
            );},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/icons/events_dept_icons/etc.png")),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Entertainment, Theatricals and Contests",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 550,
                    child: StackedCardCarousel(
                      pageController: etcController,
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
