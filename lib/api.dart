import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'result.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'image.dart';
import 'AdManager.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show File;
import 'dart:convert';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'MyScrollScreen.dart';
import 'edit.dart';
import 'custom_dialog.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'splash.dart';

class Api {
  static bool isString = true;
  static File? Fileimg;
  static String imageURL = "";
  static String responseImg = "";
  static var requestnum = 0;
  static var responsenum = 0;
  static bool isErr=false;
  static Future<String> createImage() async {
    isErr=false;
    const JWT_SECRET = "8SX2MszgRGvQcVd7";
    final payload = {
      'iss': 'InpireAI',
      'exp': DateTime.now().millisecondsSinceEpoch +
          3600 * 1000, // expiration date, required, in ms, absolute to 1/1/1970
      'additional': 'payload',
      'algo': 'JWTAlgorithm.HS256',
    };

// Create a JWT object with the payload and the algorithm
    final jwt = JWT(payload);

// Sign the JWT object with the secret and get the token string
    final token = jwt.sign(SecretKey(JWT_SECRET));

// Print the token or use it in your app
    print('Signed token: $token');

    requestnum = requestnum + 1;
    // Fluttertoast.showToast(
    //   msg: "iN FUNCTION $requestnum",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
    const String url =
        "https://middleware.businesconsulting.com/api/easyart/create-image-auth"; //https://middleware.businesconsulting.com/api/easyart/create-image-auth

    Map<String, dynamic> aiImageData = {
      "version_name": "1.2.29",
      "version_code": "31",
      "build_id": "flutter",
      "access_token": token,
      "country_code": "GB",
      "enhance_prompt": "yes",
      "fcm_token": "ExponentPushToken[oXkUkQNQXQvM-qEzmeuMX-]",
      "guidance_scale": 7.5,
      "height": "512",
      "is_style_selected": false,
      "key": "-",
      "model_id": "midjourney",
      "negative_prompt": "",
      "num_inference_steps": "20",
      "prompt": resultPage.prompt,
      "safety_checker": "no",
      "samples": "1",
      "seed": -1,
      "selectedStyleByUser": null,
      "track_id": "",
      "typedText": "Beatrix Potter style watercolor.",
      "webhook": "",
      "width": "512",
      "isImagine": isImagine,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(aiImageData),
    );
    FirebaseAnalytics.instance.logEvent(
      //Inspiration Clicked log
      name: "SERVER_REQUEST",
      parameters: {"Request_meter": "$requestnum"},
    );
    // Debug log
    print("SERVER_REQUEST : $requestnum");
    // Fluttertoast.showToast(
    //   msg: "imagine_server: ${SplashScreen1.valueServer}",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("response_check:$responseData");
      if(responseData['image'] is String)  {
        // Fluttertoast.showToast(
        //   msg: "Response: Imagine",
        //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
        //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
        //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
        //   textColor: Colors.white, // Text color
        //   fontSize: 16.0, // Font size
        // );
        isString=true;
        print("$isString");


        String imageUrl = responseData['image'];
        print("Response Body: $imageUrl");
// Update the state with the image URL
        responseImg = "https://api-gaminators.kasparholdings.com" + imageUrl;
        print("Response Body: $responseImg");
        resultPage.imgDisplay =
            "https://api-gaminators.kasparholdings.com" + imageUrl;
        print("response_check:Imagine $responseImg");
        FirebaseAnalytics.instance.logEvent(
          //Inspiration Clicked log
          name: "Image_Generated",
          parameters: {"image_generated": "imagine"},
        );
        // Debug log
        print("Firebase Analytics event logged: Image_Generated");

      }
      // if(responseData['images'][0] is Array)
      else {
        // Fluttertoast.showToast(
        //   msg: "Response: Inspire",
        //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
        //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
        //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
        //   textColor: Colors.white, // Text color
        //   fontSize: 16.0, // Font size
        // );
        isString=false;
        // print("response_check:Inspire $responseData");
        // FirebaseAnalytics.instance.logEvent(
        //   //Inspiration Clicked log
        //   name: "Inspire_Request",
        //   parameters: {"Inspire_Request": "inspire"},
        // );
        // Fluttertoast.showToast(
        //   msg: "Image_Request :Inspire",
        //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
        //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
        //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
        //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
        //   textColor: Colors.white, // Text color
        //   fontSize: 16.0, // Font size
        // );
        // // responsenum = responsenum + 1;
        // FirebaseAnalytics.instance.logEvent(
        //   //Inspiration Clicked log
        //   name: "SERVER_RESPONSE :200  ::$responsenum",
        //   parameters: {"Response_meter": "$responsenum"},
        // );
        // // Debug log
        print("is String:$isString");

        imageURL = responseData['images'][0];
        responseImg = Base64Decoder().convert(imageURL).toString();
        print("response_check:inspire $responseImg");
        print("SERVER_RESPONSE :200 $responseImg::$responsenum");

// Fluttertoast.showToast(
//   msg: "Image URL: $imageURL",
//   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//   backgroundColor: Colors.black.withOpacity(0.7), // Background color
//   textColor: Colors.white, // Text color
//   fontSize: 16.0, // Font size
// );
        print("DUCK, ImageGeneration, Success");
// print("Image URL: $imageURL");
        print("Image URL: Generated");
        FirebaseAnalytics.instance.logEvent(
          //Inspiration Clicked log
          name: "Image_Generated",
          parameters: {"image_generated": "inspire"},
        );
        // Debug log
        print("Firebase Analytics event logged: Image_Generated");

      }

    }
    if (response.statusCode != 200){
      isErr=true;
      // Fluttertoast.showToast(
      //   msg: "Image_Error ",
      //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
      //   textColor: Colors.white, // Text color
      //   fontSize: 16.0, // Font size
      // );
      // responsenum = responsenum + 1;
      FirebaseAnalytics.instance.logEvent(
        //Inspiration Clicked log
        name: "SERVER_RESPONSE :Error  ::Error",
        parameters: {"Response_meter": "Error"},
      );
    }


    return responseImg;
  }

}



























//   static Future<String> imaginecreateImage() async {
//     requestnum = requestnum + 1;
//     Fluttertoast.showToast(
//       msg: "iN FUNCTION Imagine $requestnum",
//       toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );
//     Fluttertoast.showToast(
//       msg: " ${MyInputPage.inputData}",
//       toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );
//     const String url =
//         "https://middleware.businesconsulting.com/api/easyart/create-image-imagine";
//
//     Map<String, dynamic> aiImagineData = {
//       "negative_prompt": "blurry",
//       "width": "512",
//       "height": "512",
//       "model_id": "",
//       "samples": "",
//       "num_inference_steps": "41",
//       "safety_checker": "no",
//       "enhance_prompt": "yes",
//       "seed": null,
//       "guidance_scale": 7.5,
//       "webhook": null,
//       "track_id": null,
//       "prompt": MyInputPage.inputData,
//     };
//
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         "Content-Type": "application/json",
//         "charset": "utf-8",
//       },
//       body: jsonEncode(aiImagineData),
//     );
//     FirebaseAnalytics.instance.logEvent(
//       //Inspiration Clicked log
//       name: "SERVER_REQUEST",
//       parameters: {"Request_meter": "$requestnum"},
//     );
//     // Debug log
//     print("SERVER_REQUEST : $requestnum");
//     Fluttertoast.showToast(
//       msg: "Image_Request",
//       toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       textColor: Colors.white, // Text color
//       fontSize: 16.0, // Font size
//     );
//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(
//         msg: "Image_Generated",
//         toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//         gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//         timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//         backgroundColor: Colors.black.withOpacity(0.7), // Background color
//         textColor: Colors.white, // Text color
//         fontSize: 16.0, // Font size
//       );
//       responsenum = responsenum + 1;
//       FirebaseAnalytics.instance.logEvent(
//         //Inspiration Clicked log
//         name: "SERVER_RESPONSE :200  ::$responsenum",
//         parameters: {"Response_meter": "$responsenum"},
//       );
//       // Debug log
//       print("SERVER_RESPONSE :200 ::$responsenum");
//       // Get the image data from the response body as bytes
//       final imageData = response.bodyBytes;
// // Save the image data to a file in the device's temporary directory
//       final directory = await getTemporaryDirectory();
//       final filePath = "${directory.path}/image.png";
//       final file = File(filePath);
//       await file.writeAsBytes(imageData);
//       Fileimg = file;
//       responseImg = filePath;
// // Print the file path or show it in the UI
//       print("FILE_PATH: $filePath");
// //       Map<String, dynamic> responseBody = jsonDecode(response.body);
// // // Get the image URL from the response body
// //       imageURL = responseBody['images'];
// //       print("Response Body: $imageURL");
// //
// //       responseImg=Base64Decoder().convert(imageURL).toString();
//       // Fluttertoast.showToast(
//       //   msg: "Image URL: $imageURL",
//       //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//       //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//       //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//       //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
//       //   textColor: Colors.white, // Text color
//       //   fontSize: 16.0, // Font size
//       // );
//       print("DUCK, ImageGeneration, Success");
//       // print("Image URL: $imageURL");
//       print("Image URL: Generated:: $responseImg");
//     } else {
//       responsenum = responsenum + 1;
//       // Handle error if the request was not successful
//       print("Image_Error: ${response.statusCode}");
//       FirebaseAnalytics.instance.logEvent(
//         //Inspiration Clicked log
//         name: "SERVER_RESPONSE :ERROR",
//         parameters: {"Response_meter": "$responsenum"},
//       );
//       // Debug log
//       print("SERVER_RESPONSE :ERROR ${response.statusCode} ::$responsenum :: ");
//       Fluttertoast.showToast(
//         msg: "Image_Error",
//         toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
//         gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
//         timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
//         backgroundColor: Colors.black.withOpacity(0.7), // Background color
//         textColor: Colors.white, // Text color
//         fontSize: 16.0, // Font size
//       );
//     }
//     resultPage.refresh = true;
//
//     return responseImg;
//   }