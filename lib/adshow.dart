
import 'dart:io';
import 'package:Inspire.AI/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'AdManager.dart';


class adShow extends StatefulWidget {
 static BannerAd? _bannerAd;
static bool lloaded = false;
  static Future <void> createBannerAd() async{
    Fluttertoast.showToast(
      msg: "Banner Request ",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      backgroundColor: Colors.black.withOpacity(0.7), // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Font size
    );
    String adUnitId = 'ca-app-pub-3940256099942544/6300978111';

    // Create a BannerAd instance
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          lloaded=true;
          Fluttertoast.showToast(
            msg: "Banner loaded ",
            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
            backgroundColor: Colors.black.withOpacity(0.7), // Background color
            textColor: Colors.white, // Text color
            fontSize: 16.0, // Font size
          );
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          lloaded=false;
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          Fluttertoast.showToast(
            msg: "Banner failed to load ",
            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
            timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
            backgroundColor: Colors.black.withOpacity(0.7), // Background color
            textColor: Colors.white, // Text color
            fontSize: 16.0, // Font size
          );
          ad.dispose();
        },
      ),

    );


    // Load the banner ad
    _bannerAd?.load();



  }

  @override
  State<adShow> createState() => _MyScrollScreenState();

  static AdListener() {}
}
class _MyScrollScreenState extends State<adShow> {



  @override
  void initState() {

    // Replace the ad unit ID with your own

    super.initState();
    // _createRewardedAd();
  }


  @override
  void dispose() {
    adShow.lloaded=false;
    // adShow.createBannerAd();
    super.dispose();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Banner is Here",
          style: TextStyle(
            fontFamily: 'FontMain',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large Text at the top



// Centered Buttons with Spacing
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
       Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [
                            Center(
                              child: Text(
                                " Ads",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 25,
                                  fontFamily:'FontRegular' ,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),


                            Container(

 child: Stack(
   children: [
     if (adShow._bannerAd != null)
       Align(
         alignment: Alignment.bottomCenter,
         child: SafeArea(
           child: SizedBox(
             width: adShow._bannerAd!.size.width.toDouble(),
             height: adShow._bannerAd!.size.height.toDouble(),
             child: AdWidget(ad: adShow._bannerAd!),
           ),
         ),
       )
   ],
 )
    )
                          ],
                        ),
                      ],
                    ),
                 ] ),
                ),

              ],
            ),



        );

  }


}

