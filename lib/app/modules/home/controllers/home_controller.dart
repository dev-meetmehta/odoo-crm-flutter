import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee/app/modules/details/controllers/details_controller.dart';
import 'package:employee/app/modules/home/singleEmployee.dart';
// import 'package:employee/app/modules/home/singlePet.dart';
import 'package:employee/app/modules/secure_storage.dart';

import '../../../sqflitehelper.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  List<singleEmployee> list_of_employee = [];
  List<singleEmployee> displayedemployee = [];
  List<singleEmployee> history_of_employee = [];
  bool fromDetails = false;
  String adopted_employee = " James Alex";
  final count = 0.obs;
  String name = "";
  String price = "";
  int age = 0;
  String image = "";
  TextEditingController textEditingController = new TextEditingController();
  @override
  Future<void> onInit() async {
    super.onInit();

    // initializinglist();
    // putDatainDatabase();
    await readingData();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  readingData() async {
    String? firstCheck = await SecureStorage.read('RanTheApp');
    if (firstCheck == null) {
      await SecureStorage.save('RanTheApp', 'Yes');
      await SecureStorage.save('PetHistory', ' James Alex');
      print('First Run  is this');
      initializinglist();
      putDatainDatabase();
      adopted_employee = " James Alex";
    } else if (firstCheck == 'Yes') {
      print('Not First Run');
      String? reademployee = await SecureStorage.read("PetHistory");
      if (reademployee != null) adopted_employee = reademployee;
    }
    print(adopted_employee);
  }

  initializinglist() {
    list_of_employee = [
      singleEmployee(
          "William",
          25,
          "10K",
          "https://img.freepik.com/premium-photo/portrait-school-boy-dressing-formally-black-suit-necktie-white-shirt-hands-pockets-young-handsome-college-student-standing-against-vintage-style-office-door-campus-looking-you_222877-12234.jpg?w=2000",
          0,
          4),
      singleEmployee(
          "Emma",
          29,
          "15K",
          "https://st3.depositphotos.com/14231584/19074/i/1600/depositphotos_190743088-stock-photo-beautiful-russian-business-girl-standing.jpg",
          0,
          8),
      singleEmployee(
          "James",
          31,
          "20K",
          "https://thumbs.dreamstime.com/z/young-school-boy-working-remotely-dressing-black-suit-necktie-young-businessman-sitting-railing-inside-vintage-style-100687354.jpg",
          1,
          3),
      singleEmployee(
          "Alex",
          30,
          "25K",
          "https://moiralizzie.com/wp-content/uploads/2019/07/CJPromWebslider5.jpg",
          0,
          7),
      singleEmployee(
          "Shobit",
          31,
          "35K",
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          0,
          8),
      singleEmployee(
          "Pragati",
          28,
          "45K",
          "https://images.pexels.com/photos/4347368/pexels-photo-4347368.jpeg?auto=compress&cs=tinysrgb&w=600",
          0,
          2),
    ];
  }

  putDatainDatabase() {
    list_of_employee.forEach((element) {
      _addItem(element.name, element.age, element.salary, element.left,
          element.image, element.timeInCompany);
    });
  }

  void increment() => count.value++;
  getData() async {
    final data = await SQLHelper.getItems();
    list_of_employee.clear();
    data.forEach((element) {
      list_of_employee.add(singleEmployee(
          element["name"],
          element["age"],
          element["salary"],
          element["image"],
          element["left"],
          element["timeincompany"]));
    });
    displayedemployee = list_of_employee;
    print('Data From The Database is:');
    print(data);
    if (fromDetails) Get.find<DetailsController>().update();
    update();
  }

  adoptingPet(String name, int age, String salary, int left, String image,
      int timeInCompany) {
    _updateItem(name, age, salary, left, image, timeInCompany);
  }

  Future<void> _addItem(var name, int age, var salary, int left, var image,
      int timeInCompany) async {
    await SQLHelper.createItem(name, age, salary, left, image, timeInCompany);
  }

// Update an existing journal
  Future<void> _updateItem(var name, int age, var salary, int left, var image,
      int timeInCompany) async {
    await SQLHelper.updateItem(name, age, salary, left, image, timeInCompany);
  }

// Delete an item
  void _deleteItem(var name) async {
    await SQLHelper.deleteItem(name);
  }

  Future<void> _deleteAll() async {
    await SQLHelper.deleteAll();
  }
}
