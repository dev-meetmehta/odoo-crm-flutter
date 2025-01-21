import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:employee/app/modules/home/controllers/home_controller.dart';
import 'package:employee/app/modules/imageview/controllers/imageview_controller.dart';
import 'package:employee/app/modules/imageview/views/imageview_view.dart';
import 'package:employee/app/modules/secure_storage.dart';

import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsController>(
        // stream: null,
        builder: (controller) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('DetailsView'),
              centerTitle: true,
            ),
            body: Column(children: [
              GestureDetector(
                onTap: () {
                  ImageviewController imageviewController =
                      Get.put(ImageviewController());
                  imageviewController.petUrl = controller.employee!.image;
                  Get.to(() => ImageviewView());
                },
                child: Container(
                  width: Get.width,
                  child:
                      CachedNetworkImage(imageUrl: controller.employee!.image,
                          height: 400),
                ),
              ),
              Container(
                // width: 100,
                child: Text(
                    "Name: ${Get.find<HomeController>().list_of_employee[controller.indexOfPet].name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              Container(
                // width: 100,
                child: Text(
                    "Age: ${Get.find<HomeController>().list_of_employee[controller.indexOfPet].age.toString()}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              Container(
                // width: 100,
                child: Text(
                    "Salary: Rs. ${Get.find<HomeController>().list_of_employee[controller.indexOfPet].salary}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              Container(
                // width: 100,
                child: Text(
                    "Time In Company: ${Get.find<HomeController>().list_of_employee[controller.indexOfPet].timeInCompany}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              ),
              (Get.find<HomeController>()
                          .displayedemployee[controller.indexOfPet]
                          .left ==
                      0)
                  ? GestureDetector(
                      onTap: () async {
                        Get.find<HomeController>()
                            .displayedemployee[controller.indexOfPet]
                            .left = 1;
                        Get.find<HomeController>().adopted_employee += " " +
                            Get.find<HomeController>()
                                .list_of_employee[controller.indexOfPet]
                                .name;
                        await SecureStorage.save("PetHistory",
                            Get.find<HomeController>().adopted_employee);
                        Get.find<HomeController>().adoptingPet(
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .name,
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .age,
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .salary,
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .left,
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .image,
                            Get.find<HomeController>()
                                .displayedemployee[controller.indexOfPet]
                                .timeInCompany);
                        Get.find<HomeController>().getData();
                        // controller.petname = Get.find<HomeController>()
                        //     .list_of_employee[controller.indexOfPet]
                        //     .name;
                        // controller.confettiController.play();
                        Get.defaultDialog(
                            title: "Employee Left",
                            middleText:
                                "${Get.find<HomeController>().displayedemployee[controller.indexOfPet].name} has left the company",
                            barrierDismissible: false,
                            onCancel: () {
                              // controller.confettiController.stop();
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "Leave",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  : GestureDetector(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(color: Colors.red, width: 3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text("Already Left",
                              style: TextStyle(color: Colors.white))),
                    )
            ]),
          ),
          ConfettiWidget(
            confettiController: controller.confettiController,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 80,
            emissionFrequency: 0.2,
            minBlastForce: 10,
            maxBlastForce: 100,
          ),
        ],
      );
    });
  }
}
