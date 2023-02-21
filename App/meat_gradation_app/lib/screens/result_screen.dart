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
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 25,
            color: Color.fromARGB(218, 131, 19, 17),
          ),
        ),
        title: const Text(
          "Prediction Result",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(218, 131, 19, 17),
          ),
        ),
        backgroundColor: Color.fromRGBO(243, 232, 233, 1),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(width / 3), // Image radius
                        child: Image.file(widget.prediction["meatImage"],
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Meat Type :: ",
                                style: TextStyle(
                                    fontFamily: 'Brand',
                                    fontSize: width * 0.055,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Flexible(
                              child: Text(
                                  widget.prediction["meatType"].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 138, 136, 136))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Meat Type Confidence :: ",
                                style: TextStyle(
                                    fontFamily: 'Brand',
                                    fontSize: width * 0.055,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Flexible(
                              child: Text(
                                  "${(widget.prediction["meatTypeConfidence"] * 100).toString().substring(0, 6)}%",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 138, 136, 136))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Consumable :: ",
                                style: TextStyle(
                                    fontFamily: 'Brand',
                                    fontSize: width * 0.055,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Flexible(
                              child: Text(
                                  "${(widget.prediction["consumableConfidence"] * 100).toString().substring(0, 6)}%",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 138, 136, 136))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Non-Consumable :: ",
                                style: TextStyle(
                                    fontFamily: 'Brand',
                                    fontSize: width * 0.055,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Flexible(
                              child: Text(
                                  "${(widget.prediction["nonConsumableConfidence"] * 100).toString().substring(0, 6)}%",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 138, 136, 136))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Remarks :: ",
                                style: TextStyle(
                                    fontFamily: 'Brand',
                                    fontSize: width * 0.055,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Flexible(
                              child: Text(
                                  "${widget.prediction["remarks"].toString()}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 138, 136, 136))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 50),
                    child: BigButton(
                        title: "GRADE ANOTHER",
                        fontColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 224, 50, 20),
                        // Function's getting called after pressing Get Started button
                        onPressed: () async {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
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
