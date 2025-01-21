import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageviewController extends GetxController {
  //TODO: Implement ImageviewController
  late TransformationController transformationcontroller =
      TransformationController();
  TapDownDetails? tapDownDetails;
  String petUrl = "";
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
