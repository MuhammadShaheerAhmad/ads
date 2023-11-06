package com.imagegenerator.ai.art.avatar

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity


class MainActivity : FlutterActivity() {
//    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine?) {
//        super.configureFlutterEngine(flutterEngine)
//
//        // Register your MediationNetworkExtrasProvider to provide network extras to ad requests.
//        GoogleMobileAdsPlugin.registerMediationNetworkExtrasProvider(
//            flutterEngine, MyMediationNetworkExtrasProvider()
//        )
//    }

    }
//
//// Register a MediationNetworkExtrasProvider with the plugin.
//internal class MyMediationNetworkExtrasProvider : MediationNetworkExtrasProvider {
//    fun getMediationExtras(
//        adUnitId: String?, @Nullable identifier: String?
//    ): Map<Class<out MediationExtrasReceiver?>, Bundle> {
//        // This example passes extras to the AppLovin adapter.
//        // This method is called with the ad unit of the associated ad request, and
//        // an optional string parameter which comes from the dart ad request object.
//        val appLovinBundle: Bundle = Builder().setMuteAudio(true).build()
//        val extras: MutableMap<Class<out MediationExtrasReceiver?>, Bundle> =
//            HashMap<Class<out MediationExtrasReceiver?>, Bundle>()
//        extras[ApplovinAdapter::class.java] = appLovinBundle
//        // Note: You can pass extras to multiple adapters by adding more entries.
//        return extras
//    }
//}