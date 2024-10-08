import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/food_controller.dart';
import 'package:myapp/models/food_model.dart' as foodModel;

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  final FoodController controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FutureBuilder(
                future: controller.getFoods(),
                builder: (_, snapshot) {
                  var data = snapshot.data?.categories ?? [];
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (snapshot.hasData && data != null) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) => itemFood(data, index),
                      itemCount: data?.length,
                    );
                  } else {
                    return const Center(
                      child: Text("Data Kosong"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemFood(List<foodModel.Category>? data, int index) {
    var foodCategory = data![index];
    return GestureDetector(
      onTap: () {
        Get.toNamed('/filterByCategory', arguments: foodCategory.strCategory);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(
                foodCategory.strCategoryThumb,
                height: 100,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  foodCategory.strCategory,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  foodCategory.strCategoryDescription,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
