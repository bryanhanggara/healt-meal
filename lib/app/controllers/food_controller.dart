import 'package:get/get.dart';
import 'package:myapp/models/food_model.dart';
import 'package:myapp/provider/restaurant_provider.dart';

class FoodController extends GetxController {
  Future<FoodModel> getFoods() async {
    final data = await RestaurantProvider().getFoods();
    return data;
  }
}
