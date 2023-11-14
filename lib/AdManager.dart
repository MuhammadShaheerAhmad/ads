import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
bool _userEarnedReward = false;

int _numRewardedLoadAttempts = 0;
int maxFailedLoadAttempts = 3;
InterstitialAd? _interstitialAd;
late NativeAd _nativeAd;
class RewardedAdManager {
  static bool isRewardedLoaded = false;
  static RewardedAd? _rewardedAd = null;
  static String str_sates = str_not_load;
  static String str_load = "load";
  static String str_not_load = "not_laod";
  static String str_in_wait = "in_wait";
  static String str_error = "Error";
  static String str_showed = "showed";



  static Future <void> createRewardedAd() async {
    if (_rewardedAd == null && str_sates != str_in_wait) {
      str_sates = str_in_wait;
        Fluttertoast.showToast(
        msg: "Rewarded Ad Request ",
        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
        timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
        backgroundColor: Colors.black.withOpacity(0.7), // Background color
        textColor: Colors.white, // Text color
        fontSize: 16.0, // Font size
      );
      await RewardedAd.load(

        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/5224354917'  // Android test ad unit ID
            : 'ca-app-pub-3940256099942544/1712485313',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            isRewardedLoaded = true;
            _numRewardedLoadAttempts = 0;
            print('$ad loaded.');
            _rewardedAd = ad;
            str_sates = str_load;
            _numRewardedLoadAttempts = 0;
                  Fluttertoast.showToast(
              msg: "Rewarded Ad Loaded ",
              toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
              gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
              timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
              backgroundColor: Colors.black.withOpacity(0.7), // Background color
              textColor: Colors.white, // Text color
              fontSize: 16.0, // Font size
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            isRewardedLoaded = false;
            Fluttertoast.showToast(
              msg: "Rewarded Ad Failed ",
              toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
              gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
              timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
              backgroundColor: Colors.black.withOpacity(0.7), // Background color
              textColor: Colors.white, // Text color
              fontSize: 16.0, // Font size
            );
            print('RewardedAd_failed to load: $error');
            _rewardedAd = null;
            str_sates = str_not_load;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
            }
            Future<void>.delayed(const Duration(seconds: 30));
          },

        ),
      );
    }
  }

  static Future <void> showRewardedAd() async {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      isRewardedLoaded = false;
      createRewardedAd();
      return;
    }
    AppOpenAdManager._isShowingAd = true;
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        isRewardedLoaded = false;
        AppOpenAdManager._isShowingAd = false;
        print('$ad onAdDismissedFullScreenContent.');
        if (_userEarnedReward) {
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

        str_sates = str_showed;
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
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
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
        _rewardedAd = null;
        str_sates = str_error;
        isRewardedLoaded = false;
        createRewardedAd();
        FirebaseAnalytics.instance.logEvent(
          name: "REWARDED_AD_ERROR",
          parameters: {"error_message": "Ad failed to load: NETWORK_ERROR"},
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
        FirebaseAnalytics.instance.logEvent( //Here is Shown ad log
          name: " REWARDED_AD_SHOWN",
          parameters: {"ad": "REWARDED_AD_SHOWN"},
        );
        // Debug log
        print("Firebase Analytics event logged: REWARDED_AD_SHOWN");
      },
    );

    // _rewardedAd = null;
  }

  static Future <void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          Fluttertoast.showToast(
            msg: "Interstitual Ad Loaded",
            toastLength: Toast.LENGTH_SHORT,
            // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM,
            // Top, Center, Bottom
            timeInSecForIosWeb: 1,
            // iOS and web specific (in seconds)
            backgroundColor: Colors.black.withOpacity(0.7),
            // Background color
            textColor: Colors.white,
            // Text color
            fontSize: 16.0, // Font size
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          Fluttertoast.showToast(
            msg: " Interstitual Ad Failed to Load",
            toastLength: Toast.LENGTH_SHORT,
            // or Toast.LENGTH_LONG
            gravity: ToastGravity.BOTTOM,
            // Top, Center, Bottom
            timeInSecForIosWeb: 1,
            // iOS and web specific (in seconds)
            backgroundColor: Colors.black.withOpacity(0.7),
            // Background color
            textColor: Colors.white,
            // Text color
            fontSize: 16.0, // Font size
          );
          _interstitialAd = null;
        },
      ),
    );
  }

  static Future <void> showInterstitialAd() async {
    if (_interstitialAd == null) {
      print('InterstitialAd is not loaded yet.');
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        Fluttertoast.showToast(
          msg: " Interstitual Ad Showed",
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Top, Center, Bottom
          timeInSecForIosWeb: 1,
          // iOS and web specific (in seconds)
          backgroundColor: Colors.black.withOpacity(0.7),
          // Background color
          textColor: Colors.white,
          // Text color
          fontSize: 16.0, // Font size
        );
        _interstitialAd = null;
        // The interstitial ad was dismissed. You can load a new ad here.
        loadInterstitialAd();
      },
    );

    _interstitialAd!.show();
  }




}
class AppOpenAdManager {
  static  bool firstOpen = false;
  static  bool secOpen = false;
  static  late AppOpenAdManager appOpenAdManager;
  AppOpenAdManager() {
    Future.delayed(const Duration(seconds: 2), () {
      loadAd();
    });

  }

  static String adUnitId =
      'ca-app-pub-3940256099942544/3419835294';

  static AppOpenAd? _appOpenAd;
  static bool _isShowingAd = false;

  /// Load an AppOpenAd.
  static Future <void> loadAd() async {
    AppOpenAd.load(
      adUnitId: adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          // Fluttertoast.showToast(
          //   msg: "open ad loaded",
          //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
          //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
          //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
          //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
          //   textColor: Colors.white, // Text color
          //   fontSize: 16.0, // Font size
          // );
          if(!firstOpen){
            showAppopen1();
          }

        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );

  }

  /// Whether an ad is available to be shown.
  static bool get isAdAvailable {
    return _appOpenAd != null;
  }
  static Future <void> showAdIfAvailable() async {
    if (!isAdAvailable) {
      loadAd();
      return;
    }
    if (_isShowingAd) {
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }

  static Future <void> showAppopen1() async {
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        firstOpen = true;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor{
   AppOpenAdManager appOpenAdManager;
  AppLifecycleReactor({required this.appOpenAdManager});
  void listenToAppStateChanges(){
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }
  void _onAppStateChanged(AppState appState) {

    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      AppOpenAdManager.showAdIfAvailable();
    }
  }
}
class MyController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-3940256099942544/2247696110";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Native_Ad Loaded");

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

    super.dispose();
  }
}












