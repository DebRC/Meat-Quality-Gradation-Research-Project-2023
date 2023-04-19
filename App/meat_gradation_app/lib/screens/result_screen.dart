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
import 'package:percent_indicator/percent_indicator.dart';
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
      backgroundColor: Color.fromARGB(255, 243, 225, 225),
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
          "Result",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(218, 131, 19, 17),
          ),
        ),
        backgroundColor: Color.fromRGBO(213, 179, 183, 1),
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
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 69, 36, 36),
                                      width: 4.0,
                                      style: BorderStyle.solid)),
                              child: CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 15.0,
                                animation: true,
                                percent:
                                    widget.prediction["meatTypeConfidence"] /
                                        100,
                                center: Text(
                                  textAlign: TextAlign.center,
                                  "${widget.prediction["meatType"].toString() + "\n" + (widget.prediction["meatTypeConfidence"]).toString()}%",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 52, 52),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                header: Text(
                                  "Meat Type",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 52, 52),
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.055),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Color.fromARGB(255, 84, 171, 33),
                                backgroundColor:
                                    Color.fromARGB(255, 223, 122, 116),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15, left: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 69, 36, 36),
                                      width: 4.0,
                                      style: BorderStyle.solid)),
                              child: CircularPercentIndicator(
                                radius: 60.0,
                                lineWidth: 15.0,
                                animation: true,
                                percent:
                                    widget.prediction["consumableConfidence"] /
                                        100,
                                center: Text(
                                  "${(widget.prediction["consumableConfidence"]).toString()}%",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 52, 52),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                                header: Text(
                                  "Consumable",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 93, 52, 52),
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.055),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Color.fromARGB(255, 84, 171, 33),
                                backgroundColor:
                                    Color.fromARGB(255, 223, 122, 116),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: Color.fromARGB(255, 69, 36, 36),
                                  width: 4.0,
                                  style: BorderStyle.solid)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Remarks",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 93, 52, 52),
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.055)),
                              Text("${widget.prediction["remarks"].toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 10,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Brand',
                                      fontSize: width * 0.055,
                                      color:
                                          Color.fromARGB(255, 157, 134, 134)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
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
