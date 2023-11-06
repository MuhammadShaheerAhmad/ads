// bottom_sheet.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'MyScrollScreen.dart';
import 'desc.dart';
import 'result.dart';
import 'AdManager.dart';
import 'bottom.dart';
import 'sheet.dart';
import 'api.dart';

class ads extends StatefulWidget {

  @override
  State<ads> createState() => _adsState();
}

class _adsState extends State<ads> {
  var myContr = Get.put(MyController());
  var myContr1 = Get.put(MyController1());
  var myContr2 = Get.put(MyController2());
  var myContr3 = Get.put(MyController3());
  var myContr4 = Get.put(MyController4());
  var myContr5 = Get.put(MyController5());
  var myContr6 = Get.put(MyController6());
  var myContr7 = Get.put(MyController7());
  var myContr8 = Get.put(MyController8());
  var myContr9 = Get.put(MyController9());
  var myContr10 = Get.put(MyController10());
  @override
  void initState() {
    // RewardedAdManager.createRewardedAd();
    myContr.loadAd();
    myContr1.loadAd();
    myContr2.loadAd();
    myContr3.loadAd();
    myContr4.loadAd();
    myContr5.loadAd();
    myContr6.loadAd();
    myContr7.loadAd();
    myContr8.loadAd();
    myContr9.loadAd();
    myContr10.loadAd();
    // RewardedAdManager.loadInterstitialAd();
    super.initState();

    // _createRewardedAd();
  }
  @override
  void didChangeDependancies() {
    super.didChangeDependencies();
    // loadRewarded();
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return     Stack(
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
              child: myContr10.isAdLoaded.value
                  ? ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    minHeight: 100,
                  ),
                  child: AdWidget(ad: myContr10.nativeAd!))
                  : const SizedBox(),
            )),
          ],
        ),
        Positioned(
          top: 20, // Adjust this value to position the text vertically
          left: 4, // Adjust this value to position the text horizontally
          child: Container(
            width: 48,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.redAccent,
                width: 2.0,
              ),
            ),
            padding: EdgeInsets.all(2),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Text(
                  'AD',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ) ;
  }


}