// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:meat_gradation_app/functions/prediction_methods.dart';
import 'package:meat_gradation_app/screens/camera_screen.dart';
import 'package:meat_gradation_app/screens/result_screen.dart';
import 'package:meat_gradation_app/widgets/all_buttons.dart';
import 'package:meat_gradation_app/widgets/option_sheet.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  // Named route
  static const String idScreen = "mainscreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<File> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    debugPrint("IMAGE IS CHOSEN :::: $image");
    // PredictionMethods.meatTypeClassifier(image);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen width and height
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 244, 244),
      body: Padding(
        // Adding main padding for all widget
        padding: const EdgeInsets.all(8),

        // Inserting Widgets in Column
        child: Column(children: [
          // Widget to hold logo and name
          Container(
            alignment: Alignment.center,
            height: height * 0.7,
            child: Column(
              // centred columnn child
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,

              // children inside the column
              children: [
                // Tag Line of Company
                Text(
                  "Meat Quality Gradation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Brand-Bold',
                      fontSize: width * 0.1,
                      color: const Color.fromARGB(255, 228, 29, 15)),
                ),
                Image(
                  image: const AssetImage('assets/images/openLogo.png'),
                  height: height * (0.35),
                  width: width * (0.8),
                ),
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "A meat quality assessment app which uses Keras interface of Tensorflow to predict the quality of the meat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 73, 133),
                        fontFamily: 'Brand',
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BigButton(
                title: "PICK IMAGE",
                fontColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 224, 50, 20),

                // Function's getting called after pressing Get Started button
                onPressed: () async {
                  late File image;
                  showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) => OptionSheet(
                            heading: "Choose Image Source",
                            leftButtonMessage: "Gallery",
                            rightButtonMessage: "Camera",
                            leftButtonColor: Colors.redAccent,
                            rightButtonColor: Color.fromARGB(255, 22, 202, 226),
                            leftButtonFunction: () async {
                              image = await pickImage();
                              Navigator.pop(context);
                            },
                            rightButtonFunction: () async {
                              final cameras = await availableCameras();
                              image = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraScreen(
                                            cameras: cameras,
                                          )));
                              Navigator.pop(context);
                            },
                          )).then((value) async {
                    Map<String, dynamic> prediction =
                        await PredictionMethods.meatQualityChecker(image);
                    debugPrint(
                        "THIS IS THE RECEIVED PREDICTION JSON $prediction");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(
                                prediction: prediction,
                              )),
                    );
                  });
                }),
          )
        ]),
      ),
    );
  }
}
