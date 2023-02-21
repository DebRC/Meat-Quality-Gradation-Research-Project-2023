import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:meat_gradation_app/functions/prediction_methods.dart';
import 'package:meat_gradation_app/screens/result_screen.dart';
import 'package:meat_gradation_app/widgets/all_buttons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite/tflite.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> prediction;
  const ResultScreen({super.key, required this.prediction});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    // Getting screen width and height
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Result"),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.file(widget.prediction["meatImage"]),
                Text(widget.prediction["meatType"].toString(),
                    style: TextStyle(
                        fontFamily: 'Brand',
                        fontSize: width * 0.055,
                        color: const Color(0xFF818181))),
                Text(widget.prediction["meatTypeConfidence"].toString(),
                    style: TextStyle(
                        fontFamily: 'Brand',
                        fontSize: width * 0.055,
                        color: const Color(0xFF818181))),
                Text(widget.prediction["consumableConfidence"].toString(),
                    style: TextStyle(
                        fontFamily: 'Brand',
                        fontSize: width * 0.055,
                        color: const Color(0xFF818181))),
                Text(widget.prediction["nonConsumableConfidence"].toString(),
                    style: TextStyle(
                        fontFamily: 'Brand',
                        fontSize: width * 0.055,
                        color: const Color(0xFF818181)))
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: pickImage,
      //   tooltip: "Pick Image",
      //   child: const Icon(Icons.image),
      // ),
    );
  }
}
