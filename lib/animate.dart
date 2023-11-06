import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'result.dart';
import 'package:lottie/lottie.dart';
class ImageAnimate extends StatefulWidget {
  @override
  State<ImageAnimate> createState() => _ImageAnimateState();
}
class _ImageAnimateState extends State<ImageAnimate> {
  double _imageWidth = 100.0;

  void _animateImage() {
    setState(() {
      _imageWidth = 200.0; // Change the width of the image
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(

              child:Text('ccc' , textAlign: TextAlign.center,  style: TextStyle(
                color: Colors.white,
                fontSize: 28,

              ),),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              width: 412, // Adjust width and height as needed
              height: 692,
              child: Lottie.asset(
                'assets/data.json', // Replace with the actual path

              ),
            ),
          ),
        ],
      ),
    );

  }
}