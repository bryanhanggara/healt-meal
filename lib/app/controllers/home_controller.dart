import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:myapp/app/helper/dbHelper.dart';
import 'package:myapp/models/medicine_model.dart';

class HomeController extends GetxController with StateMixin<List<Medicine>> {
  var db = Dbhelper();
  List<Medicine> listMedicines = <Medicine>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllMedicineData();
  }

  Future getAllMedicineData() async {
    change(null, status: RxStatus.loading());
    listMedicines.clear();
    final List<Medicine> medicines = await db.queryAllRowsMedicine();
    listMedicines.addAll(medicines);
    if (listMedicines.isEmpty) {
      change(null, status: RxStatus.empty());
    } else {
      change(listMedicines, status: RxStatus.success());
    }
  }
}