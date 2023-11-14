import 'dart:convert';
import 'package:Inspire.AI/adshow.dart';
import 'package:Inspire.AI/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'main.dart';
import 'dart:math';
import 'dart:async';
// import 'package:provider/provider.dart';
import 'AdManager.dart';
import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'splash.dart';

class MyScrollScreen extends StatefulWidget {

  @override
  State<MyScrollScreen> createState() => _MyScrollScreenState();
}
class _MyScrollScreenState extends State<MyScrollScreen> {

  bool adWidgetAdded = true; // Add this flag
  var myContr = Get.put(MyController());

  final ScrollController _scrollController = ScrollController();

  bool _isButtonActive = true;
  final InternetConnectionChecker customInstance =
  InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 1),
    checkInterval: const Duration(seconds: 5),
  );
  @override
  void initState() {
    adShow.createBannerAd();
    myContr.loadAd();
    super.initState();
    // _createRewardedAd();
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

              // Future<void>.delayed(const Duration(seconds: 30));
              RewardedAdManager.createRewardedAd();

            // Fluttertoast.showToast(
            //   msg: " Internet Connection",
            //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
            //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
            //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
            //   textColor: Colors.white, // Text color
            //   fontSize: 16.0, // Font size
            // );
            net = true;
            break;
          case InternetConnectionStatus.disconnected:
          // ignore: avoid_print
            net = false;
            print('You are disconnected from the internet.');

            // netDialog.showNetDialog(context);
            // Fluttertoast.showToast(
            //   msg: "Please Check Your Internet Connection",
            //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
            //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
            //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
            //   textColor: Colors.white, // Text color
            //   fontSize: 16.0, // Font size
            // );
            break;
        }
      },
    );

    // close listener after 30 seconds, so the program doesn't run forever
    await Future<void>.delayed(const Duration(seconds: 5));
    await listener.cancel();

  }

  // Initialize a flag to track reward status


  @override
  void dispose() {

    myContr.dispose();

    super.dispose();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AD Manager",
          style: TextStyle(
            fontFamily: 'FontMain',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Text at the top



// Centered Buttons with Spacing
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double
                        .infinity, // Ensure the button takes the full available width
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        RewardedAdManager.showInterstitialAd();
                        // Handle button press
                        _openBottomSheet(context);
                        FirebaseAnalytics.instance.logEvent(
                          //Inspiration Clicked log
                          name: "STYLES_CLICKED",
                          parameters: {"Style": "Style  Clicked"},
                        );
                        // Debug log
                        print(
                            "Firebase Analytics event logged: STYLES_CLICKED");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 24), // Double the vertical padding
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              Center(
                                child: Text(
                                  "Interstitual Ads",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 25,
                                    fontFamily:'FontRegular' ,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_outlined),
                              SizedBox(width: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double
                        .infinity,
                    // Ensure the button takes the full available width
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {


                        RewardedAdManager.showRewardedAd();
                        // RewardedAdManager.showInterstitialAd();
                        _openSheet(context); // Handle button press
                        FirebaseAnalytics.instance.logEvent(
                          //Inspiration Clicked log
                          name: "ADVANCE_SETTINGS_CLICKED",
                          parameters: {"setting": "Advance settings  Clicked"},
                        );
                        // Debug log
                        print(
                            "Firebase Analytics event logged: ADVANCE_SETTINGS_CLICKED");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 24), // Double the vertical padding
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Rewarded Ads',
                              textAlign: TextAlign.center, // Center the text
                              style: TextStyle(
                                fontFamily: 'FontMain',
                                fontSize: 18,
                              ), // Adjust text style as needed
                            ),
                          ),
                          Icon(Icons.arrow_forward_outlined),
                          SizedBox(width: 14),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 70,

                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: _isButtonActive
                          ? () async {





                        RewardedAdManager.showRewardedAd();

                        await execute(InternetConnectionChecker());
                        await execute(customInstance);
                      }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.disabled)) {
                            // Button is disabled, make it green
                            return Colors.white38 ??
                                Colors.blueGrey; // Use a default color if null
                          } else {
                            // Button is active, make it grey
                            return Color(
                                0xFF5BC22A); // Use a default color if null
                          }
                        }),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          SizedBox(
                              width:
                              7), // Adjust the spacing between the image and text
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  "AD Manager",
                                  style: TextStyle(
                                    color: Colors.black87, // Set the color of "Generate" to orange
                                    fontSize:
                                    20, // Adjust the font size as needed
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text("Watch an Ad",
                                    style: TextStyle(
                                      color: Colors
                                          .black54, // Set the color of "Watch an Ad" to white
                                      fontSize:
                                      16, // Adjust the font size as needed
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text saying "Get Inspired"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Get Inspired by native",
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr.isAdLoaded.value
                          ? ConstrainedBox(

                          constraints: const BoxConstraints(
                            maxHeight: 390,
                            minHeight: 390,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AdWidget(ad: myContr.nativeAd!),
                          ))
                          : const SizedBox(),
                    )),
                  ],
                ),
                // Positioned(
                //   top: 1, // Adjust this value to position the text vertically
                //   left: 6, // Adjust this value to position the text horizontally
                //   child: Container(
                //     width: 48,
                //     height: 28,
                //     decoration: BoxDecoration(
                //       color: Colors.redAccent.withOpacity(0.5),
                //       borderRadius: BorderRadius.circular(16.0),
                //       border: Border.all(
                //         color: Colors.redAccent,
                //         width: 2.0,
                //       ),
                //     ),
                //     padding: EdgeInsets.all(1),
                //     child: Center(
                //       child: ClipRRect(
                //         borderRadius: BorderRadius.circular(10.0),
                //         child: Text(
                //           'AD',
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),


          ],
        ),
      ),
    );
  }

}

// sendDataToFunctionInFile2();
void _openBottomSheet(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => adShow()),
  );

}
void _openSheet(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => adShow()),
  );
}
