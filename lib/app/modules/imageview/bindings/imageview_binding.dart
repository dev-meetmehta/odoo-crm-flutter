import 'package:get/get.dart';

import '../controllers/imageview_controller.dart';

class ImageviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageviewController>(
      () => ImageviewController(),
    );
  }
}
