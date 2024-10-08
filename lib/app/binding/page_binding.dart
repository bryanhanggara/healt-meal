import 'package:get/get.dart';
import 'package:myapp/app/controllers/filter_food_controller.dart';
import 'package:myapp/app/controllers/food_controller.dart';
import 'package:myapp/app/controllers/login_controller.dart';
import 'package:myapp/app/controllers/register_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodController>(() => FoodController());
  }
}

class FilterFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterFoodController>(() => FilterFoodController());
  }
}
