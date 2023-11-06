import 'dart:convert';
import 'package:Inspire.AI/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sheet.dart';
import 'result.dart';
import 'bottom.dart';
import 'desc.dart';
import 'dart:math';
import 'dart:async';
import 'api.dart';
import 'package:provider/provider.dart';
import 'AdManager.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'image.dart';
import 'sheet.dart';
import 'splash.dart';
final Uri _url1 = Uri.parse(
    'https://sites.google.com/view/inspire-ai-ai-image-generator?usp=sharing');
final Uri _url2 = Uri.parse(
    'https://sites.google.com/view/navicosoftgamesprivacy-policy/home');
class MyInputPage extends StatefulWidget {
  final TextEditingController controller ;
  final TextEditingController randomController; // Add this line

  MyInputPage({required this.controller, required this.randomController});
  // Add this line
  static String inputData ="";


  @override
  _MyInputPageState createState() => _MyInputPageState();
}
class _MyInputPageState extends State<MyInputPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> randomDescriptions = [
    "ultra realistic close up portrait ((beautiful pale cyberpunk female with heavy black eyeliner)), blue eyes, shaved side haircut, hyper detail, cinematic lighting, magic neon, dark red city, Canon EOS R3, nikon, f/1.4, ISO 200, 1/160s, 8K, RAW, unedited, symmetrical balance, in-frame, 8K",
    "anime, intricate dress, cyberpunk, sitting",
    "mdjrny-pntrt, Chinese Shrine, contrasting colour palette",
    "photo of an old man in a jungle, looking at the camera",
    "A painting of a white house in the snow, a detailed matte painting, by Shin Yun-bok, fantasy art, celestial red flowers vibe, in a candy land style house, when kindness falls like rain, cloud palace, ( ( isometric ) ), depicting a flower, white powder bricks, high details photo",
    "melting trippy zombie muscle car, smoking, with big eyes, hyperrealistic, intricate detail, high detail render, vibrant, cinematic lighting, shiny, ceramic, reflections",
    "city landscape in the style of trnlgcy",
    "A beautiful painting of a singular lighthouse, shining its light across a tumultuous sea of blood by greg rutkowski and thomas kinkade, Trending on artstation.",
    "Kawaii low poly panda character, 3d isometric render, white background, ambient occlusion, unity engine, square image",
    "woolitize photo of elon musk",
    "((masterpiece,best quality)),1girl, solo, animal ears, rabbit, barefoot, knees up, dress, sitting, rabbit ears, short sleeves, looking at viewer, grass, short hair, smile, white hair, puffy sleeves, outdoors, puffy short sleeves, bangs, on ground, full body, animal, white dress, sunlight, brown eyes, dappled sunlight, day, depth of field",
    "modelshoot style, (extremely detailed CG unity 8k wallpaper), full shot body photo of the most beautiful artwork in the world, english medieval witch, green vale, pearl skin,golden crown, diamonds, medieval architecture, professional majestic oil painting by Ed Blinkey, Atey Ghailan, Studio Ghibli, by Jeremy Mann, Greg Manchess, Antonio Moro, trending on ArtStation, trending on CGSociety, Intricate, High Detail, Sharp focus, dramatic, photorealistic painting art by midjourney and greg rutkowski",
    "dreamlikeart, a grungy woman with rainbow hair, travelling between dimensions, dynamic pose, happy, soft eyes and narrow chin, extreme bokeh, dainty figure, long hair straight down, torn kawaii shirt and baggy jeans, In style of by Jordan Grimmer and greg rutkowski, crisp lines and color, complex background, particles, lines, wind, concept art, sharp focus, vivid colors",
    "(masterpiece:1.2, best quality), (finely detailed beautiful eyes: 1.2), (extremely detailed CG unity 8k wallpaper, masterpiece, best quality, ultra-detailed, best shadow), (detailed background), (beautiful detailed face, beautiful detailed eyes), High contrast, (best illumination, an extremely delicate and beautiful),1girl,((colourful paint splashes on transparent background, dulux,)), ((caustic)), dynamic angle,beautiful detailed glow,full body, cowboy shot,",
    "hatsune_miku",
    "Beautiful anime painting of solarpunk summer chill day, by tim okamura, victor nizovtsev, greg rutkowski, noah bradley. trending on artstation, 8k, masterpiece, graffiti paint, fine detail, full of color, intricate detail, golden ratio illustration Steps: 50, Sampler: DPM2 a Karras, CFG scale: 7, Seed: 3410174956, Size: 512x768, Model hash: a2a802b2",
    "masterpiece, best quality, high quality, 1girl, solo, brown hair, green eyes, looking at viewer, autumn, cumulonimbus cloud, lighting, blue sky, autumn leaves, garden, ultra detailed illustration, intricate detailed",
    "1girl, aqua eyes, baseball cap, blonde hair, closed mouth, earrings, green background, hat, hoop earrings, jewelry, looking at viewer, shirt, short hair, simple background, solo, upper body, yellow shirt",
    "tiny cute adorable ginger tabby kitten studio light",
    "a photo of a brightly colored turtle",
    "masterpiece, best quality, high quality, extremely detailed CG unity 8k wallpaper, scenery, outdoors, sky, cloud, day, no humans, mountain, landscape, water, tree, blue sky, waterfall, cliff, nature, lake, river, cloudy sky, award winning photography, Bokeh, Depth of Field, HDR, bloom, Chromatic Aberration , Photorealistic, extremely detailed, trending on artstation, trending on CGsociety, Intricate, High Detail, dramatic, art by midjourney",
    "Poster of a sith lord from STAR WARS, wide angle, sharp focus, concept art, extreme details, full shot, Full Body shot, Cinematic, Color Grading, Photography, Depth of Field, hyper - detailed, beautifully color - coded, insane details, intricate details, beautifully color graded, Unreal Engine, Cinematic, Color Grading, Editorial, Shot on 70mm lens, Depth of Field, DOF, Shutter Speed 1/ 1000, F/ 2, White Balance, 32k, Super - Resolution, Megapixel, Pro Photo GB, VR, Lonely, Good, Massive, Half rear Lighting, Backlight, Natural Lighting, Incandescent, Optical Fiber, Moody Lighting, Cinematic Lighting, Studio Lighting, Soft Lighting, Volumetric, Contre - Jour, Beautiful Lighting, Accent Lighting, Global Illumination, Screen Space Global Illumination, Ray Tracing Global Illumination, Optics, Scattering, Glowing, Shadows, Rough, Shimmering, Ray Tracing Reflections, Lumen Reflections, Screen Space Reflections, Diffraction Grading, Chromatic Aberration, GB Displacement, Scan Lines, R a y Traced, Ray Tracing Ambient Occlusion, Anti - Aliasing, FKAA, TXAA, RTX, SSAO, Shaders, OpenGL - Shaders, GLSL - Shaders, Post Processing, Post - Production, Cell Shading, Tone Mapping, painted, concept art, insanely detailed and intricate, hyper maximalist, elegant, super detailed, dynamic pose, volumetric, ultra photoreal, ultra-detailed, super detailed, full color, ambient occlusion, volumetric lighting, high contrast",
    "oil painting of handsome older gentleman, masterpiece",
    "super cute fluffy cat warrior in armor, photorealistic, 4K, ultra detailed, vray rendering, unreal engine",
    "A photorealistic, highly detailed illustration of Ana de Armas in a vintage Hollywood style, reminiscent of the golden age of cinema, with a focus on glamour and elegance.",
    "1boy, bishounen, casual, indoors, sitting, coffee shop, bokeh",
    "oscavatar",
    "Transformer Prime",
    "view of turbulent swells of a violent ocean storm, inside a glass bottle on the beach ม dramatic thunderous sky at dusk at center a closeup of large tall pirate ship with sails, breaking light",
    "A Sports Car",
    "a kindly old mouse psychiatrist wearing a tweed suit in his plush office, medium shot , art painted by JC Leyendecker. ghibli, highly detailed, concept art, dramatic lighting, smooth, sharp features, sharp focus, mysterious --ar 16:9 --no humans –",
    "A logo for a YouTube channel for facts no text with a wise middle aged man	",
    "A detailed illustration a Dead Skull wearing trendy sunglasses, t-shirt design, flowers splash, beach splash, t-shirt design, in the style of Studio Ghibli, bright colors, 3D vector art, fantasy art, hard black borders, bokeh, Adobe Illustrator, hand-drawn, digital painting, low-poly, bird's-eye view, isometric style, retro aesthetic, focused on the character, 4K resolution, photorealistic rendering, using Cinema 4D	",
    "Delicious doughnuts, floating in the air, cinematic, food professional photography, studio lighting, studio background, advertising photography, intricate details, hyper-detailed, ultra realistic, 8K	",
    "Alien creature in humanoid shape, with opalescent skin and iridiscent scales, masterpiece, absolutely perfect, stunning image, visually rich, intricately detailed, concept art, by Mschiffer, glowy, cinematic, UHD wallpaper, 3d, octane render, volumetric lights		",
    "Beatrix Potter style watercolor. From Henry Cavill and Milla Jovovich Chibi style, they are in a rural school, a landscape of pastel colors.	",

    // Add more random descriptions as needed
  ];
  // Initial maximum width
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: widget.controller,


                    onChanged: (text) {
                      // Handle text change here
                      setState(() {
                        MyInputPage.inputData = widget.controller.text;

                      });
                    },
                    minLines: 6,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FontRegular',
                      fontSize: 18,
                      // Adjust other style properties as needed
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Prompt here...i.e sports car in desert',
                      hintStyle: TextStyle(color: Colors.white60),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFF5BC22A),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFF5BC22A),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          right: 46.0,
                          left: 12.0,
                          top: 12.0,
                          bottom: 8), // Adjust padding as needed
                    ),
                  ),
                ],
              ),
              if (widget.controller.text.isNotEmpty)
                Positioned(
                  top: -10,
                  right: 5,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();

                        FirebaseAnalytics.instance.logEvent(
                          name: "PROMPT_DELETED",
                          parameters: {"delete": "Text Deleted"},
                        );
                        // Debug log
                        print(
                            "Firebase Analytics event logged: PROMPT_DELETED");
                      });
                    },
                  ),
                ),
              Positioned(
                bottom: 8,
                right: 13,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      final random = Random();
                      final randomIndex =
                      random.nextInt(randomDescriptions.length);
                      widget.randomController.text =
                      randomDescriptions[randomIndex];
                      FirebaseAnalytics.instance.logEvent(
                        name: "PROMPT_RANDOM_CLICKED",
                        parameters: {"prompt": "Prompt Random Clicked"},
                      );
                      // Debug log
                      print(
                          "Firebase Analytics event logged: PROMPT_RANDOM_CLICKED");
                    });
                  },
                  child: Container(
                    width:
                    45.0, // Set the width of the container and image as needed
                    height:
                    45.0, // Set the height of the container and image as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the container circular
                      color: Colors.green
                          .withOpacity(0.5), // Set the green color with opacity
                      border: Border.all(
                        color: Colors.black, // Set the border color to black
                        width: 1.0, // Set the border width as needed
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/img/dice.png', // Replace with the path to your image in assets
                        width: 25.0, // Set the width of the image as needed
                        height: 25.0,
                        color: Color(
                            0xFF75F834), // Set the height of the image as needed
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
class MyScrollScreen extends StatefulWidget {

  @override
  State<MyScrollScreen> createState() => _MyScrollScreenState();
}
class _MyScrollScreenState extends State<MyScrollScreen> {
  bool adWidgetAdded = true; // Add this flag
  var myContr = Get.put(MyController());
  var myContr1 = Get.put(MyController1());
  var myContr2 = Get.put(MyController2());
  var myContr3 = Get.put(MyController3());
  var myContr4 = Get.put(MyController4());
  var myContr5 = Get.put(MyController5());
  var myContr6 = Get.put(MyController6());
  var myContr7 = Get.put(MyController7());
  var myContr8 = Get.put(MyController8());
  var myContr9 = Get.put(MyController9());
  var myContr10 = Get.put(MyController10());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();
  bool _isButtonActive = false;
  @override
  void initState() {
    // RewardedAdManager.createRewardedAd();
    myContr.loadAd();
    myContr1.loadAd();
    myContr2.loadAd();
    myContr3.loadAd();
    myContr4.loadAd();
    myContr5.loadAd();
    myContr6.loadAd();
    myContr7.loadAd();
    myContr8.loadAd();
    myContr9.loadAd();
    myContr10.loadAd();
    // RewardedAdManager.loadInterstitialAd();
    // Fluttertoast.showToast(
    //   msg: "imagine_server : ${SplashScreen1.valueServer}",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // Top, Center, Bottom
    //   timeInSecForIosWeb: 1, // iOS and web specific (in seconds)
    //   backgroundColor: Colors.black.withOpacity(0.7), // Background color
    //   textColor: Colors.white, // Text color
    //   fontSize: 16.0, // Font size
    // );
    super.initState();
    _controller.addListener(_onTextChanged);
    // _createRewardedAd();
  }

  @override
  void didChangeDependancies() {
    super.didChangeDependencies();
    // loadRewarded();
  }

  // Initialize a flag to track reward status
  void _onTextChanged() {
    setState(() {
      _isButtonActive = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    myContr.dispose();
    myContr1.dispose();
    myContr2.dispose();
    myContr3.dispose();
    myContr4.dispose();
    myContr5.dispose();
    myContr6.dispose();
    myContr7.dispose();
    myContr8.dispose();
    myContr9.dispose();
    myContr10.dispose();
    // _rewardedAd?.dispose();
    super.dispose();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inspire.AI",
          style: TextStyle(
            fontFamily: 'FontMain',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), //or 15.0
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.lightGreen.shade600.withOpacity(0.2),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Color(0xFF5BC22A),
                          size: 25,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 34,
                    height: 34,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img/pic.jpg',
                        fit: BoxFit.cover,
                        width: 34,
                        height: 34,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Inspire.AI",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FontMain',
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
                title: Text(
                  "Queue",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the text color to white
                  ),
                ),
                onTap: () {}),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "Terms and Conditio..",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
              onTap: () => _launchUrl1(),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
              onTap: () => _launchUrl2(),
              //
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Text at the top
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Prompt",
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MyInputPage(
              controller: _controller,
              randomController: _controller,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Style",
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                        FirebaseAnalytics.instance.logEvent(
                          //Inspiration Clicked log
                          name: "STYLES_CLICKED",
                          parameters: {"Style": "Style  Clicked"},
                        );
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
                        FirebaseAnalytics.instance.logEvent(
                          //Inspiration Clicked log
                          name: "ADVANCE_SETTINGS_CLICKED",
                          parameters: {"setting": "Advance settings  Clicked"},
                        );
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
                      onPressed: _isButtonActive
                          ? () async {
                        String query = _controller.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => resultPage(),
                          ),
                        );
                        _onButtonPressed(query);
                        RewardedAdManager.showRewardedAd();
                        FirebaseAnalytics.instance.logEvent(
                          //Inspiration Clicked log
                          name: "GENERATE_CLICKED",
                          parameters: {
                            "generate": "Generate Button  Clicked"
                          },
                        );
                        // Debug log
                        print(
                            "Firebase Analytics event logged: GENERATE_CLICKED");
                      }
                          : null,
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
                ],
              ),
            ),
            // Text saying "Get Inspired"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Get Inspired",
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                          imageUrl: "assets/img/image9.png",
                          description:
                          "Create a spooky and atmospheric Halloween-themed image featuring a haunted house surrounded by mist, a full moon in the background, and eerie jack-o'-lanterns lining the path. Capture the essence of the Halloween spirit with your creativit",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/32.png",
                          description:
                          "Beatrix Potter style watercolor. From Henry Cavill and Milla Jovovich Chibi style, they are in a rural school, a landscape of pastel colors.",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/30.png",
                          description:
                          "Delicious doughnuts, floating in the air, cinematic, food professional photography, studio lighting, studio background, advertising photography, intricate details, hyper-detailed, ultra realistic, 8K",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/34.png",
                          description:
                          "Alien creature in humanoid shape, with opalescent skin and iridiscent scales, masterpiece, absolutely perfect, stunning image, visually rich, intricately detailed, concept art, by Mschiffer, glowy, cinematic, UHD wallpaper, 3d, octane render, volumetric lights",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr.isAdLoaded.value
                          ? ConstrainedBox(

                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/Van Goh style p.png",
                          description:
                          "Van Goh style painting of Achilles killing Hector, as is narrated in the Iliad, behind the walls of Troy, only two people in the picture. Hyperrealistic",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/ali.png",
                          description:
                          "A vibrant alien biodome aircraft facility nestled in a giant tree, with organic shapes made from biomaterials, isometric octopus tentacles, and leafy vines cascading down the sides. Rendered in 3D Vray with a focus on vibrant colors and organic materials.",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/28.png",
                          description:
                          "A detailed illustration a Dead Skull wearing trendy sunglasses, t-shirt design, flowers splash, beach splash, t-shirt design, in the style of Studio Ghibli, bright colors, 3D vector art, fantasy art, hard black borders, bokeh, Adobe Illustrator, hand-drawn, digital painting, low-poly, bird's-eye view, isometric style, retro aesthetic, focused on the character, 4K resolution, photorealistic rendering, using Cinema 4D",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/31.png",
                          description:
                          "character sheet, female, red hair, mage, concept art, full body, centered, dynamic pose, facing directly at the viewer, comic style,simple studio dark background, analogous colors, perfect anatomy, wearing tight cloth, with a weapon, high detail face, by: (Sakimi chan, Ilya Kuvshinov,Studio Ghibli, style of CGSociety, Artgerm, WLOP)",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/29.png",
                          description:
                          "A logo for a YouTube channel for facts no text with a wise middle aged man",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/38.png",
                          description:
                          "two eagle heads facing from the inside out on a Symmetrical shield, ornate border, steel, digital background, hypermaximalist, insanely detailed and intricate, octane render, unreal engine, 8k, by greg rutkowski and Peter Mohrbacher and magali villeneuve, 3d vray render, isometric",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr1.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 350,
                          ),
                          child: AdWidget(ad: myContr1.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/39.png",
                          description:
                          "a delicious triple meat burger with bacon and yellow cheese, accompanied with a glass of whiskey on the rocks",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/40.png",
                          description:
                          "A 90’s nostalgia cassette",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/36.png",
                          description:
                          "front view ultra detailed goddess sita with White holographic Sari flying, Smooth long dress, Goddess Sita - Divine beauty, Radiant complexion - Golden and pure, Expressive eyes - Compassionate and wise, Lustrous hair - Dark and flowing, Ornate hair ornaments - Floral and decorative, Graceful figure - Elegance and poise Vibrant saree - Blue or red with intricate patterns Serene expression - Wisdom and resilience Lotus flower - Symbol of purity and enlightenmentDivine aura - Captivating and ethereal focus on face, dynamic pose, holographic, light particles, ultra detailed illustration by illustration by loish and artgerm, wlop, hit definition, 32k resolution, volumetric lighting, “best quality”, 'masterpiece' Full body, focus on face, best quality face, holographic, intricately detailed, Black Hair, Disney Style, Indian background, queen",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/18.jpg",
                          description:
                          "1girl, aqua eyes, baseball cap, blonde hair, closed mouth, earrings, green background, hat, hoop earrings, jewelry, looking at viewer, shirt, short hair, simple background, solo, upper body, yellow shirt ",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/8.png",
                          description:
                          "A beautiful painting of a singular lighthouse, shining its light across a tumultuous sea of blood by greg rutkowski and thomas kinkade, Trending on artstation.",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/5.png",
                          description:
                          "A painting of a white house in the snow, a detailed matte painting, by Shin Yun-bok, fantasy art, celestial red flowers vibe, in a candy land style house, when kindness falls like rain, cloud palace, ( ( isometric ) ), depicting a flower, white powder bricks, high details photo",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/6.jpg",
                          description:
                          "melting trippy zombie muscle car, smoking, with big eyes, hyperrealistic, intricate detail, high detail render, vibrant, cinematic lighting, shiny, ceramic, reflections",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/23.png",
                          description:
                          "oil painting of handsome older gentleman, masterpiece",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr2.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr2.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/12.png",
                          description:
                          "modelshoot style, (extremely detailed CG unity 8k wallpaper), full shot body photo of the most beautiful artwork in the world, english medieval witch, green vale, pearl skin,golden crown, diamonds, medieval architecture, professional majestic oil painting by Ed Blinkey, Atey Ghailan, Studio Ghibli, by Jeremy Mann, Greg Manchess, Antonio Moro, trending on ArtStation, trending on CGSociety, Intricate, High Detail, Sharp focus, dramatic, photorealistic painting art by midjourney and greg rutkowski",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/1.png",
                          description:
                          "ultra realistic close up portrait ((beautiful pale cyberpunk female with heavy black eyeliner)), blue eyes, shaved side haircut, hyper detail, cinematic lighting, magic neon, dark red city, Canon EOS R3, nikon, f/1.4, ISO 200, 1/160s, 8K, RAW, unedited, symmetrical balance, in-frame, 8K",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/iron.png",
                          description:
                          "baby iron man",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Super car.png",
                          description:
                          "Sports car",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/20.jpg",
                          description:
                          "Highly detailed portrait photo of a Accurate and true to life Natural colored turtle in realistic style forest background",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/13.jpg",
                          description:
                          "dreamlikeart, a grungy woman with rainbow hair, travelling between dimensions, dynamic pose, happy, soft eyes and narrow chin, extreme bokeh, dainty figure, long hair straight down, torn kawaii shirt and baggy jeans, In style of by Jordan Grimmer and greg rutkowski, crisp lines and color, complex background, particles, lines, wind, concept art, sharp focus, vivid colors",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/14.jpg",
                          description:
                          "(masterpiece:1.2, best quality), (finely detailed beautiful eyes: 1.2), (extremely detailed CG unity 8k wallpaper, masterpiece, best quality, ultra-detailed, best shadow), (detailed background), (beautiful detailed face, beautiful detailed eyes), High contrast, (best illumination, an extremely delicate and beautiful),1girl,((colourful paint splashes on transparent background, dulux,)), ((caustic)), dynamic angle,beautiful detailed glow,full body, cowboy shot,",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/4.png",
                          description:
                          "photo of an old man in a jungle, looking at the camera",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr3.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 350,
                          ),
                          child: AdWidget(ad: myContr3.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),// Large Round Cards Side by Side with Image and Text
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/3.png",
                          description:
                          "mdjrny-pntrt, Chinese Shrine, contrasting colour palette",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/7.png",
                          description:
                          "city landscape in the style of trnlgcy",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/colorful design.png",
                          description:
                          "colorful design of an elephant in a fantasy jungle, black background",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/baby hulk.png",
                          description:
                          "baby hulk in standing position",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Kingleo.png",
                          description:
                          "King Leão Nebulosa Galaxy, T-Shirt Art, T-Shirt Design, Shirt Print, Splash art, style, portrait poster, Adobe Illustrator, Vector, 3D Illustration, Abstract Art, Print illustrations, Dark Background, Vibrant Color, Very Colorful, Trendy Colorful Gradient, Centered, Front View, Hyper Detailed, Photorealistic Rendering, 8k HD, Focused, Super Detailed, head feathers, Intricately Detailed Splash Art Triadic Color Trend Artstation Unreal Engine 5 Volumetric Lighting, Gothic , High resolution, close-up, ambient light, Nikon 15mm f/1.8G, by GIlSam-paio octane rendering depicting innovation and truth, 8k, glamour, intricate detailed environment, lace, smudges , ornate, unreal engine, fantastica",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/a vibrant watercolor.png",
                          description:
                          "a vibrant watercolor lion with color splash effect",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/19.png",
                          description:
                          "tiny cute adorable ginger tabby kitten studio light",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/a samurai ,.png",
                          description:
                          "a samurai , cyberpunk, very coherent artwork, 8K, micro detail, digital painting, artstation, vivid, sharp focus",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr4.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr4.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/a beautiful young.png",
                          description:
                          "a beautiful young girl with white hair with white dress, white skin, dark and piercing eyes, highly detailed eyes, digital art, sharp focus, trending on art station, anime art style",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Chris Hemsworth a.png",
                          description:
                          "Chris Hemsworth as a barbarian from dungeons and dragons, lean muscles, DnD, in the style of realistic and hyper-detailed renderings,dungeons and dragons, 8k, detailed eyes, perfect eyes, epic , dramatic , fantastical, full body , intricate design and details, dramatic lighting, hyperrealism, photorealistic, cinematic, 8k, detailed face, Dramatic photo,epic photo, whole body,barbarian,",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/10.png",
                          description:
                          "woolitize photo of elon musk",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/11.jpg",
                          description:
                          "((masterpiece,best quality)),1girl, solo, animal ears, rabbit, barefoot, knees up, dress, sitting, rabbit ears, short sleeves, looking at viewer, grass, short hair, smile, white hair, puffy sleeves, outdoors, puffy short sleeves, bangs, on ground, full body, animal, white dress, sunlight, brown eyes, dappled sunlight, day, depth of field",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/17.png",
                          description:
                          "masterpiece, best quality, high quality, 1girl, solo, brown hair, green eyes, looking at viewer, autumn, cumulonimbus cloud, lighting, blue sky, autumn leaves, garden, ultra detailed illustration, intricate detailed",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/2.jpg",
                          description:
                          "young blonde girl, realistic robotic, sitting on Stoll , Futuristic background, High-tech dressing, side angle, purple hair",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/15.png",
                          description:
                          "hatsune_miku",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/robotic girl beautiful anim.png",
                          description:
                          "robotic girl beautiful anime, intricate, elegant, highly detailed, digital painting, artstation, matte, smooth, sharp focus, illustration, art by konstantin razumov",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr5.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 350,
                          ),
                          child: AdWidget(ad: myContr5.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/portrait of a teacher.png",
                          description:
                          "portrait of a teacher on the moon in front of a futuristic school",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/olpntng style, colorful rainbow.png",
                          description:
                          "olpntng style, colorful rainbow realistic corgi dog head, animal mascot, T-shirt design, clean design, epic Instagram, artstation, splash of colorful paint, wlop , contour, ((white background)) , nice perfect face with soft skin , concept art portrait by greg rutkowski, artgerm, hyperdetailed intricately detailed gothic art trending on artstation triadic colors, unreal engine, fantastical, intricate detail, splash screen, complementary colors, fantasy concept art, 8k resolution, gothic deviantart masterpiece, oil painting, heavy strokes, paint dripping",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Sports Bike.png",
                          description:
                          "Sports Bike",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/21.png",
                          description:
                          "masterpiece, best quality, high quality, extremely detailed CG unity 8k wallpaper, scenery, outdoors, sky, cloud, day, no humans, mountain, landscape, water, tree, blue sky, waterfall, cliff, nature, lake, river, cloudy sky, award winning photography, Bokeh, Depth of Field, HDR, bloom, Chromatic Aberration , Photorealistic, extremely detailed, trending on artstation, trending on CGsociety, Intricate, High Detail, dramatic, art by midjourney",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/9.png",
                          description: "Kawaii low poly panda character, 3d isometric render, white background, ambient occlusion, unity engine, square image",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/16.jpg",
                          description:
                          "Beautiful anime painting of solarpunk summer chill day, by tim okamura, victor nizovtsev, greg rutkowski, noah bradley. trending on artstation, 8k, masterpiece, graffiti paint, fine detail, full of color, intricate detail, golden ratio illustration Steps: 50, Sampler: DPM2 a Karras, CFG scale: 7, Seed: 3410174956, Size: 512x768, Model hash: a2a802b2",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/22.jfif",
                          description:
                          "Poster of a sith lord from STAR WARS, wide angle, sharp focus, concept art, extreme details, full shot, Full Body shot, Cinematic, Color Grading, Photography, Depth of Field, hyper - detailed, beautifully color - coded, insane details, intricate details, beautifully color graded, Unreal Engine, Cinematic, Color Grading, Editorial, Shot on 70mm lens, Depth of Field, DOF, Shutter Speed 1/ 1000, F/ 2, White Balance, 32k, Super - Resolution, Megapixel, Pro Photo GB, VR, Lonely, Good, Massive, Half rear Lighting, Backlight, Natural Lighting, Incandescent, Optical Fiber, Moody Lighting, Cinematic Lighting, Studio Lighting, Soft Lighting, Volumetric, Contre - Jour, Beautiful Lighting, Accent Lighting, Global Illumination, Screen Space Global Illumination, Ray Tracing Global Illumination, Optics, Scattering, Glowing, Shadows, Rough, Shimmering, Ray Tracing Reflections, Lumen Reflections, Screen Space Reflections, Diffraction Grading, Chromatic Aberration, GB Displacement, Scan Lines, R a y Traced, Ray Tracing Am bient Occlusion, Anti - Aliasing, FKAA, TXAA, RTX, SSAO, Shaders, OpenGL - Shaders, GLSL - Shaders, Post Processing, Post - Production, Cell Shading, Tone Mapping, painted, concept art, insanely detailed and intricate, hyper maximalist, elegant, super detailed, dynamic pose, volumetric, ultra photoreal, ultra-detailed, super detailed, full color, ambient occlusion, volumetric lighting, high contrast",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/24.png",
                          description: "super cute fluffy cat warrior in armor, photorealistic, 4K, ultra detailed, vray rendering, unreal engine <lora:epiNoiseoffset_v2:0. 5> <lora:iu_V35:0. 5>",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr6.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr6.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/25.png",
                          description:
                          "A photorealistic, highly detailed illustration of Ana de Armas in a vintage Hollywood style, reminiscent of the golden age of cinema, with a focus on glamour and elegance.",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/26.jfif",
                          description:
                          "1boy, bishounen, casual, indoors, sitting, coffee shop, bokeh",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/27.jpg",
                          description:
                          "oscavatar",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/art by hendrik h.png",
                          description:
                          "art by hendrik hondius charming birds in the treean ultra hd detailed painting,digital art, Jean-Baptiste Monge style, bright, beautiful , splash, , Glittering , cute and adorable, filigree, , rim lighting, lights, extremely , magic, surreal, fantasy, digital art, , wlop, artgerm and james jean, , centered, symmetry, painted, intricate, volumetric lighting, beautiful, rich deep colors masterpiece, sharp focus, ultra detailed, in the style of dan mumford and marc simonetti, astrophotography",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/King kong Eoghaill o.png",
                          description: "King kong Eoghaill of the ancient god, highly detailed, fantasy art, matte painting, trending on artstation, concept art, sharp focus, illustration",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/1girlsolo.png",
                          description:
                          "(masterpiece, best quality, high quality, 1girl, solo, brown hair, green eyes, looking at viewer, autumn, cumulonimbus cloud, lighting, blue sky, autumn leaves, garden, ultra detailed illustration, intricate detailed)",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/high quality, 8K Ultra HD,.png",
                          description:
                          "high quality, 8K Ultra HD, highly detailed, vivid colorful, Seamless patterns, fabric art, Art station, stary night many colorful detailed cocktails and drinks icons, splash arts, aesthetic for Tshirt design, white tone, Same quality as images using Leonardo.Ai's Alchemy photography, Quality images using Alchemy photography, luminism, 3d render, octane render, Isometric, awesome full color,",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/a pizza on the wooden.png",
                          description:
                          "a pizza on the wooden dough the pizza is pepperoni 8k Chromatic aberration Hyper realistic",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr7.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 350,
                          ),
                          child: AdWidget(ad: myContr7.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/Give me an upclose.png",
                          description:
                          "Give me an upclose 3d realistic single pink dragon eye with extreme detail",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Photo realistic old b.png",
                          description: "Photo realistic old barn in one third of the image, on the edge of a cut corn field at sunset. Forest of trees in background in fall colors. Big stormy clouds in the sky. Epic mountain range in background. One Old rustic truck in foreground.",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/high quality, 8K Ultra HD,.png",
                          description:
                          "high quality, 8K Ultra HD, Steampunk Time Voyager, Watercolor, wash technique, colorful, A painting with dripping and scattered paint, blurry, smudge outline, Embark on a thrilling journey through time in a steampunk-infused world, where past and future intertwine in perfect unison. This intricate digital art piece captures the essence of a daring time voyager exploring a Victorian-era metropolis with a steampunk twist, The protagonist, a courageous young woman adorned in a blend of vintage and futuristic attire, stands atop a colossal clock tower adorned with ornate cogs and gears, Airships gracefully traverse the skies, propelled by precise mechanical propellers, The city's architecture harmoniously blends classic Victorian elegance with intricate steampunk machinery, resulting in a visually captivating juxtaposition, Rich sepia tones and metallic hues evoke a sense of depth and nostalgic allure, Inspired by the works of esteemed steampunk artists like Brian Kesinger and James Ng",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/A menacing Terminator.png",
                          description:
                          "A menacing Terminator endoskeleton stares into the camera, its red eyes glowing with artificial intelligence. The metal frame is perfectly preserved, and the machine's expression is one of pure hatred. The image has been enhanced with post-production techniques, giving it a sharp, realistic quality",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/A raccoon dressed.png",
                          description:
                          "A raccoon dressed as an assassin",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Baby Spiderman.png",
                          description:
                          "Baby Spiderman",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/create a anime character for costa rica,.png",
                          description:
                          "create a anime character for costa rica, costa rica background, costa rica style, costumes and looks, character should be unique, funny and looks stereotypical --ar 16:9",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Cute and adorable fantasy owl,.png",
                          description:
                          "Cute and adorable fantasy owl, Bird-of-Paradise, sparrow, full body, shiny metallic jeweled depth, glowing smoke neon eyes, hoarfrost metal lace, fantasy, sunlight, sunbeam, intricate detail. 8k, dreamlike, surrealism, super cute, symmetrical, soft lighting, trending on artstation, intricate details, highly detailed, unreal engine, by ross tran, wlop, artgerm and james jean, Brian Froud, art illustration by Miho Hirano, Neimy Kanani, oil on canvas by Aykut Aydoğdu, oil painting, heavy strokes, paint dripping",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr8.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr8.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/cute and adorable rabbit,.png",
                          description: "cute and adorable rabbit, steampunk, futuristic, neon lighting, baroque, ornate, bokeh from streetlights,sunbeam, intricate detail. 8k, dreamlike, super cute, symmetrical, soft lighting, trending on artstation, intricate details, highly detailed, unreal engine, by ross tran, wlop, artgerm and james jean, Brian Froud, art illustration by Miho Hirano, Neimy Kanani, oil on canvas by Aykut Aydoğdu, cute big circular reflective eyes, Pixar render, unreal engine cinematic smooth, intricate detail ",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Design interiors that blend.png",
                          description:
                          "Design interiors that blend seamlessly with nature using sustainable materials. Employ earthy color palettes, optimize daylight, and incorporate indoor plants. Choose eco-friendly furniture and fixtures. Create a tranquil atmosphere that connects occupants with the natural surroundings, fostering well-being. --ar 9:11 --v 5.2",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/European young woman,.png",
                          description: "European young woman, night city, detailed symmetric crocodile eyes, Milky Way, city, red/blue/white Apache national clothing, head feathers, Mexican skull makeup, Intricately Detailed Splash Art Triadic Color Trend Artstation Unreal Engine 5 Volumetric Lighting, Gothic , High resolution, close-up, ambient light, Nikon 15mm f/1.8G, by GIlSam-paio octane rendering depicting innovation and truth, 8k, by Lee Jeffries, Alessio Albi, Adrian Kuipers, glamour, intricate detailed environment, lace, smudges , dark watercolor background, masterpiece, ornate, depth",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/famous building ,a woman walking.png",
                          description:
                          "famous building ,a woman walking in a night sky, dark lighting, atmospheric, cinematic, ultra detailed, concept art",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/famous building populated.png",
                          description: "famous building populated by the sea, artstation trending, hyperdetailed, 8k highly detailed",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/girl with blonde hair,.png",
                          description:
                          "girl with blonde hair, with a red dress , in a dark forest, cartoon old anime 1980s studio ghibli classic style –",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/jungleplantconceptartray.png",
                          description: "jungle plant, concept art, rayman legend style, --ar 16:9",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/A painting of a white house i.png",
                          description:
                          "A painting of a white house in the snow, a detailed matte painting, by Shin Yun-bok, fantasy art, celestial red flowers vibe, in a candy land style house, when kindness falls like rain, cloud palace, ( ( isometric ) ), depicting a flower, white powder bricks, high details photo",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr9.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 350,
                            minHeight: 350,
                          ),
                          child: AdWidget(ad: myContr9.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/kneeling cat knight.png",
                          description: "kneeling cat knight, portrait, finely detailed armor, intricate design, silver, silk, cinematic lighting, 4k,",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/lion king age of the dragon,.png",
                          description:
                          "lion king age of the dragon, portrait art by pete mohrbacher and ross thran trending on artstation and unreal engine and cinema4d, 8k high resolution, cinematic, unreal engine 5,",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/main highway connecting with.png",
                          description: "main highway connecting with other smaller roads, On the side of the road are houses, stadiums, high-rise buildings, banquets, high quality, ultrarealistic, view from the drone – ",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/manmen.png",
                          description:
                          "(((2 heads))), (((duplicate))), ((malformed hand)), ((deformed arm)), man, men, blurry, abstract, deformed, thick eyebrows, cartoon, animated, toy, figure, framed, 3d, cartoon, bad art, deformed, poorly drawn, extra limbs, close up, weird colors, blurry, watermark, blur haze, long neck, watermark, elongated body, cropped image, out of frame, draft, (((deformed hands))), ((twisted fingers)), double image, ((malformed hands)), multiple heads, extra limb, ugly, ((poorly drawn hands)), missing limb, cut-off, grain, bad anatomy, poorly drawn face, mutation, mutated, floating limbs, disconnected limbs, out of focus, long body, disgusting, extra fingers, (weird figure), missing arms, mutated hands, cloned face, missing legs, long neck",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/robotic girl security guard holding.png",
                          description: "robotic girl security guard holding a large glowing orb, concept art, trending on artstation, artstationhd, artstationhq, highly detailed, intricate, sharp focus, illustration",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/sepia ink wash landscape of ancient vi.png",
                          description:
                          "sepia ink wash Landscape of ancient villages in Ninh Binh Vietnam, rocks, ponds, plum trees, pine trees, and mountains in the background, muted colors, wet on wet technique, sketch ink watercolor style with a splash of red by Wu Guanzhong, Truong Lo, Mary Jane Ansell, Agnes Cecile, muted splash art, ink splatter, faded dripping paints. sepia monochrome, soft impressionists brushstrokes",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Space pirate leader.png",
                          description: "Space pirate leader, by James Jean and thomas kinkade and David Hockney, digital art, trending on artstation, 4k",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/steampunk.png",
                          description:
                          "steampunk girl",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    const Text("Native Ad is Loading....",      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    // set your according
                    Obx(() => Container(
                      child: myContr10.isAdLoaded.value
                          ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            minHeight: 100,
                          ),
                          child: AdWidget(ad: myContr10.nativeAd!))
                          : const SizedBox(),
                    )),
                  ],
                ),
                Positioned(
                  top: 20, // Adjust this value to position the text vertically
                  left: 4, // Adjust this value to position the text horizontally
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CardWithButton(
                          imageUrl: "assets/img/sticker.png",
                          description: "STICKER, A detailed illustration a print of vivid cute kitten head, fantasy flowers splash, vintage t-shirt design, in the style of Studio Ghibli, white and orange flora pastel tetradic colors, 3D vector art, cute and quirky, fantasy art, watercolor effect, bokeh, Adobe Illustrator, hand-drawn, digital painting, low-poly, soft lighting, bird's-eye view, isometric style, retro aesthetic, focused on the character, 4K resolution, photorealistic rendering, using Cinema 4D",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/dog.png",
                          description:
                          "sticker, cartoon cute Rottweiler, white background, 12K, high quality, HD, cinematic lighting",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/37.png",
                          description: "Super car",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/Transformer Prime.png",
                          description:
                          "Transformer Prime ",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/view of turbulent swells.png",
                          description: "view of turbulent swells of a violent ocean storm, inside a glass bottle on the beach ม dramatic thunderous sky at dusk at center a closeup of large tall pirate ship with sails, breaking light",
                          updateDescription: (description) {
                            _controller.text = description;
                            // Update the controller text
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
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
                          imageUrl: "assets/img/A white cat baby is.png",
                          description:
                          "A white cat baby is doing a martial artsmnove, cute，happy,smiling，funny，white background，in the style of historical themes, concept art, oriental, detailed Hanfu costumes,mastery of perspective，realistic，3D",
                          updateDescription: (description) {
                            _controller.text = description;
                          },
                          clearController: () {
                            setState(() {
                              _controller.clear();
                            });
                          },
                          scrollController: _scrollController,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _onButtonPressed(String query) {

    resultPage.imgT(query);



    print('Button pressed with text: ${query}');
  }
}
class CardWithButton extends StatefulWidget {
  final String imageUrl;
  final String description;
  final Function(String) updateDescription;
  final Function() clearController;
  final ScrollController scrollController; // Add this line
  // Add this line

  CardWithButton({
    required this.imageUrl,
    required this.description,
    required this.updateDescription,
    required this.clearController,
    required this.scrollController,
  });

  @override
  _CardWithButtonState createState() => _CardWithButtonState();
}
class _CardWithButtonState extends State<CardWithButton> {
  bool isPressed = false;

  void scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (_) {
            setState(() {
              isPressed = true;

            });
            scrollToTop();
          },
          onTapUp: (_) {
            setState(() {
              isPressed = false;
              widget.clearController();
            });
            // Call the callback to update description
            widget.updateDescription(widget.description);
            MyInputPage.inputData = widget.description;
            var prompt= widget.description;
            var img= widget.imageUrl;
            var first_ten_letters = widget.description;
            first_ten_letters = first_ten_letters[10];
            scrollToTop();
            // _showCardDialog(context, prompt,img);
            FirebaseAnalytics.instance.logEvent(
              //Inspiration Clicked log
              name: "INSPIRATION_CLICKED",
              parameters: {"desc": first_ten_letters},
            );
            // Debug log
            print("Firebase Analytics event logged: INSPIRATION_CLICKED");

            // Handle card tap
            // For example, you can navigate to a detail page or perform some action
          },
          onTapCancel: () {
            setState(() {
              isPressed = false;
            });
            scrollToTop();
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
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isPressed)
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
          widget.description,
          maxLines: 2, // Show only the first line
          overflow: TextOverflow.ellipsis, // Ellipsis for overflow
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            shadows: [
              if (isPressed)
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
Future<void> _launchUrl1() async {
  if (!await launchUrl(_url1)) {
    throw Exception('Could not launch $_url1');
  }
}
Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
}
// sendDataToFunctionInFile2();
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
