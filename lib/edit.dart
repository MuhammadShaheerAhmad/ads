// bottom_sheet.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'MyScrollScreen.dart';
import 'desc.dart';
import 'result.dart';
import 'AdManager.dart';
import 'bottom.dart';
import 'sheet.dart';
import 'api.dart';
 bool editBtn=false;
class advance extends StatefulWidget {

  @override
  State<advance> createState() => _advanceState();
}

class _advanceState extends State<advance> {
  TextEditingController _controller = TextEditingController();
  bool _isButtonActive = true;
  @override
  void initState() {
    // RewardedAdManager.createRewardedAd();

    // RewardedAdManager.loadInterstitialAd();
    super.initState();
    _controller.addListener(_onTextChanged);
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
  void _onTextChanged() {
    setState(() {
      _isButtonActive = _controller.text.isNotEmpty;
      MyInputPage.inputData = _controller.text;
    });
  }





  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 1.0,
      minChildSize: 0.1,
      maxChildSize: 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.black,

          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0), topRight: Radius.circular(70.0)),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.drag_handle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mode_edit_outline_outlined,
                        size: 28,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6,),
                      Text(
                        "Edit Prompt",
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  MyInputPage(
                    controller: _controller= TextEditingController(text: MyInputPage.inputData),
                    randomController: _controller,
                  ),
                  SizedBox(height: 4),
                  Padding(

                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(

                          "Style", textAlign: TextAlign.start,
                          style: TextStyle(

                            fontFamily: 'FontMain',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              // Handle button press
                              _openBottomSheet(context);

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
                                Consumer<CardSelectionModel>(
                                  builder: (context, cardSelectionModel, child) {
                                    return Row(
                                      children: [
                                        SizedBox(width: 18),
                                        Image.asset(
                                          cardSelectionModel
                                              .selectedCardImageUrl.isNotEmpty
                                              ? cardSelectionModel
                                              .selectedCardImageUrl
                                              : 'assets/img/pic.jpg', //5 Default image URL
                                          width: 34,
                                          height: 28,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          cardSelectionModel
                                              .selectedCardDescription.isNotEmpty
                                              ? cardSelectionModel
                                              .selectedCardDescription
                                              : "Inspire v1",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "View All",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 15,
                                        fontFamily:'FontRegular' ,
                                        decoration: TextDecoration.underline,
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
                              // RewardedAdManager.showInterstitialAd();
                              _openSheet(context); // Handle button press

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
                                    'Advance Settings',
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
                            onPressed:  () async {
                              editBtn=true;
                              String query = _controller.text;
                              // Fluttertoast.showToast(
                              //   msg: "Data :${MyInputPage.inputData}",
                              //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                              //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
                              //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
                              //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
                              //   textColor: Colors.white, // Text color
                              //   fontSize: 16.0, // Font size
                              // );

                              resultPage.imgT(MyInputPage.inputData);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => resultPage(),
                              //   ),
                              // );
                              _onButtonPressed(query);

                              RewardedAdManager.showRewardedAd();
                              Api.responseImg="";

                              Navigator.of(context)
                                  .pop();

                              Api.createImage();

                              print(
                                  "Firebase Analytics event logged: GENERATE_CLICKED");
                            },
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
                                    Text(
                                      "Generate",
                                      style: TextStyle(
                                        color: Colors.black87, // Set the color of "Generate" to orange
                                        fontSize:
                                        20, // Adjust the font size as needed
                                      ),
                                    ),
                                    Text("Watch an Ad",
                                        style: TextStyle(
                                          color: Colors
                                              .black54, // Set the color of "Watch an Ad" to white
                                          fontSize:
                                          16, // Adjust the font size as needed
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Container(
                    width: double
                        .infinity,
                    height: 70,// Ensure the button takes the full available width
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    // margin: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button click logic here

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5BC22A),// Set button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Set rounded border
                        ),
                        // Increase button width
                      ),
                      child: Text(' Remove Ads'  , style: TextStyle(fontSize: 18,
                        color: Colors.black,
                      ),),
                    ),
                  ),
                  SizedBox(height: 4),



                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onButtonPressed(String query) {

    resultPage.imgT(query);

    print('Button pressed with text: ${query}');
  }
}
//
// class MyInput extends StatefulWidget {
// // Add this line
//   // Add this line
//
//   @override
//   _MyInputState createState() => _MyInputState();
// }
//
// class _MyInputState extends State<MyInput> {
//   TextEditingController _controller = TextEditingController(text: MyInputPage.inputData);
//
//
//   // Initial maximum width
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Row(children: [
//         Expanded(
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextField(
//                     controller: _controller,
//                     onChanged: (text) {
//                       // Handle text change here
//                       setState(() {
//                         MyInputPage.inputData=_controller.text;
//                         resultPage.prompt= _controller.text;
//                       });
//                     },
//                     minLines: 5,
//                     maxLines: null,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'FontRegular',
//                       fontSize: 18,
//                       overflow: TextOverflow.ellipsis,
//                       // Adjust other style properties as needed
//                     ),
//                     decoration: InputDecoration(
//                       hintText: "",
//                       hintStyle: TextStyle(color: Colors.white60),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: BorderSide(
//                           color: Color(0xFF5BC22A),
//                           width: 2.0,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         borderSide: BorderSide(
//                           color: Color(0xFF5BC22A),
//                           width: 2.0,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.only(
//                           right: 46.0,
//                           left: 12.0,
//                           top: 12.0,
//                           bottom: 8), // Adjust padding as needed
//                     ),
//                   ),
//                 ],
//               ),
//               if (MyInputPage.inputData.isNotEmpty)
//                 Positioned(
//                   top: -10,
//                   right: 5,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.delete_rounded,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       setState(() {
//
//                         _controller.clear();
//
//                         // Debug log
//                         print(
//                             "Firebase Analytics event logged: PROMPT_DELETED");
//                       });
//                     },
//                   ),
//                 ),
//
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
//
//



void _openBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return newBottomSheet(); // Use the imported bottom sheet widget
    },
  );
}

void _openSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return advanceSheet(); // Use the imported bottom sheet widget
    },
  );
}