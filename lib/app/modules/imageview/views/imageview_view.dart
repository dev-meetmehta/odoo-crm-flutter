import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/imageview_controller.dart';

class ImageviewView extends GetView<ImageviewController> {
  const ImageviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageviewController>(
        // stream: null,
        builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ImageviewView'),
          centerTitle: true,
        ),
        body: GestureDetector(
          onDoubleTapDown: (details) => controller.tapDownDetails = details,
          onDoubleTap: () {
            final double scale = 3;
            final position = controller.tapDownDetails!.localPosition;

            final x = -position.dx * (scale - 1);
            final y = -position.dy * (scale - 1);
            final zoomed = Matrix4.identity()
              ..translate(x, y)
              ..scale(scale);
            final value = controller.transformationcontroller.value.isIdentity()
                ? zoomed
                : Matrix4.identity();
            controller.transformationcontroller.value = value;
          },
          child: InteractiveViewer(
            transformationController: controller.transformationcontroller,
            clipBehavior: Clip.none,
            panEnabled: false,
            child: AspectRatio(
              aspectRatio: 0.5,
              child: Image.network(controller.petUrl),
            ),
          ),
        ),
      );
    });
  }
}
