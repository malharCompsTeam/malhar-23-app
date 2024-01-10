import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_social_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';
import 'package:malhar_2023/event_module/home_page.dart';
import 'package:malhar_2023/event_module/wpa_page.dart';

import '../credentials/credentials.dart';

class ScorePage extends StatelessWidget {
  final String user;
  const ScorePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Randomiser",
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 203, 245),
        appBar: AppBar(
          title: Text(
            "",
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 246, 230, 248)),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WPAHome(user: user))),
          ),
          backgroundColor: Color.fromARGB(255, 24, 5, 33),
        ),
        body: MyCustomForm(
          user: user,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final String user;
  const MyCustomForm({required this.user});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  late String user;
  var sheet, sheet1;
  String j1_1 = "",
      j1_2 = "",
      j1_3 = "",
      j1_4 = "",
      j1_5 = "",
      j1_6 = "",
      j2_1 = "",
      j2_2 = "",
      j2_3 = "",
      j2_4 = "",
      j2_5 = "",
      j2_6 = "",
      neg1 = "",
      neg2 = "",
      neg3 = "",
      sum_t = "",
      sum_n = "",
      pid = "";
  bool fetched = false;

  var contingent_name = "";

  @override
  void initState() {
    user = widget.user;

    main();
    _startBgColorAnimationTimer();
    super.initState();
  }

  // Contact sheet details
  final sheetsId = '1H58u6UyGh48MROdura5g_nzhbuQRW2Ie8E8FWsMbqYw';

  final scoreID = '1pPfpF2MsbOrVvRnhzTn0vdYmVus6JMyt_7EVriIkW4E';
  void fetch() async {
    var name = await sheet.values.column(1, fromRow: 2);
    var score_name = await sheet1.values.column(1, fromRow: 1);

    for (int i = 0; i < name.length; i++) {
      if (user == name[i]) {
        String cn = await sheet.values.value(column: 2, row: i + 2);
        setState(() {
          contingent_name = cn;
        });
      }
    }

    for (int i = 0; i < score_name.length; i++) {
      if (contingent_name == score_name[i]) {
        String t1 = await sheet1.values.value(column: 5, row: i + 1);
        String t2 = await sheet1.values.value(column: 5, row: i + 2);
        String t3 = await sheet1.values.value(column: 5, row: i + 3);
        String t4 = await sheet1.values.value(column: 5, row: i + 4);
        String t5 = await sheet1.values.value(column: 5, row: i + 5);
        String t6 = await sheet1.values.value(column: 5, row: i + 6);

        String t21 = await sheet1.values.value(column: 6, row: i + 1);
        String t22 = await sheet1.values.value(column: 6, row: i + 2);
        String t23 = await sheet1.values.value(column: 6, row: i + 3);
        String t24 = await sheet1.values.value(column: 6, row: i + 4);
        String t25 = await sheet1.values.value(column: 6, row: i + 5);
        String t26 = await sheet1.values.value(column: 6, row: i + 6);

        String t31 = await sheet1.values.value(column: 8, row: i + 1);
        String t32 = await sheet1.values.value(column: 8, row: i + 2);
        String t33 = await sheet1.values.value(column: 8, row: i + 3);

        String negfinal = await sheet1.values.value(column: 11, row: i + 1);
        String total = await sheet1.values.value(column: 10, row: i + 1);

        String part = await sheet1.values.value(column: 2, row: i + 1);
        setState(() {
          pid = part;
          j1_1 = t1;
          j1_2 = t2;
          j1_3 = t3;
          j1_4 = t4;
          j1_5 = t5;
          j1_6 = t6;

          j2_1 = t21;
          j2_2 = t22;
          j2_3 = t23;
          j2_4 = t24;
          j2_5 = t25;
          j2_6 = t26;
          neg1 = t31;
          neg2 = t32;
          neg3 = t33;
          sum_t = total;
          sum_n = negfinal;
          fetched = true;
        });
      }
    }
  }

  void main() async {
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(sheetsId);
    // get worksheet by its title
    sheet = await ss.worksheetByTitle('cl_login');

    // init GSheets
    final scoresheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final score = await scoresheets.spreadsheet(scoreID);
    // get worksheet by its title
    sheet1 = await score.worksheetByTitle('copy_sheet');

    fetch();
  }

  var counter = 0;

  List<Color> get getColorsList => [
        Color.fromARGB(255, 217, 204, 240),
        //Color.fromARGB(255, 77, 2, 90),
        //Color.fromARGB(255, 119, 3, 139),
        //Color.fromARGB(255, 7, 0, 8),
        Color.fromARGB(199, 147, 80, 224),
        Color.fromARGB(198, 226, 138, 241),
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
  Widget build(BuildContext context) {
    return fetched
        ? AnimatedContainer(
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
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text("Participant ID :${pid} ",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(30, 2, 33, 1),
                    ))),
                SizedBox(
                  height: 40,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        // Datatable widget that have the property columns and rows.
                        columns: [
                          // Set the name of the column
                          DataColumn(
                            label: Text('Criteria'),
                          ),
                          DataColumn(
                            label: Text('Judge 1'),
                          ),
                          DataColumn(
                            label: Text('Judge 2'),
                          ),
                          DataColumn(
                            label: Text('Negative '),
                          ),
                          DataColumn(
                            label: Text('Negative Points'),
                          ),
                          DataColumn(
                            label: Text('Remark '),
                          ),
                          DataColumn(
                            label: Text('Total without Negatives '),
                          ),
                          DataColumn(
                            label: Text('Total with Negatives '),
                          ),
                        ],
                        rows: [
                          // Set the values to the columns
                          DataRow(cells: [
                            DataCell(Text("Originality and Relevance")),
                            DataCell(Text("${j1_1}")),
                            DataCell(Text("${j2_1}")),
                            DataCell(Text("Neg 10%")),
                            DataCell(Text("${neg1}")),
                            DataCell(Text("Registered Late ")),
                            DataCell(Text("${sum_t} ")),
                            DataCell(Text("${sum_n} ")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Adherence to performance element")),
                            DataCell(Text("${j1_2}")),
                            DataCell(Text("${j2_2}")),
                            DataCell(Text("Neg 10")),
                            DataCell(Text("${neg2}")),
                            DataCell(Text("VOP ")),
                            DataCell.empty,
                            DataCell.empty,
                          ]),
                          DataRow(cells: [
                            DataCell(
                                Text("Language used (vocabulary, grammar)")),
                            DataCell(Text("${j1_3}")),
                            DataCell(Text("${j2_3}")),
                            DataCell(Text("Neg 25")),
                            DataCell(Text("${neg3}")),
                            DataCell(Text("Physical argument")),
                            DataCell.empty,
                            DataCell.empty,
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                                "Expressions, Voice modulation and Body Language")),
                            DataCell(Text("${j1_4}")),
                            DataCell(Text("${j2_4}")),
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Judges Discretion")),
                            DataCell(Text("${j1_5}")),
                            DataCell(Text("${j2_5}")),
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                          ]),

                          DataRow(cells: [
                            DataCell(Text("Total")),
                            DataCell(Text("${j1_6}")),
                            DataCell(Text("${j2_6}")),
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                            DataCell.empty,
                          ]),
                        ])),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            color: Color.fromARGB(255, 23, 1, 36),
          ));
  }
}
