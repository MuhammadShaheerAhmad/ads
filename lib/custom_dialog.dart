import 'package:flutter/material.dart';
import'result.dart';
AlertDialog customProgressDialog(double progress) {
  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Color(0xFF5BC22A), width: 4.5),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
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
              value: progress / 100,
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
