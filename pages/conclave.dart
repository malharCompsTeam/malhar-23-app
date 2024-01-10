import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:google_fonts/google_fonts.dart';

import 'dart:math' as math;
import 'dart:async';

import 'package:malhar_2023/components/drawer_wrapper.dart';

class Conclave extends StatefulWidget {
  const Conclave({super.key});

  @override
  State<Conclave> createState() => _ConclaveState();
}

class _ConclaveState extends State<Conclave> with TickerProviderStateMixin {
  var counter = 0;

  List<Color> get getColorsList => [
        const Color.fromARGB(255, 47, 29, 49),
        //Color.fromARGB(255, 77, 2, 90),
        //Color.fromARGB(255, 119, 3, 139),
        //Color.fromARGB(255, 7, 0, 8),
        const Color.fromARGB(150, 56, 26, 59),
        const Color.fromARGB(151, 69, 1, 78),
        //Color.fromARGB(255, 248, 238, 219),
      ]..shuffle();

  List<Alignment> get getAlignments => [
        Alignment.bottomLeft,
        Alignment.bottomRight,
        Alignment.topRight,
        Alignment.topLeft,
      ];

  _startBgColorAnimationTimer() {
    ///Animating for the first time.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      counter++;
      setState(() {});
    });

    const interval = Duration(seconds: 4);
    Timer.periodic(
      interval,
      (Timer timer) {
        counter++;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startBgColorAnimationTimer();
  }

  var data = [
    {
      "name": "Rohit Saraf",
      "title": "Lights, Camera, Action !",
      "img": "assets/Rohit Saraf.jpg",
      "desc":
          " Hailing from Delhi Rohit Saraf has quickly risen to prominence in Indian cinema with his captivating performances. You may recognize him from his breakthrough role in “Dear Zindagi,” and has continued to mesmerise audiences through films like “ The Sky Is Pink” and “Ludo”. Moreover, Rohit's talent extends to the digital realm, with hit web series like “Mismatched” and “Feels Like Ishq”. Along with being The Gift Studio presents Mould-Breaker-Male award winner, he is truly a charismatic and talented actor. ",
    },
    {
      "name": "Abhinandan Sekhri ",
      "title": " Behind the Headlines",
      "img": "assets/Abhinandan Sekhri.PNG",
      "desc":
          "Abhinandan Sekhri is the co-founder and CEO of Newslaundry and has also co-founded the production house Small Screen with Prashant Sareen. He has worked as a producer, director and writer, shows ‘Highway on my Plate’, ‘Gustaakhi Maaf’ and ‘The Great Indian Tamasha’. His perspective on theimportance of independent media in fostering a liberated society aligns well with the theme of Malhar Conclave 2023 which is ‘Libre’."
    },
    {
      "name": "Sachin Kalbag",
      "title": " Behind the Headlines",
      "img": "assets/Sachin Kalbag.jpg",
      "desc":
          "Sachin Kalbag is a veteran newspaper editor and radio broadcaster with nearly 30 years of experience in some of India's biggest, most influential newsrooms such as Hindustan Times, The Hindu. Sachin sir is currently a public policy practitioner at Takshashila Institution where he works as a Senior Research Fellow, specialising in media and governance. He co-hosts two podcasts on Spotify and Amazon Music -WhatsApp University, which busts fake news, and All Things Policy. An avid quizzer, he has appeared on BBC Mastermind, considered one of the world's toughest quizzes. "
    },
    {
      "name": "Orange Juice Gang ",
      "title": "Squeezing Success : One Joke at a Time",
      "img": "assets/Orange Juice Gang.PNG",
      "desc":
          "The OJ Gang is short for The Orange Juice Gang, and is a popular group of digital creators, namely, Saurabh Ghadge, Karan Sonawane, Neel Salekar, Sidhant Sarfare, Shravan Kshirsagar, Santosh Mishra and Shubham Jadhav who have successfully made their mark in the world of content in the past several months. They have achieved major milestones in such a short time and have received appreciation from celebrities like Vicky Kaushal. They have won the ‘Super Creator Squad of the Year’ Award at Creators United Awards, 2023. Their hilarious sketches have awed the audience and this adds to their credibility of truly being one of the most incredible creator squads online."
    },
    {
      "name": "Prajakta Koli  ",
      "title": "From Dumdums to Tudum",
      "img": "assets/Prajakta Koli.PNG",
      "desc":
          "Prajakta Koli, famously known as MostlySane by her beloved fans who she calls ‘DumDums’ is an Indian YouTuber and actress who makes videos which started with comedy but has now evolved across spectrums. Her lead role in the Netflix- Hit show Mismatched, along with Bollywood blockbuster Jugjugg Jeeyo and now Neeyat has truly highlighted her versatile personality. She has won prestigious awards including the Daytime Emmy Award and Filmfare award for Best Female Debut. "
    },
    {
      "name": "Kirti Kulhari",
      "title": "Shattering Glass Ceilings: Redefining Female Roles in OTT ",
      "img": "assets/Kirti Kulhari.jpg",
      "desc":
          "Kirti Kulhari is an Indian actor and model who predominantly works in Hindi-language films. She worked in successful and critically acclaimed films like Pink, Uri: The Surgical Strike, and Mission Mangal. The Filmfare award winner, Kirti Kulhari has emerged as one of the leading names on OTT platforms with back-to-back successes like Criminal Justice (Season 2) and Human."
    },
    {
      "name": "Dr. Prateek Makwana ",
      "title": "The Health & Wellness Equation ",
      "img": "assets/Dr Prateek Makwana.PNG",
      "desc":
          "Dr. Prateek Makwana is a visionary Consultant Embryologist dedicated to revolutionising the field of reproductive health. As a renowned TedX speaker, Dr. Makwana captivates audiences worldwide, igniting conversations and inspiring positive change with this along with an engaging Instagram content. With his expertise and innovative approach, he is reshaping the landscape of reproductive medicine, offering hope and support to those seeking fertility solutions. "
    },
    {
      "name": "Dr. Harinder Sekhon ",
      "title": "Stride of 'The Tiger': Navigating a Multipolar World",
      "img": "assets/Dr Harinder Sekhon.PNG",
      "desc":
          "Dr. Harinder Sekhon, a former Senior Fellow at the Vivekananda International Foundation, has research experience in various aspects of Indo-US relations and US policy and strategy in Asia. She was a Senior Fellow and Head, Intelligence and Strategic Analyst with the National Security Council Secretariat, Government of India. "
    },
    {
      "name": "Manjeet Kripalani  ",
      "title": "Stride of 'The Tiger': Navigating a Multipolar World",
      "img": "assets/Manjeet Kripalani.jpg",
      "desc":
          "Kripalani was India Bureau chief of Businessweek magazine from 1996 to 2009. During her extensive career in journalism (Businessweek, and Forbes magazines), she has won several awards (including the Gerald Loeb Award). Kripalani, is the executive director of Gateway House and her political career spans being the deputy press secretary to Steve Forbes to being press secretary for the Lok Sabha campaign for independent candidate Meera Sanyal. "
    },
    {
      "name": "Vice Admiral Girish Luthra ",
      "title": "Stride of 'The Tiger': Navigating a Multipolar World",
      "img": "assets/Vice Admiral Girish Luthra.jpg",
      "desc":
          "Vice Admiral Girish Luthra, is a retired Indian Navy veteran who served as Flag Officer Commanding-in-Chief, Western Naval Command. A Navigation and Direction specialist, has steered preparation of key official documents like Indian Maritime Doctrine. He is currently also a Distinguished Fellow at Observer Research Foundation (ORF), Mumbai. He is a recipient of the Vishisht Seva Medal, Ati Vishisht Seva Medal, and Param Vishisht Seva Medal from the President of India. "
    },
    {
      "name": "Nitin Gokhale ",
      "title": "Stride of 'The Tiger': Navigating a Multipolar World",
      "img": "assets/Nitin Gokhale.jpg",
      "desc":
          "Author, thought leader and one of South Asia's leading strategic analysts, Nitin A. Gokhale has forty years of rich and varied experience behind him as a conflict reporter, Editor, author and now a media entrepreneur who owns and curates three important digital platforms - BharatShakti.in, StratNewsGlobal.com and Interstellar.news. He was on the ground at Kargil in the summer of 1999 during the India-Pakistan war. He is also the author of over a dozen books on wars, insurgencies and conflicts."
    },
    {
      "name": "Dr. Amit Julka (moderator)",
      "title": "Stride of 'The Tiger': Navigating a Multipolar World",
      "img": "assets/Dr Amit Julka.PNG",
      "desc":
          "He is an Assistant Professor at the Department of International Relations, Ashoka University, India and has completed his PhD from the Department of Political Science, National University of Singapore. His research lies at the intersection of International Relations, popular culture, and South Asian politics."
    },
    {
      "name": "Dr. Anil Kakodkar ",
      "title": "Keynote Addresses",
      "img": "assets/Dr Anil Kakodkar.PNG",
      "desc":
          "Dr. Anil Kakodkar was amongst the chosen few involved in the first successful Peaceful Nuclear Explosion Experiment also known as the Smiling Buddha project which was conducted at Pokhran. His contribution in the nuclear projects has given India new power and given us the confidence to take a leap. He was awarded the Padma Vibhushan, India’s second-highest civilian honour, in 2009 and the Padma Bhushan in 1999. He was involved in rehabilitation of Madras Atomic Power Station, India also demonstrated nuclear submarine powerpack technology under Kakodkar’s expert leadership."
    },
    {
      "name": "Shaheen Mistry ",
      "title": "Social Cause Session",
      "img": "assets/Shaheen Mistri.jpg",
      "desc":
          "Social worker and Xavier’s Alumnus, Shaheen Mistry is an advocate for student voice and partnership and has conceptualised ‘Firki’, a Teacher Training Portal reaching to 142,000 users. Shaheen also serves on the boards of The Akanksha Foundation and the Advisory Board of Museum of Solutions and has been an Ashoka Fellow, a Global Leader for Tomorrow at the World Economic Forum, and an Asia Society 21 Leader. She has been a recipient of accolades such as the Jamnalal Bajaj Award for Development and Welfare of Women and Children in 2019, the Beyond Business - ET Prime Women Leadership Award for 2020, Niti Aayaog’s Women Transforming India Award and the Ramachandra-Ikeda Award in 2022, to name a few."
    },
  ];
  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    return DrawerWrapper(
        disableGestures: true,
        drawerController: _advancedDrawerController,
        scaffold: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text("",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ))),
              ),
              backgroundColor: Color.fromRGBO(87, 69, 128, 0),
            ),
            body: AnimatedContainer(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: getAlignments[counter % getAlignments.length],
                  end: getAlignments[(counter + 2) % getAlignments.length],
                  colors: getColorsList,
                  //tileMode: TileMode.values(),
                )),
                duration: const Duration(seconds: 2),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Conclave",
                            style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 249, 248, 250),
                              letterSpacing: 0.2,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 0.0),
                              scrollDirection: Axis.vertical,
                              primary: true,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AwesomeListItem(
                                  name: data[index]["name"],
                                  title: data[index]["title"],
                                  desc: data[index]["desc"],
                                  img: data[index]["img"],
                                );
                              }),
                        ),
                      ],
                    )))))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class AwesomeListItem extends StatefulWidget {
  var img;
  var name;
  var title;
  var desc;

  AwesomeListItem({
    this.name,
    this.img,
    this.title,
    this.desc,
  });

  @override
  _AwesomeListItemState createState() => _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded1 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 4.0,
          shadowColor: const Color.fromARGB(255, 59, 59, 59),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
              width: 220,
              height: 269,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 250, 231, 178),
                    //Color.fromARGB(255, 245, 230, 186),

                    Color.fromARGB(255, 197, 179, 245),
                    Color.fromARGB(255, 217, 170, 248),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 63, 12, 58),
                          radius: 75,
                          child: CircleAvatar(
                            radius: 72,
                            backgroundImage: AssetImage(widget.img),
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              bottom: 18, left: 6, right: 6),
                          child: Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  )),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Center(
                          child: AnimatedContainer(
                        duration: const Duration(microseconds: 900000),
                        curve: Curves.easeInOutQuad,
                        width: _isExpanded1 ? MediaQuery.of(context).size.width * 0.85: 0,
                        height: _isExpanded1 ? 272 : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: _isExpanded1
                                  ? const Radius.circular(0)
                                  : const Radius.circular(0),
                              bottomLeft: _isExpanded1
                                  ? const Radius.circular(0)
                                  : const Radius.circular(0)),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 37, 18, 59),
                              Color.fromARGB(253, 53, 21, 65),
                              Color.fromARGB(255, 63, 12, 58),
                              Color.fromARGB(253, 82, 13, 75),
                              Color.fromARGB(254, 28, 14, 44),
                              Color.fromARGB(255, 35, 28, 37),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: _isExpanded1
                            ? Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: CircleAvatar(
                                          radius: 45,
                                          backgroundImage:
                                              AssetImage(widget.img),
                                        )),
                                    Expanded(
                                        child: Text(
                                      widget.name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      widget.title,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                      textAlign: TextAlign.center,
                                    )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 34,
                                                right: 34,
                                                top: 5,
                                                bottom: 10),
                                            child: SingleChildScrollView(
                                              primary: false,
                                                scrollDirection: Axis.vertical,
                                                child: Text(
                                                  widget.desc,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                  textAlign: TextAlign.justify,
                                                ))))
                                  ],
                                ))
                            : null,
                      ))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Center(
                          child: AnimatedContainer(
                        duration: const Duration(microseconds: 9000000),
                        curve: Curves.decelerate,
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20)),
                            color: Color.fromARGB(255, 3, 0, 7)),
                        child: Transform.rotate(
                            angle: 585 * math.pi / 180,
                            child: IconButton(
                              icon: _isExpanded1
                                  ? const Icon(
                                      Icons.arrow_back_ios,
                                    )
                                  : const Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                              color: const Color.fromARGB(255, 231, 228, 238),
                              onPressed: () {
                                setState(() {
                                  _isExpanded1 = !_isExpanded1;
                                });
                              },
                            )),
                      ))),
                ],
              )),
        ));
  }
}
