import 'package:get/get.dart';
import 'package:myapp/models/filter_food_model.dart';
import 'package:myapp/models/food_model.dart';

class RestaurantProvider extends GetConnect {
  Future<FoodModel> getFoods() async {
    final response =
        await get('https://www.themealdb.com/api/json/v1/1/categories.php');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return FoodModel.fromJson(response.body);
    }
  }

  Future<List<dynamic>> getMealsByCategory(String category) async {
    final response = await get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body['meals'];
    }
  }
}
