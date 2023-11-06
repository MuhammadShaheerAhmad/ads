// bottom_sheet.dart
import 'package:flutter/material.dart';

class advanceSheet extends StatefulWidget {

  @override
  State<advanceSheet> createState() => _advanceSheetState();
}

class _advanceSheetState extends State<advanceSheet> {
  double _progressValue = 0.3;
  double _progressValue2 = 0.3; // Default value

  void _updateProgress(double value) {
    setState(() {
      _progressValue = value;
    });
  }

  void _updateProgress2(double value) {
    setState(() {
      _progressValue2 = value;
    });
  }

  bool _isButton1Active = true;
  bool _isButton2Active = false;

  void _toggleButtons() {
    setState(() {
      _isButton1Active = !_isButton1Active;
      _isButton2Active = !_isButton2Active;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: DraggableScrollableSheet(
        initialChildSize: 1.0,
        minChildSize: 0.1,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0), topRight: Radius.circular(70.0)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
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
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.settings,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6,),

                        Text(
                          "Advance Filter",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          "Negative Prompt",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 16),

                    TextField(

                      onChanged: (text) {
                        // Handle text change here
                      },
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        // Adjust other style properties as needed
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white54.withOpacity(0.3),
                        hintText: "Don't include",
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      // Adjust padding as needed
                      ),
                    ),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          "CFG Scale",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 16),
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width, // Set container width to screen width
                        padding: EdgeInsets.all(5.0),

                        child: Slider(
                          value: _progressValue,
                          onChanged: _updateProgress,
                          min: 0.0,
                          max: 1.0,
                          activeColor: Color(0xFF5BC22A), // Color of the active part of the slider
                          inactiveColor: Colors.white, // Color of the inactive part of the slider
                        ),
                      ),
                    ),
                    Center(
                      child: Row(  // Opening of Row widget
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(  // Opening of Container widget for left name
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Better Quality',  // Left name
                              style: TextStyle(fontSize: 18.0,color: Colors.white54),
                            ),
                          ),  // Closing of Container widget for left name

                          Container(  // Opening of Container widget for right name
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Match Prompt',  // Right name
                              style: TextStyle(fontSize: 18.0 ,color: Colors.white54),
                            ),
                          ),  // Closing of Container widget for right name

                        ],
                      ),
                    ),
                  ],

                ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          "Sampling Steps",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    //Second Progress Bar
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width, // Set container width to screen width
                            padding: EdgeInsets.all(5.0),

                            child: Slider(
                              value: _progressValue2,
                              onChanged: _updateProgress2,
                              min: 0.0,
                              max: 1.0,
                              activeColor: Color(0xFF5BC22A), // Color of the active part of the slider
                              inactiveColor: Colors.white, // Color of the inactive part of the slider
                            ),
                          ),
                        ),
                        Center(
                          child: Row(  // Opening of Row widget
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(  // Opening of Container widget for left name
                                margin: EdgeInsets.all(8.0),
                                child: Text(
                                  'Faster Output',  // Left name
                                  style: TextStyle(fontSize: 18.0,color: Colors.white54),
                                ),
                              ),  // Closing of Container widget for left name

                              Container(  // Opening of Container widget for right name
                                margin: EdgeInsets.all(8.0),
                                child: Text(
                                  'Better Output',  // Right name
                                  style: TextStyle(fontSize: 18.0, color: Colors.white54),
                                ),
                              ),  // Closing of Container widget for right name

                            ],
                          ),
                        ),
                      ],

                    ),


                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          "Seed",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 16),

                    TextField(

                      onChanged: (text) {
                        // Handle text change here

                      },
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,color: Colors.white
                        // Adjust other style properties as needed
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white54.withOpacity(0.3),
                        hintText: 'Picks a random Seed when empty',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        // Adjust padding as needed
                      ),
                    ),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [

                        Text(
                          "Selected Size",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button click logic here
                                  _toggleButtons();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isButton1Active
                                      ? Color(0xFF5BC22A)
                                      : Colors.grey.withOpacity(0.3), // Set button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Set rounded border
                                  ),
                                ),
                                child: Text('512x512',
                                  style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ), // Closing of Container widget

                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button click logic here
                                  _toggleButtons();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isButton2Active
                                      ? Color(0xFF5BC22A)
                                      : Colors.grey.withOpacity(0.3), // Set button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Set rounded border
                                  ),
                                ),
                                child: Text('768x512',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),),
                              ),
                            ),
                          ), // Closing of Container widget
                        ],
                      ),
                    ),
                    Container(
                      width: double
                          .infinity,
                      height: 60,// Ensure the button takes the full available width
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.all(8.0),
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
                        child: Text('Save'  , style: TextStyle(fontSize: 22,
                          color: Colors.black,
                        ),),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double
                          .infinity,
                      height: 60,// Ensure the button takes the full available width
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      margin: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your button click logic here

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white54,
                          // Set button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Set rounded border
                          ),
                          // Increase button width
                        ),
                        child: Text('Remove Filters',   style: TextStyle(fontSize: 22.0 ,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),

                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
