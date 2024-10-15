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
  // Mulai proses insert ke tabel medicine
  try {
    // Memasukkan data medicine ke tabel Medicine
    await db.insertMedicine(Medicine(name: name, frequency: frequency));

    // Mengambil ID terakhir dari medicine yang baru saja dimasukkan
    var lastMedicineId = await db.getLastMedicineId();

    // Dapatkan database yang sudah diinisialisasi
    final database = await db.database;

    // Mulai batch untuk melakukan banyak insert sekaligus
    final batch = database.batch();

    // Memasukkan data notifikasi sesuai dengan frekuensi yang dimasukkan
    for (int i = 1; i <= frequency; i++) {
      batch.insert(
        'medicine_notification', // Nama tabel notifikasi
        MedicineNotification(
          idMedicine: lastMedicineId, // ID obat yang terkait
          time: timeController[i].text, // Waktu notifikasi
        ).toJson(), // Data dalam bentuk map
      );
    }

    // Jalankan semua insert dalam batch sekaligus
    await batch.commit(noResult: true);

    // Mendapatkan notifikasi yang baru saja dimasukkan berdasarkan ID Medicine
    List<MedicineNotification> notifications =
        await db.getNotificationsByMedicineId(lastMedicineId);

    // Menjadwalkan notifikasi untuk setiap waktu yang telah dimasukkan
    for (var element in notifications) {
      var timeParts = element.time.split(':');
      // Mengubah waktu notifikasi menjadi TimeOfDay
      NotificationApi.scheduleNotification(
        id: element.id!,
        title: "Waktunya minum obat $name",
        body: "Minum obat agar cepat sembuh :)",
        payload: name,
        scheduleDate: TimeOfDay(
          hour: int.parse(timeParts[0]), // Jam dari waktu notifikasi
          minute: int.parse(timeParts[1]), // Menit dari waktu notifikasi
        ),
      );
    }

    // Memperbarui data medicine di homeController setelah proses insert selesai
    homeController.getAllMedicineData();

    // Kembali ke halaman sebelumnya setelah berhasil menambahkan data
    Get.back();
  } catch (e) {
    print("Error while adding medicine and notifications: $e");
    // Kamu bisa menambahkan error handling yang lebih baik di sini
  }
}

}
