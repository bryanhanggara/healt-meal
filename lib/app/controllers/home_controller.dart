import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:myapp/app/helper/dbHelper.dart';
import 'package:myapp/models/medicine_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with StateMixin<List<Medicine>> {
  var db = Dbhelper();
  List<Medicine> listMedicines = <Medicine>[].obs;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  void logout() async {
    await auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedin', false);

    Get.offAllNamed('/login');
  }
}
