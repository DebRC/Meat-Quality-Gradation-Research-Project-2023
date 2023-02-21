// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meat_gradation_app/functions/prediction_methods.dart';
import 'package:meat_gradation_app/widgets/all_buttons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite/tflite.dart';

class MainScreen extends StatefulWidget {
  // Named route
  static const String idScreen = "mainscreen";
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late File _image;
  late List _results;
  bool imageSelect = false;

  @override
  void initState() {
    super.initState();
  }

  Future<File> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
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
                      fontSize: width * 0.07,
                      color: const Color.fromARGB(255, 228, 29, 15)),
                ),
                Image(
                  image: const AssetImage('assets/images/openLogo.png'),
                  height: height * (0.35),
                  width: width * (0.8),
                ),
                const Text(
                  "A neural network based meat quality assesment which uses Tensorflow for grading",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 73, 133),
                      fontFamily: 'Brand',
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                // Button to continue to login page
                BigButton(
                    title: "PICK IMAGE",
                    fontColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 7, 30, 136),

                    // Function's getting called after pressing Get Started button
                    onPressed: () async {
                      File image = await pickImage();
                      Map<String, dynamic> prediction =
                          await PredictionMethods.meatQualityChecker(image);
                      debugPrint("THIS IS THE RECEIVED PREDICTION JSON");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => OTPScreen(
                      //             phoneNo:
                      //                 "+91" + mobileTextEditingController.text,
                      //           )),
                      // );
                    }),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
