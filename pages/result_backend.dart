// ignore_for_file: sdk_version_since

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:malhar_2023/credentials/credentials.dart';

class GoogleSheetsService {
  static final _gsheets = GSheets(credentials);

  static Future<List<List<String>>> fetchData(String spreadsheetId, String sheetTitle) async {
    final ss = await _gsheets.spreadsheet(spreadsheetId);
    final sheet = ss.worksheetByTitle(sheetTitle);
    
    final values = await sheet!.values.allRows();
    return values.map((row) => row.map((value) => value.toString()).toList()).toList();
  }
}


class MyHomePages extends StatefulWidget {
  @override
  _MyHomePagesState createState() => _MyHomePagesState();
}

class _MyHomePagesState extends State<MyHomePages> {
  var _sheetData = [];

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
        if (eventData.where((element) => element[5] == '$i').first[6] == 'true') {
          print("TRUE");
          eventDict['Rank$i'] = eventData.where((element) => element[5] == '$i').first.elementAtOrNull(4) ?? "NA";
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
    const sheetTitle = 'Sheet1'; // Change to your sheet's title
    
    final data = await GoogleSheetsService.fetchData(spreadsheetId, sheetTitle);
    
    // var etc = data.where((row) => row.contains('ETC'));
    // print(etc.where((element) => element[2] == '1'));
    // print('------------------------------');
    var ipa_events = getEvents('WPA', data);
    
    setState(() {
      _sheetData = ipa_events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sheets Data'),
      ),
      body: ListView.builder(
        itemCount: _sheetData.length,
        itemBuilder: (context, index) {
          final rowData = _sheetData[index];
          return ListTile(
            title: Text(rowData.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _fetchDataFromSheet),
    );
  }
}
