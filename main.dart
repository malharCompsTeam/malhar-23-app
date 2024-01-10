import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';
import 'package:malhar_2023/credentials/credentials.dart';
import 'package:malhar_2023/home.dart';
import 'package:malhar_2023/login_page.dart';
import 'package:malhar_2023/services/notifications.dart';
import 'components/drawer.dart';
import 'pages/blog.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:gsheets/gsheets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  await Hive.initFlutter();
  await Hive.openBox('settings');
  setNotif(loadDefaultSettings());
  // loadDefaultSettings();
  runApp(const MyApp());
}

bool loadDefaultSettings() {
  var box = Hive.box('settings');
  if (!box.containsKey('isNotifEnabled')) {
    box.put('isNotifEnabled', true);
  } else {
    return box.get('isNotifEnabled');
  }
  return true;
}

void setNotif(bool isEnabled) async {
  if (isEnabled) {
    print("In notif");
    // Check if connected to internet
    var isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      // Clearly previouslt scheduled notifs
      await NotificationService().notificationsPlugin.cancelAll();

      // Notif sheet config
      final sheetsId = '18WZxl01ksIcpp8GIR_I7sHbUm684V7ufqOqKFB9Thsk';
      final worksheetId = 0;
      final gsheets = GSheets(credentials);
      final sheet = await gsheets.spreadsheet(sheetsId);
      var workSheet = sheet.worksheetById(worksheetId);
      var result = await workSheet!.values.allRows(fromRow: 2, fill: true);

      // Iterate over notifications and schedule them
      for (final notification in result) {
        if (DateTime(2023, int.parse(notification[4].toString()),
                int.parse(notification[3].toString()) - 1, 12)
            .isAfter(DateTime.now())) {
          print("Registering Notif");
          NotificationService().showNotification(
              int.parse(notification[0]),
              notification[1].toString(),
              notification[2].toString(),
              tz.TZDateTime.from(
                  DateTime(2023, int.parse(notification[4].toString()),
                      int.parse(notification[3].toString()), 12),
                  tz.local));
          NotificationService().showNotification(
              int.parse(notification[0]),
              notification[1].toString(),
              notification[2].toString(),
              tz.TZDateTime.from(
                  DateTime(2023, int.parse(notification[4].toString()),
                      int.parse(notification[3].toString()) - 1, 12),
                  tz.local));
        }
      }
    }
  } else {
    await NotificationService().notificationsPlugin.cancelAll();
  }

  final List<PendingNotificationRequest> pendingNotificationRequests =
      await NotificationService()
          .notificationsPlugin
          .pendingNotificationRequests();
  // print(pendingNotificationRequests[0].id);

  // NotificationService().showNotification(0, 'a', "Notification body", tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)));
  // NotificationService().showNotification(0, a, "Notification body", tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Landing page',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Home'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
      disableGestures: false,
      drawerController: _advancedDrawerController,
      scaffold: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const HomeScreen(),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       setNotif();
        //     },
        //     child: Icon(Icons.login)),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
