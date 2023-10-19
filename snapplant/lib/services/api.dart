import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<dynamic> analyzePlant(String imagePath) async {
  final imageBytes = File(imagePath).readAsBytesSync();
  String imageBase64 = base64Encode(imageBytes);
  final dio = Dio();

  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(imagePath, filename: "image.jpg"),
  });
  try {
    final response = await dio.post(
      'http://192.168.137.1:5000/predict',
      // "https://us-central1-potatoe-disease-classification.cloudfunctions.net/predict",
      // 192.168.137.1
      // 'http://192.168.137.1:5000/predict';

      data: formData,
    );
    print("response from api");
    print(response.data);
    return response.data;
  } catch (e) {
    debugPrint(
      e.toString(),
    );
  }
}
