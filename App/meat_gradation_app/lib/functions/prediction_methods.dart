import 'package:flutter/cupertino.dart';
import 'package:meat_gradation_app/models/meat.dart';
import 'dart:io';

import 'package:tflite/tflite.dart';

class PredictionMethods {
  static Future<List> meatTypeClassifier(File image) async {
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
    return [recognitions[index]['label'], recognitions[index]['confidence']];
  }

  static Future<Map<String, dynamic>> meatQualityChecker(File image) async {
    List meatTypeDetails = await meatTypeClassifier(image);
    Meat meat = Meat();
    meat.meatType = meatTypeDetails[0];
    meat.meatTypeConfidence = meatTypeDetails[1];
    return meat.toJson();
  }
}
