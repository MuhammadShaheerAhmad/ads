import 'dart:math';
import 'package:Inspire.AI/splash.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
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
import 'api.dart';
// manageExternalStorage

Future<bool> _requestPermission(Permission permission) async {
  AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
  if (build.version.sdkInt >= 33) {
    var re = await Permission.photos.request();
    // Map<Permission, PermissionStatus> status = await [
    //   Permission.photos,
    //   Permission.bluetoothConnect,
    //   Permission.bluetoothAdvertise,
    //   Permission.bluetooth,
    //   Permission.bluetoothScan,
    // ].request();
    if (re.isGranted) {
      return true;
    } else {
      return false;
    }
  } else {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
bool condition = false;
bool isImagine=SplashScreen1.valueServer!;
class resultPage extends StatefulWidget {
   var is_enter=false;
   static String? prompt = "";
   static String? sVal = "27";
   static String imgDisplay = "";
   static String progressSituation = "Processing....";
   static bool isActive = false;


   static Future<void> valueT(asd) async {
    sVal = asd;

    // Fluttertoast.showToast(
    //   msg: " value Received",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
    print('Button pressed with text: ${asd}');
  }

  static Future<void> imgT(query) async {
    prompt = query;
    print('Button pressed with text: ${query}');
    MyInputPage.inputData = query;


  }

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> {
  double _progress = 0;
  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible:
      false, // Prevent users from closing the dialog by tapping outside
      builder: (BuildContext context) {
        return ProgressDialog(); // Show the ProgressDialog widget
      },
    );
    if (_progress == 0) {
      resultPage.progressSituation = " Generating....";
    } else if (_progress < 100) {
      resultPage.progressSituation = " In Process....";
    } else if (_progress == 100) {
      resultPage.progressSituation = "Generating.....";
    }
    // Simulate progress using a Timer
    Timer(Duration(seconds: 20), () {
      Navigator.of(context).pop();
      setState(
              () {}); // Close the dialog when progress is complete// Close the dialog when progress is complete
    });
  }

  void _startProgress() {
    const int totalSeconds = 10;
    const int updateInterval = 1000;
    Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      if (_progress < 100) {
        resultPage.progressSituation = " Generating....";
        if (mounted) {
          setState(() {
            _progress += (updateInterval / (totalSeconds * 1000)) * 100;
          });
        }
      } else {
        resultPage.progressSituation = "Generating....";
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startProgress();
    // Future.delayed(Duration(milliseconds: 300), () {
    //   setState(() {
    //     // _ProgressButtonState.getImageUrl();
    //     // _ProgressButtonState.createImage();
    //
    //   });
    // });
    // Fluttertoast.showToast(
    //   msg: "imagine_server: ${SplashScreen1.valueServer}",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ProgressButton(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: resultPage(),
  ));
}

class ProgressDialog extends StatefulWidget {
  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _startProgress();

  }

  void _startProgress() {


    const int totalSeconds = 10;
    const int updateInterval = 1000;
    Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      if (_progress < 100) {
        if (mounted) {
          setState(() {
            _progress += (updateInterval / (totalSeconds * 1000)) * 100;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Color(0xFF5BC22A), width: 3.5),
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 25.0),
            Text(resultPage.progressSituation,
                style: TextStyle(fontSize: 25.0, color: Colors.white)),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LinearProgressIndicator(
                minHeight: 12,
                value: _progress / 100,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF5BC22A),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ProgressButton extends StatefulWidget {
  static var is_enter=false;



  @override
  _ProgressButtonState createState() => _ProgressButtonState();
  bool run = false;
}

class _ProgressButtonState extends State<ProgressButton> {
  bool isLoading = true;
  //////////////////////////////////////////
 void  _isLoaded() {
    String one="";

    Future.delayed(Duration(milliseconds: 3800), () {
      // if( resultPage.refresh= true){
      //   resultPage.refresh= false;
      //   print("po response ");

      if(Api.responseImg=="" ){
        one="one";
        resultPage.isActive=true;
        _isLoaded();
      }  else{
        one="two";
        condition = true;
        setState(() {

        });

        if(RewardedAdManager.isRewardedLoaded==true){
          resultPage.isActive=true;
        }
        // _isLoaded();
      }
    });

  }
  void _isNotLoaded(){
    Future.delayed(Duration(milliseconds: 105800), () {

      if(Api.responseImg==""){
        // _showCardDialog(context);
      }
    });
  }
  //////////////////////////////////////////////
  Future<void> _showCardDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            color: Colors.green,
            width: 300, // Set the desired width
            height: 400, // Set the desired height
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child :Text(
                  'Sorry!...Server is Busy...Try Again after some Time.',
                  style: TextStyle(
                    color: Colors
                        .black, // Set the color of the text to black
                    fontSize: 28, // Adjust the font size as needed
                  ),
                ),),
                Container(
                  width: double
                      .infinity,
                  height: 70,// Ensure the button takes the full available width
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  // margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button click logic here
                      Navigator.of(context)
                          .pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5BC22A),// Set button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Set rounded border
                      ),
                      // Increase button width
                    ),
                    child: Text('Close'  , style: TextStyle(fontSize: 18,
                      color: Colors.black,
                    ),),
                  ),
                ),
              ],
            )
          ),
        );



      },
    );

  }

  /////////////////////////////////////////////
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {

    super.initState();

    Api.createImage();
    _isLoaded();
    _isNotLoaded();

  }

  @override
  void dispose() {
    Api.imageURL="";
    Api.responseImg="";
    FirebaseAnalytics.instance.logEvent(
      //Inspiration Clicked log
      name: "BACK_BUTTON_PRESSED",
      parameters: {"Back_btn": "Back press"},
    );
    // Debug log
    print("Firebase Analytics event logged: BACK_BUTTON_PRESSED");
    resultPage.isActive=false;
    super.dispose();
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible:
      false, // Prevent users from closing the dialog by tapping outside
      builder: (BuildContext context) {
        return ProgressDialog(); // Show the ProgressDialog widget
      },
    );
    // Simulate progress using a Timer
    Timer(Duration(seconds: 20), () {
      Navigator.of(context).pop();
      setState(
              () {}); // Close the dialog when progress is complete// Close the dialog when progress is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
setState(() {

});
                // Navigate to another screen when the image is tapped
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ImageScreen(),
                ));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.47,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: // Check if an image is received.
                    Container(
                        child: Container(
                          child: Api.isString  ?
                          Image.network(
                            Api.responseImg ?? '', // Use the imgUrl variable as the image URL
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // When the image is fully loaded, display it
                              } else {
                                return Center(
                                  child: CircularProgressIndicator( // Display a loading indicator while the image is loading

                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              // Display an error message or placeholder image when there's an error
                               return
                                 Api.isErr ? Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM-xIqDK8Fa9sOi6lKpap-0wjaZYoDcPiZutbtKKrutzeLcGjos63HaoQTV7V0E4GMpH8&usqp=CAU")

                                     : Center(child: CircularProgressIndicator());

                            },
                          )
                          : condition
                              ? InteractiveViewer(
                            maxScale: 5.0,
                            minScale: 0.01,
                            child: Image.memory(Base64Decoder().convert(Api.imageURL)),


                          ) // Display Widget 1 if condition is true
                          :Api.isErr ? Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM-xIqDK8Fa9sOi6lKpap-0wjaZYoDcPiZutbtKKrutzeLcGjos63HaoQTV7V0E4GMpH8&usqp=CAU")

                              : Center(child: CircularProgressIndicator())
                        ))),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await _requestPermission(Permission.storage) ==
                                true) {
                              print("Permission is granted");
                              downloadAndSaveImageToGallery(Api.responseImg);
                              Fluttertoast.showToast(
                                msg: "Image Saved!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.green[300],
                                textColor: Colors.black,
                                fontSize: 16.0,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Permission not Granted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.7),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              print("Permission is not granted");
                            }

                            FirebaseAnalytics.instance.logEvent(
                              name: "DOWNLOAD_CLICKED",
                              parameters: {"Download_btn": "Downloading Image"},
                            );
                            print(
                                "Firebase Analytics event logged: DOWNLOAD_CLICKED");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.black, width: 1),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 18), // Double the vertical padding
                          ),
                          child: Icon(Icons.file_download, color: Colors.white),
                        )),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: resultPage.isActive
                    ? () async {
                  Api.responseImg="";
                  // getImageUrl();
                  if(ProgressButton.is_enter==false){
                     Api.createImage();
                    // is_enter=true;
                    // Fluttertoast.showToast(
                    //   msg: "condition check",
                    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
                    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
                    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
                    //   textColor: Colors.white, // Text color
                    //   fontSize: 16.0, // Font size
                    // );

                     _isLoaded();
                     _isNotLoaded();
                  }
                  RewardedAdManager.showRewardedAd();
                  // resultPage.progressSituation = "Re-Generating.....";
                  _showProgressDialog();
                  FirebaseAnalytics.instance.logEvent(
                    //Inspiration Clicked log
                    name: "REGENERATE_CLICKED",
                    parameters: {"Regenerate_btn": "Regenerating Image"},
                  );
                  // Debug log
                  print(
                      "Firebase Analytics event logged: REGENERATE_CLICKED");

                  //
                  // Future.delayed(Duration(milliseconds: 4900), () {
                  //   is_enter=false;
                  // });


                }
                    : null,
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      // Button is disabled, make it green
                      return Colors.blueGrey[800] ??
                          Colors.blueGrey; // Use a default color if null
                    } else {
                      // Button is active, make it grey
                      return Color(0xFF5BC22A); // Use a default color if null
                    }
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/img/AD.png', // Replace with the path to your image
                          width:
                          22, // Adjust the width of the image as needed
                          height:
                          22, // Adjust the height of the image as needed
                          color: Colors
                              .black, // Set the color of the image to black
                        ),
                        Positioned(
                          top:
                          12.0, // Adjust the value to move the text down as needed
                          child: Container(
                            color: Colors
                                .green, // Set the background color to green
                            child: Text(
                              'Ad',
                              style: TextStyle(
                                color: Colors
                                    .black, // Set the color of the text to black
                                fontSize:
                                10, // Adjust the font size as needed
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        width:
                        7), // Adjust the spacing between the image and text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            "Generate",
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
          ),
          Expanded(
            flex: 3,
            child: Center(
              child:
              GestureDetector(
                onTap: () {
                  Api.responseImg="";
                  _isLoaded();
                  _isNotLoaded();
                  // Navigate to another screen when the image is tapped

                  _openSheet(context);

                  // Future.delayed(Duration(milliseconds: 105800), () {
                  //   Api.responseImg="";
                  //   _isLoaded();
                  //   _isNotLoaded();
                  // });
                },
                child: Container(
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // TextField

                      Container(

                        child: Center(
                          child: Image.asset(
                            'assets/img/edit.PNG', // Replace with your image asset path
                            width: 200, // Adjust the width as needed
                            height: 90, // Adjust the height as needed
                          ),
                        ),

                      ),
                      Padding(
                          padding: const EdgeInsets.all(1.0),
                          child:
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius value
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1.0,          // Border width
                              ),
                            ),
                            child: Text(
                              MyInputPage.inputData,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'FontRegular',
                                fontSize: 18,
                                // Adjust other style properties as needed
                              ),
                            ),
                          )

                        // How to handle overflow

                      ),




                      // Image
                      // Image.asset(
                      //   'assets/img/edit.PNG', // Replace with your image asset path
                      //   width: 100, // Adjust the width as needed
                      //   height:95, // Adjust the height as needed
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Future<void> downloadAndSaveImageToGallery(String responseImg) async {
  if(Api.isString == false){
  try {
    var response = await http.get(Uri.parse(responseImg));
    if (response.statusCode == 200) {
      Uint8List uint8list = response.bodyBytes;
      final result =
      await ImageGallerySaver.saveImage(Uint8List.fromList(uint8list));
      if (result != null && result['isSuccess'] == true) {
        print('Image saved to gallery');
      } else {
        print('Failed to save image to gallery.');
      }
    } else {
      print('Failed to download image: ${response.statusCode}');
    }
  } catch (e) {
    print('Error downloading and saving image: $e');
  }
  }
  else {
    try {
      // Send an HTTP GET request to the image URL
      final response = await http.get(Uri.parse(responseImg));

      if (response.statusCode == 200) {
        // Get the application's documents directory to save the image
        final appDocumentsDirectory = await getApplicationDocumentsDirectory();

        // Define the file path for the downloaded image
        final file = File('${appDocumentsDirectory.path}/downloaded_image.png');

        // Write the image content to the file
        await file.writeAsBytes(response.bodyBytes);
        final result = await ImageGallerySaver.saveFile(file.path);
        // Now you can access the downloaded image using 'file.path'
        print('Image downloaded to: ${file.path}');
      } else {
        // Handle the case when the HTTP request fails (e.g., 404 Not Found)
        print('Failed to download the image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the process
      print('Error while downloading image: $e');
    }
  }
}

void _openSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return advance(); // Use the imported bottom sheet widget
    },
  );
}

