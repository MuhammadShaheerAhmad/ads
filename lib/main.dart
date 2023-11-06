//
import 'theme.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'desc.dart';
import 'splash.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MyScrollScreen.dart';
import 'splash_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Firebase app
  await Firebase.initializeApp();
  MobileAds.instance.initialize() .then((initializationStatus) {
    initializationStatus.adapterStatuses.forEach((key, value) {
      debugPrint('Adapter status for $key: ${value.description}');
    });
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => CardSelectionModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
static String serverIs="inspire";

  void initState() {
    // loadInterstitialAd();

    // Add a delay and then navigate to the main screen
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => MyScrollScreen()),
    //   );
    // });
  }
  @override
  void dispose() {
    // showInterstitialAd();

  }

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme ,
      // Set the app's theme to black
      home:SplashScreen(),
    );
  }
}
// ThemeData.dark().copyWith(
// colorScheme: ColorScheme.dark().copyWith(primary: Colors.black),
// ),
