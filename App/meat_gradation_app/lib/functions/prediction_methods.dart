import 'package:flutter/cupertino.dart';
import 'package:meat_gradation_app/models/meat.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

class PredictionMethods {
  // Classifies the type of meat
  static Future<Meat> meatTypeClassifier(File image) async {
    String res;
    res = (await Tflite.loadModel(
        model: "assets/models/meat_classifier.tflite",
        labels: "assets/models/meat_classifier_labels.txt"))!;
    print("MODEL LOADING STATUS: $res");
    int index = 0;
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    Tflite.close();
    debugPrint("THIS IS THE MODEL OUTPUT :::: $recognitions");
    for (int i = 1; i < recognitions!.length; i++) {
      if (recognitions[i]['confidence'] > recognitions[index]['confidence']) {
        index = i;
      }
    }
    debugPrint(
        "HIGHEST CONFIDENCE IN :::: ${recognitions[index]['label']} WITH ${recognitions[index]['confidence']}");
    Meat meat = Meat(
        meatType: recognitions[index]['label'],
        meatTypeConfidence: recognitions[index]['confidence']);
    return meat;
  }

  // Classifies the quality of the meat
  static Future<Map<String, dynamic>> meatQualityChecker(File image) async {
    Meat meat = await meatTypeClassifier(image);
    meat.meatImage = image;
    String res;
    if (meat.meatType == "Chicken") {
      res = (await Tflite.loadModel(
          model: "assets/models/chicken_model.tflite",
          labels: "assets/models/chicken_model_labels.txt"))!;
      print("MODEL LOADING STATUS: $res");
    } else if (meat.meatType == "Fish") {
      res = (await Tflite.loadModel(
          model: "assets/models/fish_model.tflite",
          labels: "assets/models/fish_model_labels.txt"))!;
      print("MODEL LOADING STATUS: $res");
    } else if (meat.meatType == "Prawn") {
      res = (await Tflite.loadModel(
          model: "assets/models/prawn_model.tflite",
          labels: "assets/models/prawn_model_labels.txt"))!;
      print("MODEL LOADING STATUS: $res");
    } else {}
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    meat.consumableConfidence = 0;
    meat.nonConsumableConfidence = 0;
    for (int i = 0; i < recognitions!.length; i++) {
      if (recognitions[i]['index'] == 1) {
        meat.nonConsumableConfidence = recognitions[i]['confidence'];
      } else {
        meat.consumableConfidence = recognitions[i]['confidence'];
      }
    }
    if (meat.consumableConfidence == 0) {
      meat.consumableConfidence =
          1.0 - (meat.nonConsumableConfidence as double);
    }
    if (meat.nonConsumableConfidence == 0) {
      meat.nonConsumableConfidence =
          1.0 - (meat.consumableConfidence as double);
    }
    meat.remarks = meatRemarks(meat);
    return meat.toJson();
  }

  // Gives the remarks about the quality of the meat
  static String meatRemarks(Meat meat) {
    String remarks;
    if (meat.consumableConfidence! >= 0.8) {
      remarks =
          "Meat is slaughtered most likely in the last 24 hours. Can be consumed within 3 days with proper refrigeration";
    } else if (meat.nonConsumableConfidence! >= 0.8) {
      remarks =
          "Meat is slaughtered atleast 5 days back. It is not safe to consume the meat";
    } else if (meat.nonConsumableConfidence! >= 0.5) {
      remarks =
          "Meat is slaughtered atleast 3 days back. It is not safe to consume the meat";
    } else if (meat.consumableConfidence! >= 0.5) {
      remarks =
          "Meat is slaughtered atleast 1 days back. Can be consumed within 1 day with proper refrigeration";
    } else {
      remarks = "It is not safe to consume the meat";
    }
    return remarks;
  }
}
