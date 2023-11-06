import 'package:flutter/material.dart';
import 'splash.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any necessary initialization or data loading here.
    // For demonstration, we'll use a delay before navigating to the main screen.
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the main screen or home screen after the delay.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Customize your splash screen layout here.
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset('assets/img/logo.png')),


          ],
        ),
      ),
    );
  }
}
