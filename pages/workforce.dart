import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';

class Workforce extends StatefulWidget {
  const Workforce({super.key});

  @override
  State<Workforce> createState() => _WorkforceState();
}

class _WorkforceState extends State<Workforce> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 4, vsync: this);

    final _advancedDrawerController = AdvancedDrawerController();

    return DrawerWrapper(
      disableGestures: false,
      drawerController: _advancedDrawerController,
      scaffold: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
          title: Text("",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(255, 255, 255, 1),
              ))),
          backgroundColor: Color.fromRGBO(32, 24, 53, 1),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(32, 24, 53, 1),
                Color.fromRGBO(45, 34, 75, 1),
                Color.fromRGBO(61, 45, 100, 1),
                Color.fromRGBO(70, 53, 116, 1),
                Color.fromRGBO(95, 72, 156, 1),
                Color.fromRGBO(97, 71, 156, 1),
              ],
            )),
            child: SingleChildScrollView( 
            physics : const NeverScrollableScrollPhysics(),
            child : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //workforce title
                          Container(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Workforce",
                                style: GoogleFonts.poppins(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(244, 242, 252, 1),
                                )),
                          ),
                          const SizedBox(height: 30),

                          //tabbar
                          Center(
                              child: TabBar(
                                    isScrollable : true,
                                labelStyle: GoogleFonts.poppins(
                                    color: const Color.fromRGBO(248, 234, 159, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                labelPadding: const EdgeInsets.symmetric(horizontal: 9),
                                unselectedLabelStyle: GoogleFonts.poppins(
                                    color: Colors.white10,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                indicator: const DotIndicator(
                                    color: Color.fromRGBO(248, 231, 134, 1),
                                    radius: 3),
                                controller: tabcontroller,
                                tabs: const [
                                  Tab(text: "Quartet"),
                                  Tab(text: "Events"),
                                  Tab(text: "Management"),
                                  Tab(text: "Networking"),
                                  
                                  
                                ],
                              )),

                          const SizedBox(height: 15),

                          //tabbar view
                          Container(
                            width: double.maxFinite,
                            height: 1500,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(37.0),
                            ),
                            child: TabBarView(
                                controller: tabcontroller,
                                children: [
                                  //Quartet content
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset('assets/Quartet.jpg'),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                     
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'The Quartet \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'The Quartet of Malhar: Eye of the Storm are the visionary captains of the ship, who harmoniously navigate through the storm of Malhar. With their guidance, they strive to provide an exhilarating journey, inviting participants to embrace the whirlwind of chaos and discover the beauty within.',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                    ],
                                                  ),
                                                )
                                             
                                    )),
                        ]),

                                  //Events content
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              height: 800,
                                              autoPlay: true,
                                              viewportFraction: 1,
                                              enlargeCenterPage: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .height,
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              autoPlayCurve: Curves.easeInExpo,
                                              enlargeFactor: 0.2,
                                            ),
                                            items: [
                                              'assets/WINC.jpg',
                                              'assets/IPA.jpg',
                                              'assets/WPA.jpg',
                                              'assets/LA.jpg',
                                              'assets/FA.jpg',
                                              'assets/ETC.jpg',
                                              'assets/Admin.png'
                                            ].map((i) {
                                              return Builder(builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(i),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      //winc
                                                      if (i ==
                                                          'assets/WINC.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Workshops Inc. \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'Be it dance, culinary, or arts and crafts, Workshops Incorporated is the department that offers a space for everyone to learn something unique and have fun through its many workshops. The Yardsale is a wholesome social cause event that WINC also handles. Toh ab aankh maro, toofan machao ;)',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //ipa
                                                      if (i == 'assets/IPA.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Indian Performing Arts \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'The Indian Performing Arts department of Malhar 2023 aims to promote the beats of tabla, the mellifluous notes of the sitar, the rhythmic footwork of Kathak and the energetic beats of Bhangra. By fusing the traditional art forms with a little Bollywood tadka, our vision is to organize the grandest and the most entertaining events in Malhar! "Kyonki Malhar sirf teen cheezon ki wajah se chalta hain entertainment, entertainment, entertainment aur IPA entertainment hai."',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //wpa
                                                      if (i == 'assets/WPA.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'World Performing Arts \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'From the grace of contemporary to the swag of hip-hop, from the melodies of acapella to the beats of jazz, we have got it all covered! WPA is the platform that gives your passion wings!',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),

                                                      //la
                                                      if (i == 'assets/LA.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Literary Arts \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Literary Arts is a department that seems very niche, but in a lot of ways, is one of the most diverse. From Taal and Blog to Book Lounge and finally Events, it is the embodiment of creative expression. Each event allows you to explore and potentially put out a part of you that is undiscovered. So, if you’re not afraid to challenge yourself, this is the department to be:) This year’s vision for Literary Arts is the embodiment of the dialogue, “Picture abhi baaki hai mere dost”",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //fa
                                                      if (i == 'assets/FA.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Fine Arts \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'Fine Arts is a captivating voyage of shattered preconceptions, where we experiment and explore new avenues. From our resplendent events to the alluring Fine Arts Lounge, each conception we conceive is a veritable masterpiece of originality. The Fine Arts Department at Malhar is a vibrant hub of creativity and expression. With a diverse range of artistic disciplines, it fosters a nurturing environment for aspiring artists to explore their talents',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //etc
                                                      if (i == 'assets/ETC.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Entertainment, Theatrics & Contests \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'Entertainment, theatricals and contests is a department which includes a variety of events like Malhar icon, theater & Field domination etc etc.. If you are someone who is interested in event management and event curation, this department is the best place for you to have a versatile and most exclusive experience related to events. ETC in a nutshell is a madhouse and a playground where we come up with the most innovative and out of the box events, competitions and games!Our vision for Malhar 2023 is to create a platform for all our participants to run wild with their talents and skills, participate in events like never before and enjoy themselves to the fullest!',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //admin
                                                      if (i ==
                                                          'assets/Admin.png')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Admin \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            'Rightly dubbed the "Backbone of Malhar", We are the unsung heroes of the festival, without whom the festival would be nothing more than a pipe dream, working tirelessly behind the scenes to make sure everything runs smoothly.',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                    ],
                                                  ),
                                                );
                                              });
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Management
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              height: 800,
                                              autoPlay: true,
                                              viewportFraction: 1,
                                              enlargeCenterPage: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .height,
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              autoPlayCurve: Curves.easeInExpo,
                                              enlargeFactor: 0.2,
                                            ),
                                            items: [
                                              'assets/Security.jpg',
                                              'assets/Assistance.jpg',
                                              'assets/logs.jpg',
                                              'assets/Texxx.jpg',
                                              'assets/Finance.jpg',
                                              'assets/Marketing.jpg',
                                              'assets/Hospitality.jpg'
                                            ].map((i) {
                                              return Builder(builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(i),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      //security
                                                      if (i ==
                                                          'assets/Security.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Security \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Security ensures the safety and control of the crowd on the days of Malhar. It is part of the big four and is the largest department in terms of workforce strength. The department has jobs like acquiring licenses, crowd control, audience safety, frisking, confiscating banned items, Judge parking, Judge routes and safety, entry, exit and evacuation",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //assistance
                                                      if (i ==
                                                          'assets/Assistance.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Assistance \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Assistance is a department under the Management domain and mainly deals with crowd management and venue management and are incharge of all venues where events take place.\nNeed to know the routes around college? Need the first aid kit? I hope not but need an ambulance? Need help with anything at all? \nWe are the solution to all your problems!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Logistics
                                                      if (i ==
                                                          'assets/logs.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Logistics \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "At Malhar, we have a dynamic logistics team dedicated to creating extraordinary event experiences. Our talented team works tirelessly to ensure every venue is transformed into a captivating setting that brings the events to life. Each of our three auxiliary departments- CND, Events & Classrooms contribute to the magic in their own way. Together, these three departments ensure that no detail is overlooked, be it moving bulky items, setting up captivating backgrounds, or transforming venues into magical spaces. Our logistics team takes immense pride in their work, ensuring that every event shines brilliantly and leaves the attendees with unforgettable memories",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),

                                                      //Technicals
                                                      if (i ==
                                                          'assets/Texxx.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Technicals \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Bright lights, loud speakers and extravagant settings. Our unrivaled talent for blowing fuses and making speakers screech will leave you in awe. From illuminating the venue to blasting the music, Texxx does it all.",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Finance
                                                      if (i ==
                                                          'assets/Finance.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Finance \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Finance is the bridge between the vision and the execution of Malhar. As a department which deals with money, we believe that trust and loyalty is most integral to our team as confidentiality is our second nature. From budgeting to reimbursement,  not a day goes by when finance is not pulling up an ace up to its sleeves. Finance is everywhere and when it's about the job, no matter how tough it is, we leave no stone unturned!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Marketing
                                                      if (i ==
                                                          'assets/Marketing.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Marketing \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Marketing is responsible for helping raise funds that are essential to keep the festival running and for all the tie ups that Malhar undertakes. Ask us how you can get involved!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Hospitality
                                                      if (i ==
                                                          'assets/Hospitality.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Hospitality \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Hospitality is a department that ensures the comfort of everyone associated with Malhar right from the workforce to the guests. Whether it's food hunting, card designing or meal packing, we do it all. Finally we also encapsulate your best Malhar memories through Cardolates.",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                    ],
                                                  ),
                                                );
                                              });
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Networking
                                  Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              height: 800,
                                              autoPlay: true,
                                              viewportFraction: 1,
                                              enlargeCenterPage: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .height,
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                              autoPlayCurve: Curves.easeInExpo,
                                              enlargeFactor: 0.2,
                                            ),
                                            items: [
                                              'assets/Comps.jpg',
                                              'assets/Conclave.jpg',
                                              'assets/Creatives.jpg',
                                              'assets/PR.jpg',
                                              'assets/DnM.jpg',
                                              'assets/FnD.jpg',
                                            ].map((i) {
                                              return Builder(builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(i),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      //Computers
                                                      if (i ==
                                                          'assets/Comps.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Computers \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Computers as a department chooses to reside on Discord. In addition to the painful tracking down of bugs and fixing them, you'll probably find one member of the department or another awake at any time of the day. Finding snippets of code through infinite hours of scrolling, clear out something thats "
                                                                            "bugging "
                                                                            "you, or helping the other OGs with all the problems in their computers. All these fall right under their domain.",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Conclave
                                                      if (i ==
                                                          'assets/Conclave.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Conclave \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Conclave is like the cherry on the cake of Malhar. It is a youth platform full of glamour and intellect where eminent personalities and dignitaries share their expertise. Right from the President of India to your favourite Bollywood star, you can meet everyone at Conclave!",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Creatives
                                                      if (i ==
                                                          'assets/Creatives.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Creatives \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Creatives sets the brand identity from Malhar. Everything from the logo and social media posts to digitally designed merch and banners falls under Creatives' umbrella !",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),

                                                      //Public Relations
                                                      if (i == 'assets/PR.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Public Relations \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "The Public Relations (PR) department for Malhar'23 is responsible for managing and enhancing the overall image, reputation and social media communication of the events.",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //Decor & Merchandise
                                                      if (i == 'assets/DnM.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Decor & Merchandise \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Decor and Merchandise (DnM) specializes in transforming the college space into a captivating environment through creative backdrops and installations as well as by offering an array of appealing merchandise and paintings. At DnM, we ensure that our work is not only visually stunning but also creates lasting memories. We believe that by combining artistic excellence with an enjoyable and collaborative atmosphere, we can provide students with an unforgettable fest experience, where art and personal expression intertwine to form a vibrant tapestry of memories.",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                      //FnD
                                                      if (i == 'assets/FnD.jpg')
                                                        Center(
                                                            child: RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                        text:
                                                                            'Filming & Documentation \n',
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color: const Color.fromRGBO(
                                                                              248,
                                                                              231,
                                                                              134,
                                                                              1), //Color.fromRGBO(244, 242, 252, 1),
                                                                        )),
                                                                    TextSpan(
                                                                        text:
                                                                            "Filming and Documentation is a department which captures anticipation and enthusiasm on all the days leading upto the fest, and at the end, becomes a way to recollect and remember all the significant moments lived. ",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color: const Color.fromRGBO(
                                                                              244,
                                                                              242,
                                                                              252,
                                                                              1),
                                                                        )),
                                                                  ],
                                                                ))),
                                                    ],
                                                  ),
                                                );
                                              });
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        ])))),
      ),
    );
  }
}

class DotIndicator extends Decoration {
  const DotIndicator({
    this.color = Colors.white,
    this.radius = 4.0,
  });

  final Color color;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(
      color: color,
      radius: radius,
      onChange: onChanged,
    );
  }
}

class _DotPainter extends BoxPainter {
  _DotPainter({
    required this.color,
    required this.radius,
    VoidCallback? onChange,
  })  : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        super(onChange);

  final Paint _paint;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    canvas.drawCircle(
      Offset(rect.bottomCenter.dx, rect.bottomCenter.dy - radius),
      radius,
      _paint,
    );
  }
}
