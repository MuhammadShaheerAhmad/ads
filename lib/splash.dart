import 'dart:async';
import 'dart:io';
import 'package:Inspire.AI/inspirations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'MyScrollScreen.dart';
import 'AdManager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'animate.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
final Uri _url2 = Uri.parse(
    'https://sites.google.com/view/navicosoftgamesprivacy-policy/home');
class SplashScreen1 extends StatefulWidget {

static bool? valueServer;
  @override
  State<SplashScreen1> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen1> {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  @override
  void initState()   {
    fetchRemoteConfigValues();
    RewardedAdManager.createRewardedAd();
    super.initState();
  }


  initializeRemote() async {
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 15),
      minimumFetchInterval: Duration.zero, // Disable caching
    ));
    // remoteConfig = await setupRemoteConfig();
    //!- must be active firebase remote config
    bool updated = await remoteConfig.fetchAndActivate();
   updated =  await remoteConfig.getBool("imagine_server");
    if (updated) {
      // Fluttertoast.showToast(
      //   msg: "imagine_server : $updated",
      //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
      //   textColor: Colors.white, // Text color
      //   fontSize: 16.0, // Font size
      // );
      print("found");
      // the config has been updated, new parameter values are available.
    } else {
      // Fluttertoast.showToast(
      //   msg: "imagine_server else : $updated",
      //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
      //   textColor: Colors.white, // Text color
      //   fontSize: 16.0, // Font size
      // );
      print("not print");
      // the config values were previously updated.
    }
    await remoteConfig.ensureInitialized().then((value) async {
      print("remote value -> ${await remoteConfig.getBool("imagine_server")}");
      SplashScreen1.valueServer= updated;
      // Fluttertoast.showToast(
      //   msg: "imagine_server : $updated",
      //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
      //   textColor: Colors.white, // Text color
      //   fontSize: 16.0, // Font size
      // );
    });
  }

  Future<void> fetchRemoteConfigValues() async {

      try {
        // remoteConfig.fetch();
        // remoteConfig.fetchAndActivate();
        // SplashScreen1.valueServer = remoteConfig.getBool('imagine_server');
        initializeRemote();

    //     Fluttertoast.showToast(
    //   msg: "imagine_server : ${SplashScreen1.valueServer}",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
    //     print('Server Boolean Value: imagine_server : ${SplashScreen1.valueServer}');
      } on Exception catch (e) {
        print('Error fetching remote config: $e');
      }

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
                          'Welcome to \n  Inspire.AI ',
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
                          'Create art with AI ',
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
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () async {

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
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5BC22A),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 18), // Double the vertical padding
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
                            fetchRemoteConfigValues();
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
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
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
