import 'package:get/get.dart';
import 'package:myapp/app/controllers/home_controller.dart';
import 'package:myapp/app/helper/dbHelper.dart';
import 'package:myapp/app/utils/notification_api.dart';
import 'package:myapp/models/medicine_model.dart';
import 'package:myapp/models/notification.dart';

class DetailMedicineController extends GetxController {
  var db = Dbhelper();
  HomeController homeController = Get.put(HomeController());
  late List<MedicineNotification> listNotification;

  Future<Medicine> getMedicineData(int id) async {
    return await db.queryOnMedicine(id);
  }

  Future<List<MedicineNotification>> getNotificationData(int id) async {
    listNotification = await db.getNotificationsByMedicineId(id);
    return listNotification;
  }

  void deleteMedicine(int id) async {
  listNotification.forEach((element) {
    NotificationApi.cancelNotification(element.id!);
  });
  await db.deleteMedicine(id);
  await db.deleteNotificationByMedicineId(id);

  homeController.getAllMedicineData();
  Get.back();
}
}
