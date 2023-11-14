import 'dart:async';

// import 'dart:html';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MyScrollScreen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'AdManager.dart';


import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
final Uri _url2 = Uri.parse(
    'https://sites.google.com/view/navicosoftgamesprivacy-policy/home');

class SplashScreen1 extends StatefulWidget {

static bool? valueServer;
static bool? inter;
  @override
  State<SplashScreen1> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen1> {

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  @override

  bool checkvisibility_bar=true;
  int counter=0;
  bool checkvisibility_btn=false;
  void checkforresponse(){
    counter++;
     if(counter<4){
       Timer(Duration(seconds: 2), (){
         setState(() {
           if(AppOpenAdManager.firstOpen){
             checkvisibility_bar=false;
             checkvisibility_btn=true;
           }else{
             checkforresponse();
           }
         });
       });
     }else{
       checkvisibility_bar=false;
       checkvisibility_btn=true;
     }


 }
void recursivecall(){
   Timer(Duration(seconds: 3), (){
     setState(() {
     if(AppOpenAdManager.firstOpen){
       checkvisibility_bar=false;
       checkvisibility_btn=true;
     }else{
      checkforresponse();
     }
     });
   });

  }


  void initState()   {


    RewardedAdManager.loadInterstitialAd();
    recursivecall();
    RewardedAdManager.createRewardedAd();
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/img/bg1.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),


          // Positioned Container at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: -20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 500, // Adjust the height of the container as needed
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First Row (60%)
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/img/pic.jpg', // Replace with your image asset path
                            width: 120, // Adjust the width and height as needed
                            height: 120,
                            fit: BoxFit
                                .cover, // You can use BoxFit.fill or other options as needed
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Welcome to \n  ADs In Flutter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'ADs ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                          ),
                        ),
                      ),
                    ),

                    // Second Row (20%)
                    Expanded(
                      flex: 1,
                      child:  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Visibility(
                              visible:checkvisibility_bar,
                              child: CircularProgressIndicator(), // Display a loading indicator
                            ),
                            Visibility(
                              visible: checkvisibility_btn,
                              child: ElevatedButton(

                                onPressed: () {

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyScrollScreen(),
                                    ),
                                  );
                                  // Add button functionality here
                                  FirebaseAnalytics.instance.logEvent(
                                    name: "LETS_GO_CLICKED",
                                    parameters: {"button_name": " LETS_GO_CLICKED"},
                                  );
                                  // Debug log
                                  print("Firebase Analytics event logged: LETS_GO_CLICKED");
                                  // Your button functionality here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5BC22A),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                ),
                                child: Center(
                                  child: Text(
                                    'Let\'s Go',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Third Row (20%)
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Background color
                          ),
                          onPressed: () {

                            _launchUrl2();
                            // Optional: Navigate to the main screen when the button is pressed.

                          },
                          child: Text(
                            'TERMS AND CONDITIONS | PRIVACY POLICY',
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
Future<void> _launchUrl2() async {

}
//Fluttertoast.showToast(
//       msg: "Somewhere Error : ${response.statusCode}",
//       toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );
