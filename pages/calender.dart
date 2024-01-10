import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malhar_2023/components/drawer.dart';
import 'package:malhar_2023/home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
      disableGestures: false,
      drawerController: _advancedDrawerController,
      scaffold: Scaffold(
        backgroundColor: const Color.fromARGB(255, 41, 1, 42),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 41, 1, 42),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Get.to(
                HomeScreen(),
              );
              // Get.to(DrawerWrapper(scaffold: AdvancedDrawer(child: child, drawer: drawer), drawerController: drawerController, disableGestures: disableGestures)));
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCalendar(
              // showDatePickerButton: true,
              showNavigationArrow: true,
              // allowViewNavigation: true,
              viewHeaderHeight: 50,
              viewHeaderStyle: ViewHeaderStyle(
                // backgroundColor: Colors.white.withOpacity(0.2),
                dayTextStyle: GoogleFonts.ptSans(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.2),
                    fontWeight: FontWeight.w500),
              ),

              headerHeight: 80,
              headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.start,
                  backgroundColor: const Color.fromARGB(255, 41, 1, 42),
                  textStyle: GoogleFonts.ptSans(
                      fontSize: 25,
                      // fontStyle: FontStyle.normal,
                      // letterSpacing: 5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              todayHighlightColor: Colors.transparent,

              selectionDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
              backgroundColor: const Color.fromARGB(255, 41, 1, 42),
              cellBorderColor: Colors.transparent,
              initialDisplayDate: DateTime(2023, 6, 1),
              //calendar goes from
              minDate: DateTime(2023, 6, 1),
              //till this
              maxDate: DateTime(2023, 8, 31),
              view: CalendarView.month,
              controller: _calendarController,
              monthViewSettings: MonthViewSettings(
                showAgenda: true,
                navigationDirection: MonthNavigationDirection.vertical,
                //how much space whole agenda view takes
                // agendaItemHeight: 300, //by default
                //height of each appointment in agenda
                agendaItemHeight: 60,
                //direction of scroll
                // horizontal by default
                // navigationDirection: MonthNavigationDirection.vertical,
                //removes dates from other month
                showTrailingAndLeadingDates: false,
                // to show week day names on top
                dayFormat: 'EE',

                //==========agenda view style begins==================//
                agendaStyle: AgendaStyle(
                  placeholderTextStyle: GoogleFonts.ptSans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // fontStyle: FontStyle.italic,
                      color: Colors.white),
                  backgroundColor: const Color.fromARGB(255, 41, 1, 42),
                  appointmentTextStyle: GoogleFonts.ptSans(
                    color: const Color.fromARGB(255, 41, 1, 42),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    // fontStyle: FontStyle.italic,
                    // color: Colors.white
                  ),
                  dateTextStyle: GoogleFonts.ptSans(
                      // fontStyle: FontStyle.italic
                      // ,
                      // decorationColor: Colors.black,
                      // backgroundColor: Colors.purpleAccent,

                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  dayTextStyle: GoogleFonts.ptSans(
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),

                //===========agenda view style ends===================//

                //=================cell style beigns ===================//
                monthCellStyle: MonthCellStyle(
                  backgroundColor: const Color.fromARGB(255, 41, 1, 42),

                  // trailingDatesBackgroundColor: Color(0xff216583),
                  // leadingDatesBackgroundColor: Color(0xff216583),
                  // todayBackgroundColor: Color(0xFFf7be16),
                  textStyle: GoogleFonts.ptSans(
                      fontSize: 16,
                      // fontFamily: 'Arial',
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  // todayTextStyle: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'Arial'),

                  // trailingDatesTextStyle: TextStyle(
                  //     // fontStyle: FontStyle.italic,
                  //     fontSize: 12,
                  //     fontFamily: 'Arial'),
                  // leadingDatesTextStyle: TextStyle(
                  //     // fontStyle: FontStyle.italic,
                  //     fontSize: 12,
                  //     fontFamily: 'Arial')
                ),

                //==================cell style ends ends ================//
              ),
              dataSource: getCalendarDataSource(),
              onViewChanged: viewChanged,
            ),
          ),
        ),
      ),
    );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      var midDate = (viewChangedDetails
          .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]);
      if (midDate.month == DateTime.now().month) {
        _calendarController.selectedDate = DateTime.now();
      } else {
        _calendarController.selectedDate = DateTime(
          midDate.year,
          midDate.month,
          01,
          9,
          0,
          0,
        );
      }
    });
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];

    //=======================June==============================//
    //1
    appointments.add(Appointment(
      startTime: DateTime.utc(2023, 6, 19),
      endTime: DateTime.utc(2023, 6, 19),
      // endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Dance Workshop WINC',
      color: Colors.white,
      isAllDay: true,
    ));
    //2
    appointments.add(Appointment(
      isAllDay: true,
      startTime: DateTime.utc(2023, 6, 23),
      endTime: DateTime.utc(2023, 6, 23),
      subject: 'Malhar Mela PR',
      color: Colors.white,
    ));

    //3
    appointments.add(Appointment(
      isAllDay: true,
      startTime: DateTime.utc(2023, 6, 25),
      endTime: DateTime.utc(2023, 6, 25),
      subject: 'Mural Workshop WINC',
      color: Colors.white,
    ));

    appointments.add(Appointment(
      isAllDay: true,
      startTime: DateTime.utc(2023, 6, 27),
      endTime: DateTime.utc(2023, 6, 27),
      subject: 'Garnier Event PR',
      color: Colors.white,
    ));
    appointments.add(
      Appointment(
          isAllDay: true,
          startTime: DateTime.utc(2023, 6, 29),
          endTime: DateTime.utc(2023, 6, 29),
          subject: 'Navya Nanda PR',
          color: Colors.white),
    );
    //==========================July============================================//
    //1
    appointments.add(Appointment(
      startTime: DateTime.utc(2023, 7, 2),
      endTime: DateTime.utc(2023, 7, 2),
      // endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'WB',
      color: Colors.white,
      isAllDay: true,
    ));

    //2
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 3),
        endTime: DateTime.utc(2023, 7, 3),
        subject: 'LA Treasure Hunt',
        color: Colors.white));

    //3
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 6),
        endTime: DateTime.utc(2023, 7, 6),
        subject: 'FA Speed Painting',
        color: Colors.white));
    //4
    appointments.add(Appointment(
      isAllDay: true,
      startTime: DateTime.utc(2023, 7, 8),
      endTime: DateTime.utc(2023, 7, 8),
      subject: 'CL Meet',
      color: Colors.white,
    ));
    //5
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 9),
        endTime: DateTime.utc(2023, 7, 9),
        subject: 'CL Meet Online',
        color: Colors.white));
    //6
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 10),
        endTime: DateTime.utc(2023, 7, 10),
        subject: 'Contingent Reg Starts',
        color: Colors.white));
    //7
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 12),
        endTime: DateTime.utc(2023, 7, 12),
        subject: 'Social Cause Event',
        color: Colors.white));
    //8
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 13),
        endTime: DateTime.utc(2023, 7, 13),
        subject: 'Yardsale Collection SXC',
        color: Colors.white));
    //8
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 13),
        endTime: DateTime.utc(2023, 7, 13),
        subject: 'Form Verification',
        color: Colors.white));
    //9
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 16),
        endTime: DateTime.utc(2023, 7, 16),
        subject: 'By the Bay Auditions',
        color: Colors.white));
    //10
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 17),
        endTime: DateTime.utc(2023, 7, 17),
        subject: 'Conclave Reveal',
        color: Colors.white));
    //10
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 17),
        endTime: DateTime.utc(2023, 7, 17),
        subject: 'Press Conference',
        color: Colors.white));
    //11
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 18),
        endTime: DateTime.utc(2023, 7, 18),
        subject: 'Contingent Reg Ends',
        color: Colors.white));
    //12
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 19),
        endTime: DateTime.utc(2023, 7, 19),
        subject: 'ETC Stage Combat',
        color: Colors.white));
    //12
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 19),
        endTime: DateTime.utc(2023, 7, 19),
        subject: 'PRNC Reg Starts',
        color: Colors.white));
    //13
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 22),
        endTime: DateTime.utc(2023, 7, 22),
        subject: 'PRNC Reg Ends',
        color: Colors.white));
    //14
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 30),
        endTime: DateTime.utc(2023, 7, 30),
        subject: 'Yardsale',
        color: Colors.white));
    //15
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 7, 31),
        endTime: DateTime.utc(2023, 7, 31),
        subject: 'IPA Jugalbandi',
        color: Colors.white));
    //=========================August================================//
    //1
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 8, 1),
        endTime: DateTime.utc(2023, 8, 1),
        subject: 'AM Night Auditions',
        color: Colors.white));
    //2
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 8, 2),
        endTime: DateTime.utc(2023, 8, 2),
        subject: 'AM Night Auditions',
        color: Colors.white));

    //2
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 8, 2),
        endTime: DateTime.utc(2023, 8, 2),
        subject: 'WINC Self Defense',
        color: Colors.white));
    //3
    appointments.add(Appointment(
        isAllDay: true,
        startTime: DateTime.utc(2023, 8, 6),
        endTime: DateTime.utc(2023, 8, 6),
        subject: 'Malhar by the Bay',
        color: Colors.white));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
