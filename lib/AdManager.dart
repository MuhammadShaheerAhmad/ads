import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'result.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
bool _userEarnedReward = false;
int _numRewardedLoadAttempts = 0;
int maxFailedLoadAttempts = 3;

InterstitialAd? _interstitialAd;
late NativeAd _nativeAd;
class RewardedAdManager {
 static bool isRewardedLoaded = false;
 static RewardedAd? _rewardedAd= null;
 static String   str_sates=str_not_load;
 static String   str_load ="load";
 static String   str_not_load="not_laod";
 static String   str_in_wait="in_wait";
 static String   str_error="Error";
 static String   str_showed="showed";
 static Future <void> createRewardedAd() async {
   if(_rewardedAd == null&&str_sates!=str_in_wait){
       str_sates= str_in_wait;
     //   Fluttertoast.showToast(
     //   msg: "Ad Request ",
     //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
     //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
     //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
     //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
     //   textColor: Colors.white, // Text color
     //   fontSize: 16.0, // Font size
     // );
   await RewardedAd.load(

      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-8920701188575793/5653315848'
          : 'ca-app-pub-8920701188575793/5653315848',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          isRewardedLoaded = true;
          resultPage.isActive = true;
          _numRewardedLoadAttempts = 0;
          print('$ad loaded.');
          _rewardedAd = ad;
          str_sates= str_load;
          _numRewardedLoadAttempts = 0;
    //       Fluttertoast.showToast(
    //   msg: "Ad Loaded ",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
        },
        onAdFailedToLoad: (LoadAdError error){
          isRewardedLoaded = false;
          resultPage.isActive=false;
          // Fluttertoast.showToast(
          //   msg: "Ad Failed ",
          //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
          //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
          //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
          //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
          //   textColor: Colors.white, // Text color
          //   fontSize: 16.0, // Font size
          // );
          print('RewardedAd_failed to load: $error');
          _rewardedAd = null;
          str_sates=str_not_load;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {

            createRewardedAd();
          }
        },
      ),
    );
   }
  }
 // static Future <void> loadInterstitialAd() async {
 //
 //   await InterstitialAd.load(
 //      adUnitId: Platform.isAndroid
 //          ? 'ca-app-pub-3940256099942544/1033173712'
 //          : 'ca-app-pub-3940256099942544/4411468910',
 //      request: AdRequest(),
 //      adLoadCallback: InterstitialAdLoadCallback(
 //        onAdLoaded: (InterstitialAd ad) {
 //          _interstitialAd = ad;
 //          Fluttertoast.showToast(
 //            msg: "Interstitual Ad Loaded",
 //            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
 //            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
 //            timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
 //            backgroundColor: Colors.black.withOpacity(0.7), // Background color
 //            textColor: Colors.white, // Text color
 //            fontSize: 16.0, // Font size
 //          );
 //        },
 //        onAdFailedToLoad: (LoadAdError error) {
 //          print('InterstitialAd failed to load: $error');
 //          Fluttertoast.showToast(
 //            msg: " Interstitual Ad Failed to Load",
 //            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
 //            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
 //            timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
 //            backgroundColor: Colors.black.withOpacity(0.7), // Background color
 //            textColor: Colors.white, // Text color
 //            fontSize: 16.0, // Font size
 //          );
 //          _interstitialAd= null;
 //
 //        },
 //      ),
 //    );
 //  }
 // static Future <void> showInterstitialAd() async {
 //     if (_interstitialAd == null) {
 //      print('InterstitialAd is not loaded yet.');
 //      return;
 //    }
 //
 //      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
 //        onAdDismissedFullScreenContent: (InterstitialAd ad) {
 //          Fluttertoast.showToast(
 //            msg: " Interstitual Ad Showed",
 //            toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
 //            gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
 //            timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
 //            backgroundColor: Colors.black.withOpacity(0.7), // Background color
 //            textColor: Colors.white, // Text color
 //            fontSize: 16.0, // Font size
 //          );
 //          _interstitialAd= null;
 //        // The interstitial ad was dismissed. You can load a new ad here.
 //        loadInterstitialAd();
 //      },
 //    );
 //
 //    _interstitialAd!.show();
 //  }
 static Future <void> showRewardedAd() async {
   if (_rewardedAd == null) {
     print('Warning: attempt to show rewarded before loaded.');
     isRewardedLoaded = false;
     createRewardedAd();
     return;
   }
   _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
     onAdShowedFullScreenContent: (RewardedAd ad) =>
         print('ad onAdShowedFullScreenContent.'),
     onAdDismissedFullScreenContent: (RewardedAd ad) {
       isRewardedLoaded = false;

       print('$ad onAdDismissedFullScreenContent.');
       if(_userEarnedReward) {

         // str_sates=str_showed;
         // ad.dispose();
         // _rewardedAd = null;
         // createRewardedAd();

         print('User earned a reward.');
         // Fluttertoast.showToast(
         //   msg: "user earned",
         //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
         //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
         //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
         //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
         //   textColor: Colors.white, // Text color
         //   fontSize: 16.0, // Font size
         // );

       } else {
         print('User canceled the ad before it finished.');
         // Fluttertoast.showToast(
         //   msg: "user not earned",
         //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
         //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
         //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
         //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
         //   textColor: Colors.white, // Text color
         //   fontSize: 16.0, // Font size
         // );
         // str_sates=str_showed;
         // _rewardedAd = null;
         // createRewardedAd();
       }

       str_sates=str_showed;
       ad.dispose();
       _rewardedAd = null;
       createRewardedAd();


       // Reset the _userEarnedReward flag for the next ad
       _userEarnedReward = false;
       // Fluttertoast.showToast(
       //   msg: "Ad Dismissed",
       //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
       //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
       //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
       //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
       //   textColor: Colors.white, // Text color
       //   fontSize: 16.0, // Font size
       // );

     },
     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
       // Fluttertoast.showToast(
       //   msg: "Ad Failed full Content ",
       //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
       //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
       //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
       //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
       //   textColor: Colors.white, // Text color
       //   fontSize: 16.0, // Font size
       // );
       print('$ad onAdFailedToShowFullScreenContent: $error');
       ad.dispose();
       // createRewardedAd();
       _rewardedAd=null;
       str_sates=str_error;
       isRewardedLoaded = false;
         createRewardedAd();
       FirebaseAnalytics.instance.logEvent(
         name: "REWARDED_AD_ERROR",
         parameters: {"error_message":"Ad failed to load: NETWORK_ERROR"},
       );
       // Debug log
       print("Firebase Analytics event logged: REWARDED_AD_ERROR");
     },
   );

   _rewardedAd!.show(
     onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
       _userEarnedReward = true;
       _rewardedAd = null;
       isRewardedLoaded = false;
       FirebaseAnalytics.instance.logEvent(  //Here is Shown ad log
         name: " REWARDED_AD_SHOWN",
         parameters: {"ad":"REWARDED_AD_SHOWN"},
       );
       // Debug log
       print("Firebase Analytics event logged: REWARDED_AD_SHOWN");
     },
   );

   // _rewardedAd = null;
 }}












class MyController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/7085885195";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}

class MyController1 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/7413188251";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}


class MyController2 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/3473943249";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}


class MyController3 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/2160861572";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}




class MyController4 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/9847779908";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}



class MyController5 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/8534698233";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}




class MyController6 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/7869264077";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}





class MyController7 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/6556182404";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}




class MyController8 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/5243100735";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}




class MyController9 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/2616937394";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}





class MyController10 extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-8920701188575793/8767450767";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}









































