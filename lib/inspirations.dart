import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'AdManager.dart';
class DataList extends StatefulWidget {
  static bool check=false;
 static var myContr10 = Get.put(MyController10());
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  List<DataItem> data = [];
  @override
  void initState() {
    DataList.myContr10.loadAd();
    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {
    Fluttertoast.showToast(
      msg: "Inspirations function",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      backgroundColor: Colors.black.withOpacity(0.7), // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Font size
    );
    final String apiUrl =
        "https://middleware.businesconsulting.com/api/easyart/get-inspirations";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        final dataList = responseData['data'] as List<dynamic>;
        data = dataList.map((item) => DataItem(
          id: item['_id'],
          name: item['name'],
          prompt: item['prompt'],
          image: item['image'],
          isPriority: item['isPriority'],
          time: item['time'],
        )).toList();
        setState(() {}); // Update the UI with the fetched data.

        // You can now set your inspiration data in your state or perform any other actions.
        // Example:
        // setState(() {
        //   inspirationData = data;
        // });
      } else {
        print("Error fetching data: ${response.reasonPhrase}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }


    Fluttertoast.showToast(
      msg: "Inspirations",
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
      timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
      backgroundColor: Colors.black.withOpacity(0.7), // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Font size
    );



  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (3 / 4),
        crossAxisCount: 2, // Two cards in a row
// Adjust the spacing as needed
        mainAxisSpacing:3,
        crossAxisSpacing: 3,
        // childAspectRatio: 0.6,// Adjust the spacing as needed
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];


        return DataCard(item);
      },
    );
  }
}

class DataCard extends StatefulWidget {

  final DataItem data;

  DataCard(this.data);
  @override

  @override
  State<DataCard> createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  final bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {

          },
          onTapUp: (_) {


          },
          onTapCancel: () {


          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.network(
                      widget.data.image,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.3), // Add the shading color here
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        // Handle play button press
                        // For example, you can play a video or perform an action
                      },
                      child: Container(
                        width: 48,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.white60,
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.all(2),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Text(
                              'TRY',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.data.prompt,
          maxLines: 2, // Show only the first line
          overflow: TextOverflow.ellipsis, // Ellipsis for overflow
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            shadows: [

              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
