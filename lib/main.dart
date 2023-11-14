//
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'splash_screen.dart';
import 'AdManager.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
int _counter = 0;
late AppLifecycleReactor _appLifecycleReactor;
late StreamSubscription subscription;
bool net = false;
final InternetConnectionChecker customInstance =
InternetConnectionChecker.createInstance(
  checkTimeout: const Duration(seconds: 1),
  checkInterval: const Duration(seconds: 5),
);
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Firebase app
  await Firebase.initializeApp();
  MobileAds.instance.initialize() .then((initializationStatus) {
    initializationStatus.adapterStatuses.forEach((key, value) {
      debugPrint('Adapter status for $key: ${value.description}');
    });
  });

  AppOpenAdManager.appOpenAdManager = AppOpenAdManager();
  _appLifecycleReactor = AppLifecycleReactor(
      appOpenAdManager: AppOpenAdManager.appOpenAdManager);
  subscription = FGBGEvents.stream.listen((event) {
    print("Main_Cycle:$event");
    if (event == FGBGType.foreground) {
      AppOpenAdManager.showAdIfAvailable(); }

  });
  await execute(InternetConnectionChecker());

  // Create customized instance which can be registered via dependency injection


  // Check internet connection with created instance
  await execute(customInstance);
}

Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
    ) async {
  // Simple check to see if we have Internet
  // ignore: avoid_print
  print('''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  // ignore: avoid_print
  print(
    isConnected.toString(),
  );
  // returns a bool

  // We can also get an enum instead of a bool
  // ignore: avoid_print
  print(
    'Current status of internet: ${await InternetConnectionChecker().connectionStatus}',
  );
  // Prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // actively listen for status updates
  final StreamSubscription<InternetConnectionStatus> listener =
  InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
        // ignore: avoid_print
          print('Data connection is available.');
          net = true;
          break;
        case InternetConnectionStatus.disconnected:
        // ignore: avoid_print
          net = false;
          print('Data connection disconnected from the internet.');
// Fluttertoast.showToast(
//       msg: "Please Check Your Internet Connection",
//       toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );

          break;
      }
    },
  );

  // close listener after 30 seconds, so the program doesn't run forever
  await Future<void>.delayed(const Duration(seconds: 5));
  await listener.cancel();
  runApp(

     MyApp(),

  );
}

class MyApp extends StatelessWidget {
static String serverIs="inspire";
static bool openAdshow = false;
  void initState() {

  }

  void dispose() {


  }

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme ,

      home:SplashScreen(),
    );
  }
}
