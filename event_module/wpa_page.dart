import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:malhar_2023/event_module/home_page.dart';
import 'package:malhar_2023/event_module/random.dart';
import 'package:malhar_2023/event_module/score.dart';


class WPAHome extends StatefulWidget {
  final String user;

  WPAHome({required this.user});
  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<WPAHome> {
  late String user;
  @override
  void initState() {
    user = widget.user;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Color.fromARGB(179, 4, 3, 3),
                  fontSize: 25,
                  fontWeight: FontWeight.w600)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PopUp(user: user,))),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              title: Text(
                "Event1",
                style: TextStyle(fontSize: 20),
              ),
              children: <Widget>[
                SizedBox(height: 13,),
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          GestureDetector(
                              child: Text(
                                "     View Result",
                                style: TextStyle(fontSize: 16),
                              ),
                              onTap: (){Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScorePage(user: user)));}),

                          SizedBox(
                            height: 25,
                          ),
                          
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ExpansionTile(
              title: Text(
                "Event2",
                style: TextStyle(fontSize: 20),
              ),
              children: <Widget>[
                SizedBox(height: 13,),
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          GestureDetector(
                              child: Text(
                                "     View Result",
                                style: TextStyle(fontSize: 16),
                              ),
                              onTap: (){}),
                          SizedBox(
                            height: 25,
                          ),
                          
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ExpansionTile(
              title: Text(
                "Event3",
                style: TextStyle(fontSize: 20),
              ),
              children: <Widget>[
                SizedBox(height: 13,),
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          GestureDetector(
                              child: Text(
                                "     View Result",
                                style: TextStyle(fontSize: 16),
                              ),
                              onTap: (){}),
                          SizedBox(
                            height: 25,
                          ),
                         
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}