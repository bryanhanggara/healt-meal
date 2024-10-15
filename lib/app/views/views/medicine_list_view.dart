import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/home_controller.dart';

class MedicineListView extends GetView {
  final HomeController controller = Get.put(HomeController());
  MedicineListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicineListView'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) {
          if (state == null || state.isEmpty) {
            return Center(
              child: Text("TIdak Ada Data"),
            );
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state[index].name ?? "Tidak ada data"),
                subtitle:
                    Text("${state[index].frequency.toString()} kali sehari"),
                onTap: () =>
                    Get.toNamed('detail-medicine', arguments: state[index].id),
              );
            },
          );
        },
        onLoading: Center(child: CircularProgressIndicator()),
        onEmpty: Center(child: Text("Data Kosong")),
      ),
    );
  }
}
