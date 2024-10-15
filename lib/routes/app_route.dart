import 'package:get/get.dart';
import 'package:myapp/app/binding/page_binding.dart';
import 'package:myapp/app/views/views/add_schedule_view.dart';
import 'package:myapp/app/views/views/detail_medicine_view.dart';
import 'package:myapp/app/views/views/foods/filter_food_view.dart';
import 'package:myapp/app/views/views/foods/food_view.dart';
import 'package:myapp/app/views/views/home_view.dart';
import 'package:myapp/app/views/views/login_view.dart';
import 'package:myapp/app/views/views/medicine_list_view.dart';
import 'package:myapp/app/views/views/register_view.dart';

class AppRoute {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String food = '/food';
  static const String filterByCategory = '/filterByCategory';

  static final routes = [
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(
      name: register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    GetPage(
      name: food,
      page: () => FoodView(),
      binding: FoodBinding(),
    ),
    GetPage(
      name: filterByCategory,
      page: () => MeatListView(),
      binding: FilterFoodBinding(),
    ),
    GetPage(
      name: '/detail-medicine',
      page: () => DetailMedicinePage(),
    ),
    GetPage(
      name: '/add-schedule',
      page: () => AddScheduleView(),
    ),
    GetPage(
      name: '/list-medicine',
      page: () => MedicineListView(),
    ),
  ];
}
