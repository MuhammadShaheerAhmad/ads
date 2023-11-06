// bottom_sheet.dart
import 'dart:ffi';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'result.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'desc.dart';
class newBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(

      child:
      Container(
        color: Colors.black,
        child: DraggableScrollableSheet(

          initialChildSize: 1.0,
          maxChildSize: 1.0,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0), topRight: Radius.circular(70.0)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        alignment: Alignment.center,
                        color: Colors.transparent,
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
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/2s.png",
                                    description: "Photography",
                                    value: 33,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/Anime.jpg",
                                    description: "Anime",  value: 34,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/Cyberpunk.jpg",
                                    description: "Cyberpunk",  value: 32,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Additional Round Cards with Images and Text
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/4s.jpg",
                                    description: "Creative",  value: 31,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/Oil-Painting.jpg",
                                    description: "Oil_Painting",  value: 30,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/7s.png",
                                    description: "Cinematic_Render",  value: 28,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Additional Round Cards with Images and Text
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/v1.jpg",
                                    description: "Inspire_V1",  value: 27,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/6s.jpg",
                                    description: "Realistic",  value: 29,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/3s.jpg",
                                    description: "Comic",  value: 21,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(

                          children: [
                            Expanded(
                              child: Column(

                                children: [
                                  CardWithButton(
                                    imageUrl:
                                    "assets/img/Portrait.jpg",
                                    description: "Portrait",  value: 26,
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                            // SizedBox(width: 10),
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       CardWithButton(
                            //         imageUrl:
                            //         "assets/img/black.png",
                            //         description: "",  value: 29,
                            //       ),
                            //       SizedBox(height: 8),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(width: 10),
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       CardWithButton(
                            //         imageUrl:
                            //         "assets/img/black.png",
                            //         description: "",  value: 21,
                            //       ),
                            //       SizedBox(height: 8),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // Additional Round Cards with Images and Text
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/6.jpg",
                      //               description: "No Style",  value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 10),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/5.png",
                      //               description: "Description for Card 11",  value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 10),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/4.png",
                      //               description: "Description for Card 12",
                      //               value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Additional Round Cards with Images and Text
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/3.png",
                      //               description: "Description for Card 13",
                      //               value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 10),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/2.jpg",
                      //               description: "Description for Card 14",
                      //               value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //       SizedBox(width: 10),
                      //       Expanded(
                      //         child: Column(
                      //           children: [
                      //             CardWithButton(
                      //               imageUrl:
                      //               "assets/img/1.png",
                      //               description: "Description for Card 15",
                      //               value: 27,
                      //             ),
                      //             SizedBox(height: 8),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),);
  }
}
late String myInteger ="27";
class CardWithButton extends StatelessWidget {
  final String imageUrl;
  final String description;
  final int value; // Add an integer value parameter


  CardWithButton({required this.imageUrl, required this.description , required this.value,});

  @override
  Widget build(BuildContext context) {
    final cardSelectionModel = Provider.of<CardSelectionModel>(context);

    return Column(
      children: [
        InkWell(
          onTap: () {
            cardSelectionModel.setSelectedCardDescription(description);
            cardSelectionModel.setSelectedCardImageUrl(imageUrl);

            myInteger="${value}";
            styleValue(myInteger);
            Navigator.of(context)
                .pop();
            FirebaseAnalytics.instance.logEvent(  //Inspiration Clicked log
              name: "STYLE_SELECTED",
              parameters: {"SelectedStyle": value , "Description" : description},
            );
            // Debug log
            print("Firebase Analytics event logged: STYLE_SELECTED: " + description + "_Clicked");
            // Handle card tap
            // For example, you can navigate to a detail page or perform some action
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 107,
                    width: 107,
                    color: Colors.transparent,
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Center(
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(16.0),
                  //     child: Material(
                  //       color: Colors.transparent,
                  //       child: IconButton(
                  //         icon: Icon(Icons.play_arrow,   size: 28,
                  //           color: Colors.white,),
                  //         onPressed: () {
                  //           // Handle play button press
                  //           // For example, you can play a video or perform an action
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(description,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
          ),// Show only the first line
          overflow: TextOverflow.ellipsis, // Ellipsis for overflow
        ),
      ],
    );
  }
}
void styleValue(String myInteger) {
    resultPage.valueT(myInteger);
  print('Button pressed with text: ${myInteger}');
}
