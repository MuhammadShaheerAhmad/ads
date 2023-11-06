import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'result.dart';
import 'dart:convert';
import 'api.dart';
import 'splash.dart';
class ImageScreen extends StatefulWidget {
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}
class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: MediaQuery.of(context).size.height, // Set the height to the screen height
        width: MediaQuery.of(context).size.width,
        child: SplashScreen1.valueServer! ?
        InteractiveViewer(
            maxScale: 5.0,
            minScale: 0.01,
          child: Image.network(
              Api.responseImg),
        )
            :InteractiveViewer(
          maxScale: 5.0,
          minScale: 0.01,
          child: Image.memory(Base64Decoder().convert(Api.imageURL))
          // Image.network(
          //   resultPage.imgDisplay),
        ),
        // Use an Image widget to display the image covering the entire screen
        ),
      );

  }
}