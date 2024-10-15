import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/detail_medicine_controller.dart';
import 'package:myapp/models/medicine_model.dart';
import 'package:myapp/models/notification.dart';

class DetailMedicinePage extends GetView<DetailMedicineController> {
  @override
  Widget build(BuildContext context) {
    final DetailMedicineController controller =
        Get.put(DetailMedicineController());

    final medicineId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Obat"),
      ),
      body: ListView(
        children: [
          FutureBuilder<Medicine>(
            future: controller.getMedicineData(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  title: Text(
                    snapshot.data!.name.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    "${snapshot.data!.frequency.toString()} kali sehari",
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          FutureBuilder<List<MedicineNotification>>(
            future: controller.getNotificationData(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].time),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('I don\'t need to take this medicine anymore'),
              onPressed: () {
                controller.deleteMedicine(Get.arguments);
              },
            ),
          ),
        ],
      ),
    );
  }
}
