import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/home_controller.dart';
import 'package:myapp/app/helper/dbHelper.dart';
import 'package:myapp/app/utils/notification_api.dart';
import 'package:myapp/models/medicine_model.dart';
import 'package:myapp/models/notification.dart';


class AddScheduleController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController frequencyController;
  final List<TextEditingController> timeController =
      [TextEditingController()].obs;

  var db = Dbhelper();
  final frequency = 0.obs;

  HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    super.onInit();
    NotificationApi.init();

    nameController = TextEditingController();
    frequencyController = TextEditingController();
  }

  void add(String name, int frequency) async {
    await db.insertMedicine(Medicine(name: name, frequency: frequency));

    var lastMedicineId = await db.getLastMedicineId();

    for (int i = 1; i <= frequency; i++) {
      await db.insertNotification(MedicineNotification(
          idMedicine: lastMedicineId, time: timeController[i].text));
    }

    List<MedicineNotification> notifications =
        await db.getNotificationsByMedicineId(lastMedicineId);

    for (var element in notifications) {
      NotificationApi.scheduledNotification(
        id: element.id!,
        title: "Waktunya minum obat $name",
        body: "Minum obat agar cepat sembuh :)",
        payload: name,
        scheduledDate: TimeOfDay(
          hour: int.parse(element.time.split(':')[0]),
          minute: int.parse(element.time.split(':')[1]),
        ),
      ).then((value) => print("notif ${element.id} scheduled"));
    }

    homeController.getAllMedicineData();
    Get.back();
  }
}