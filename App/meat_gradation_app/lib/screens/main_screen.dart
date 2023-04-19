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
      backgroundColor: Color.fromARGB(255, 243, 225, 225),
      body: Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          // centred columnn child
          mainAxisAlignment: MainAxisAlignment.center,
          // children inside the column
          children: [
            // Tag Line of Company
            Text(
              "Meat Quality Gradation",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Brand-Bold',
                  fontSize: width * 0.1,
                  color: Color.fromARGB(255, 189, 24, 12)),
            ),
            Image(
              image: const AssetImage('assets/images/openLogo.png'),
              height: height * (0.35),
              width: width * (0.8),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              child: Text(
                "A meat quality assessment app which uses Keras interface of Tensorflow to predict the quality of the meat.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 130, 19, 16),
                    fontFamily: 'Brand',
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: BigButton(
                  title: "PICK IMAGE",
                  fontColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 189, 24, 12),
                  // Function's getting called after pressing Get Started button
                  onPressed: () async {
                    late File image;
                    showModalBottomSheet(
                        context: context,
                        isDismissible: false,
                        builder: (BuildContext context) => OptionSheet(
                              heading: "Choose Image Source",
                              rightButtonMessage: "Gallery",
                              leftButtonMessage: "Camera",
                              rightButtonColor:
                                  Color.fromARGB(255, 110, 57, 57),
                              leftButtonColor: Colors.redAccent,
                              rightButtonFunction: () async {
                                image = await pickImage();
                                Navigator.pop(context);
                              },
                              leftButtonFunction: () async {
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
          ],
        ),
      ),
    );
  }
}
