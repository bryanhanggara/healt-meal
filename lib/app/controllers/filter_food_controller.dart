import 'package:get/get.dart';
import 'package:myapp/models/filter_food_model.dart';
import 'package:myapp/provider/restaurant_provider.dart';

class FilterFoodController extends GetxController {
  Future<List<dynamic>> getMealsByCategory(String category) async {
    final data = await RestaurantProvider().getMealsByCategory(category);
    return data;
  }
}
