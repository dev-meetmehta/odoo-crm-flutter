import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:employee/app/modules/details/controllers/details_controller.dart';
import 'package:employee/app/modules/details/views/details_view.dart';
import 'package:employee/app/modules/history/views/history_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
            actions: [
              GestureDetector(
                child: Container(child: Icon(Icons.history)),
                onTap: (() => Get.to(() => HistoryView())),
              )
            ],
            centerTitle: true,
          ),
          body: Container(
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    width: Get.width,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: TextField(
                      controller: controller.textEditingController,
                      decoration: InputDecoration(
                          prefix: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.blue))),
                      onChanged: (query) {
                        final suggestions =
                            controller.list_of_employee.where((pet) {
                          final petname = pet.name.toLowerCase();
                          final input = query.toLowerCase();
                          return petname.contains(input);
                        }).toList();
                        controller.displayedemployee = suggestions;
                        controller.displayedemployee.forEach((element) {
                          print(element.name);
                        });
                        controller.update();
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.displayedemployee.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  height: 100,
                                  width: Get.width,
                                  color: (controller.displayedemployee[index]
                                                  .left ==
                                              0 &&
                                          controller.displayedemployee[index]
                                                  .timeInCompany >
                                              5)
                                      ? Colors.green.shade100
                                      : Colors.blue.shade100,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Text("Work with us "+controller
                                              .displayedemployee[index].timeInCompany.toString()+ " years" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                                      Container(
                                          child: Text("Employee: "+ controller
                                              .displayedemployee[index].name , style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
                                      (controller.displayedemployee[index]
                                                  .left ==
                                              1)
                                          ? Container(
                                              child: Text("Already Left", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.red)))
                                          : Container()
                                    ],
                                  )),
                              onTap: (controller
                                          .displayedemployee[index].left ==
                                      0)
                                  ? () {
                                      DetailsController detailsController =
                                          Get.put(DetailsController());
                                      detailsController.indexOfPet = index;
                                      detailsController.employee =
                                          controller.displayedemployee[index];

                                      Get.to(() => DetailsView());
                                    }
                                  : () {},
                            ),
                            Container(
                              height: 10,
                              width: Get.width,
                            )
                          ],
                        );
                        // title: ,
                        // trailing: ,
                        // onTap:
                        // );
                      },
                    ),
                  ),
                ],
              )));
    });
  }
}
