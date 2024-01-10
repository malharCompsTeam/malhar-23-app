// import 'dart:js_interop';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:folding_cell/folding_cell.dart';

import 'package:gsheets/gsheets.dart';
import 'package:malhar_2023/credentials/credentials.dart';

class GoogleSheetsService {
  static final _gsheets = GSheets(credentials);

  static Future<List<List<String>>> fetchData(
      String spreadsheetId, String sheetTitle) async {
    final ss = await _gsheets.spreadsheet(spreadsheetId);
    final sheet = ss.worksheetByTitle(sheetTitle);

    final values = await sheet!.values.allRows();
    return values
        .map((row) => row.map((value) => value.toString()).toList())
        .toList();
  }
}

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with TickerProviderStateMixin {
  var _ipaEvents = [];
  var _wpaEvents = [];
  var _faEvents = [];
  var _etcEvents = [];
  var _laEvents = [];
  var _crossoverEvents = [];
  var _malharspacesEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromSheet();
  }

  List<Map<String, String>> getEvents(deptName, List<List<String>> data) {
    // events
    List<Map<String, String>> events = [];
    var deptData = data.where((element) => element[0] == deptName);

    for (var i = 1; i <= (deptData.length / 4); i++) {
      var eventData = deptData.where((element) => element[2] == '$i').toList();

      Map<String, String> eventDict = {
        'Event_Name': eventData[0][1],
      };

      // print(eventData.where((element) => element[6] == 'true').where((element) => element[5] == '2').first[6]);
      for (var i = 1; i <= 4; i++) {
        if (eventData.where((element) => element[5] == '$i').first[6] ==
            'true') {
          print("TRUE");
          eventDict['Rank$i'] = eventData
                  .where((element) => element[5] == '$i')
                  .first
                  .elementAtOrNull(4) ??
              "NA";
        } else {
          print("FALSE");
        }
      }

      print(eventDict);
      events.add(eventDict);
    }

    return events;
  }

  Future<void> _fetchDataFromSheet() async {
    const spreadsheetId = '1kvQm4rXCf47r5En2RUGDF9tcNPrTGjfdQcDRUZzgC4A';
    const sheetTitle = 'Sheet1';

    final data = await GoogleSheetsService.fetchData(spreadsheetId, sheetTitle);

    // var ipaEvents = getEvents('IPA', data);
    // var ipa_events = getEvents('IPA', data);

    setState(() {
      _ipaEvents = getEvents('IPA', data);
      _wpaEvents = getEvents('WPA', data);
      _faEvents = getEvents('FA', data);
      _laEvents = getEvents('LA', data);
      _etcEvents = getEvents('ETC', data);
      _crossoverEvents = getEvents('CROSSOVER', data);
      _malharspacesEvents = getEvents('MALHAR SPACES', data);
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabcontroller = TabController(length: 7, vsync: this);
    var _scrollController = ScrollController();

    final _advancedDrawerController = AdvancedDrawerController();
    // var data = [
    //   {
    //     "eventname": "Harmonics",
    //     "r1": "participant 1",
    //     "r2": "participant 2",
    //     "r3": "participant 3",
    //   },
    //   {
    //     "eventname": "Harmonics",
    //     "r1": "participant 1",
    //     "r2": "participant 2",
    //     "r3": "participant 3",
    //   },
    // ];

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
          backgroundColor: Color.fromARGB(255, 45, 2, 53),
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
                Color.fromARGB(255, 45, 2, 53),
                Color.fromARGB(255, 70, 2, 82),
                Color.fromRGBO(182, 134, 230, 1),
              ],
            )),
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //workforce title
                      Container(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("Results",
                            textAlign: TextAlign.center,
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
                        isScrollable: true,
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
                            color: Color.fromRGBO(250, 221, 54, 1), radius: 3),
                        controller: tabcontroller,
                        tabs: const [
                          Tab(text: "WPA"),
                          Tab(text: "IPA"),
                          Tab(text: "FA"),
                          Tab(text: "ETC"),
                          Tab(text: "LA"),
                          Tab(text: "Crossover"),
                          Tab(text: "Malhar Spaces"),
                        ],
                      )),

                      const SizedBox(height: 15),

                      //tabbar view
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          height: 1500,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(37.0),
                          ),
                          child:
                              TabBarView(controller: tabcontroller, children: [
                            //WPA
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _wpaEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _wpaEvents[index]['Event_Name'],
                                    r1: _wpaEvents[index]["Rank1"] ?? "",
                                    r2: _wpaEvents[index]["Rank2"] ?? "",
                                    r3: _wpaEvents[index]["Rank3"] ?? "",
                                    r4: _wpaEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),
                            //IPA
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _ipaEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _ipaEvents[index]['Event_Name'],
                                    r1: _ipaEvents[index]["Rank1"] ?? "",
                                    r2: _ipaEvents[index]["Rank2"] ?? "",
                                    r3: _ipaEvents[index]["Rank3"] ?? "",
                                    r4: _ipaEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),

                            //FA
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _faEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _faEvents[index]['Event_Name'],
                                    r1: _faEvents[index]["Rank1"] ?? "",
                                    r2: _faEvents[index]["Rank2"] ?? "",
                                    r3: _faEvents[index]["Rank3"] ?? "",
                                    r4: _faEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),
                            //ETC
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _etcEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _etcEvents[index]['Event_Name'],
                                    r1: _etcEvents[index]["Rank1"] ?? "",
                                    r2: _etcEvents[index]["Rank2"] ?? "",
                                    r3: _etcEvents[index]["Rank3"] ?? "",
                                    r4: _etcEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),
                            //LA
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _laEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _laEvents[index]['Event_Name'],
                                    r1: _laEvents[index]["Rank1"] ?? "",
                                    r2: _laEvents[index]["Rank2"] ?? "",
                                    r3: _laEvents[index]["Rank3"] ?? "",
                                    r4: _laEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),
                            //C

                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _crossoverEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _crossoverEvents[index]
                                        ['Event_Name'],
                                    r1: _crossoverEvents[index]["Rank1"] ?? "",
                                    r2: _crossoverEvents[index]["Rank2"] ?? "",
                                    r3: _crossoverEvents[index]["Rank3"] ?? "",
                                    r4: _crossoverEvents[index]["Rank4"] ?? "",
                                  );
                                },
                              ),
                            ),
                            //MS
                            SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 0.0),
                                scrollDirection: Axis.vertical,
                                primary: false,
                                itemCount: _malharspacesEvents.length,
                                itemBuilder: (BuildContext content, int index) {
                                  return AwesomeListItem(
                                    eventname: _malharspacesEvents[index]
                                        ['Event_Name'],
                                    r1: _malharspacesEvents[index]["Rank1"] ??
                                        "",
                                    r2: _malharspacesEvents[index]["Rank2"] ??
                                        "",
                                    r3: _malharspacesEvents[index]["Rank3"] ??
                                        "",
                                    r4: _malharspacesEvents[index]["Rank4"] ??
                                        "",
                                  );
                                },
                              ),
                            ),
                          ]),
                        ),
                      )
                    ]))),
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

class AwesomeListItem extends StatefulWidget {
  String eventname;
  String r1;
  String r2;
  String r3;
  String r4;

  AwesomeListItem(
      {required this.eventname,
      required this.r1,
      required this.r2,
      required this.r3,
      required this.r4});

  @override
  _AwesomeListItemState createState() => _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(),
        innerWidget: _buildInnerWidget(),
        cellSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.width * 0.45),
        padding: EdgeInsets.all(15),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 10,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromRGBO(230, 183, 116, 1),
          Color.fromRGBO(231, 123, 164, 1),

          //Color.fromRGBO(146, 130, 41, 1),
        ],
      )),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.eventname,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color.fromARGB(255, 30, 1, 36),
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          TextButton(
            onPressed: () => _foldingCellKey.currentState?.toggleFold(),
            child: Text(
              "View Results",
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(68, 255, 255, 255),
              minimumSize: Size(80, 40),
            ),
          )
        ],
      ),
    );
  }

  var counter = 0;

  List<Color> get getColorsList => [
        Color.fromARGB(255, 255, 139, 97),
        //Color.fromARGB(255, 77, 2, 90),
        //Color.fromARGB(255, 119, 3, 139),
        //Color.fromARGB(255, 7, 0, 8),
        Color.fromARGB(202, 223, 140, 140),
        Color.fromARGB(198, 244, 80, 65),
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

  Widget _buildInnerWidget() {
    return AnimatedContainer(
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
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     Color.fromARGB(255, 209, 186, 252),
        //     Color.fromARGB(255, 245, 231, 150),
        //   ],
        // )),
        // padding: EdgeInsets.only(top: 10),
        child: /*Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Results",
              style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: Colors.black,
                                              ),
                                          textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20,),
          Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: 
          Column(children: [
            Text(
              widget.r1,
              style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.black,
                                              ),
                                          textAlign: TextAlign.center,
            ),
          SizedBox(height: 2,),
         Text(
              widget.r2,
              style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.black,
                                              ),
                                          textAlign: TextAlign.center,
            ),
                    SizedBox(height: 2,),

         Text(
              widget.r3,
              style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: Colors.black,
                                              ),
                                          textAlign: TextAlign.center,
            ),
          
          ],))),
          SizedBox(height: 10,),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => _foldingCellKey.currentState?.toggleFold(),
              child: Text(
                "Close",
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(80, 40),
              ),
            ),
          ),
        ],
      ),*/
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top:8),
                child: Text(
                  "Results",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 23,
                    color: Color.fromARGB(255, 30, 1, 36),
                  ),
                  textAlign: TextAlign.center,
              
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.r1.isNotEmpty
                ? Text(
                    "1. " + widget.r1,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 7,
            ),
            widget.r2.isNotEmpty
                ? Text(
                    "2. " + widget.r2,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 7,
            ),
            widget.r3.isNotEmpty
                ? Text(
                    "3. " + widget.r3,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 7,
            ),
            Text(
              "4. " + widget.r4,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Positioned(
                right: 10,
                bottom: 10,
                child: TextButton(
                  onPressed: () => _foldingCellKey.currentState?.toggleFold(),
                  child: Text(
                    "Close",
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(68, 255, 255, 255),
                    minimumSize: Size(80, 40),
                  ),
                )),
          ],
        ));
  }
}
