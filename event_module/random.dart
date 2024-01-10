import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_social_color.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsheets/gsheets.dart';
import 'package:malhar_2023/event_module/home_page.dart';
import 'package:malhar_2023/event_module/wpa_page.dart';


import '../credentials/credentials.dart';

class RandomPage extends StatelessWidget {
  final String user;
  const RandomPage({required this.user});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: "Randomiser",
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 203, 245),
        appBar:AppBar(
        title: Text(
          "Events",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Color.fromARGB(179, 4, 3, 3),
                  fontSize: 25,
                  fontWeight: FontWeight.w600)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => WPAHome(user: user))),
        ),
        backgroundColor: const Color.fromARGB(255, 222, 175, 242),
      ),
        body:  MyCustomForm(user: user,),
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
  var sheet;
  var shimmer=false;
  var rap="";
  var singing="";
   @override
  void initState() {
    user= widget.user;
    main();
    super.initState();
    
    
  }
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  
  // Contact sheet details
  final sheetsId = '1H58u6UyGh48MROdura5g_nzhbuQRW2Ie8E8FWsMbqYw';

 void main() async {
  // init GSheets
  final gsheets = GSheets(credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(sheetsId);
  // get worksheet by its title
   sheet = await ss.worksheetByTitle('cl_login');
}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        
        Row(children: [
          shimmer?Container(
          height: 200,
          width: 200,
          child: Card(
            child: ListTile(
              title:Text("$rap"),
            ),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 90, 4, 87),
            margin: const EdgeInsets.all(20),
          ),
        ):GFShimmer(
          mainColor: const Color.fromARGB(255, 51, 8, 59),
          child: Container(
          height: 200,
          width: 200,
          child: Card(
            child: ListTile(
              title:Text("$rap"),
            ),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 90, 4, 87),
            margin: const EdgeInsets.all(20),
          ),
        )),
        shimmer?Container(
          height: 200,
          width: 200,
          child: Card(
            child: ListTile(
              title:Text("$singing"),
            ),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 90, 4, 87),
            margin: const EdgeInsets.all(20),
          ),
        ):GFShimmer(
          mainColor: const Color.fromARGB(255, 51, 8, 59),
          child: Container(
          height: 200,
          width: 200,
          child: Card(
            child: ListTile(
              title:Text("$singing"),
            ),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 90, 4, 87),
            margin: const EdgeInsets.all(20),
          ),
        )),
        
        ],),
        
        
       
      
        Row(children: [
          const SizedBox(width: 20,),
          GestureDetector(
                onTap: (){},
                child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: angle),
                    duration: const Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      //here we will change the isBack val so we can change the content of the card
                      if (val >= (pi / 2)) {
                        isBack = false;
                      } else {
                        isBack = true;
                      }
                      return (Transform(
                        //let's make the card flip by it's center
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(val),
                        child: Container(
                           
                            height: 200,
                            width: 170,
                            child: isBack
                                ? Container(
                                  child: const Center(child: Text(
                                          "Rap",
                                          style: TextStyle(
                                            color: Color.fromARGB(95, 43, 2, 57),
                                            fontSize: 30.0,
                                            
                                          ),
                                        ),),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(255, 240, 237, 240),
                                    ),
                                  ) //if it's back we will display here
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..rotateY(
                                          pi), // it will flip horizontally the container
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 242, 233, 245),
                                      borderRadius: BorderRadius.circular(10.0),
                                      
                                    ),
                                      child: Center(
                                        child: Text(
                                          "$rap",
                                          style: const TextStyle(
                                            color: Color.fromARGB(96, 20, 2, 26),
                                            fontSize: 30.0,
                                          ),
                                        ),
                                        
                                      ),
                                    ),
                                  ) //else we will display it here,
                            ),
                      ));}
    )
    ),
    const SizedBox(width: 20,),
    GestureDetector(
                onTap: (){},
                child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: angle),
                    duration: const Duration(seconds: 1),
                    builder: (BuildContext context, double val, __) {
                      //here we will change the isBack val so we can change the content of the card
                      if (val >= (pi / 2)) {
                        isBack = false;
                      } else {
                        isBack = true;
                      }
                      return (Transform(
                        //let's make the card flip by it's center
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(val),
                        child: Container(
                           
                            height: 200,
                            width: 170,
                            child: isBack
                                ? Container(
                                  child: const Center(child: Text(
                                          "Singing",
                                          style: TextStyle(
                                            color: Color.fromARGB(96, 20, 2, 26),
                                            fontSize: 30.0,
                                            
                                          ),
                                        ),),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(255, 205, 165, 216),
                                    ),
                                  ) //if it's back we will display here
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()
                                      ..rotateY(
                                          pi), // it will flip horizontally the container
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 205, 165, 216),
                                      borderRadius: BorderRadius.circular(10.0),
                                      
                                    ),
                                      child: Center(
                                        child: Text(
                                          "$singing",
                                          style: const TextStyle(
                                            color: Color.fromARGB(96, 20, 2, 26),
                                            fontSize: 30.0,
                                          ),
                                        ),
                                        
                                      ),
                                    ),
                                  ) //else we will display it here,
                            ),
                      ));}
    )
    )
        ],),
       

 Center(
          child: shimmer?GFButton(onPressed: (){}, color: Colors.grey, textColor: const Color.fromARGB(255, 87, 82, 82),child: const Text("Randomize"), ): ElevatedButton(child: const Text('Randomize',style: TextStyle(color: Colors.white),
          ),
            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 31, 4, 34)),
  ),
            onPressed: () async{
              
              var name=await sheet.values.column(1, fromRow: 2);
              
                                          for(int i=0; i<name.length; i++){
                                            if(user==name[i]){
                                              
                                               String fetch1=await sheet.values.value(column: 3, row: i+2);
                                               String fetch2=await sheet.values.value(column: 4, row: i+2);
                                               setState(() {
                                                 shimmer=true;
                                                 rap=fetch1;
                                                 singing=fetch2;
                                               });
                                            }
                                          }
                                          _flip();
            },), 
            
        ),
        
    ],
    );
  }
}
