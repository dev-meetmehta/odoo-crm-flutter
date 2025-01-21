import 'package:get/get.dart';
import 'package:employee/app/modules/secure_storage.dart';
import 'package:employee/app/sqflitehelper.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController
  List<List<String>>? employee;
  bool have_employee = false;
  List<String>? petUrl;
  final count = 0.obs;
  @override
  onInit() {
    super.onInit();
    get_history();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  get_history() async {
    String? petHistory = await SecureStorage.read("PetHistory");
    // print(petHistory);
    if (petHistory != null) {
      petUrl = petHistory.split(" ");
      // employee = petHistory.split(" ");
      // if (petUrl != null) {
      petUrl!.removeAt(0);
      petUrl!.forEach((element) async {
        print("element=");
        print(element);
        if (element != "") {
          var pet = await SQLHelper.getItem(element);
          print("pet=");
          print(pet);
          if (employee == null) {
            employee = [
              [element, pet[0]["image"]]
            ];
          } else {
            employee!.add([element, pet[0]["image"]]);
          }
        }
        print(employee);
        update();
      });
      // }
      // print(employee);
      // print('yesno');
      // update();
    }
    // print(employee);
    // print('yesno');
    // have_employee = true;
    // update();
  }

  void increment() => count.value++;
}
