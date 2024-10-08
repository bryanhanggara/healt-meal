import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/filter_food_controller.dart';

class MeatListView extends StatefulWidget {
  const MeatListView({super.key});

  @override
  State<MeatListView> createState() => _MeatListViewState();
}

class _MeatListViewState extends State<MeatListView> {
  @override
  Widget build(BuildContext context) {
    final String category = Get.arguments;
    final FilterFoodController controller = Get.put(FilterFoodController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal For $category"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FutureBuilder(
              future: controller.getMealsByCategory(category),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData && snapshot.data != null) {
                  final meals = snapshot.data as List;
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                width: double.infinity,
                                height: double.infinity,
                                meals[index]['strMealThumb'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  meals[index]['strMeal'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No meals found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
