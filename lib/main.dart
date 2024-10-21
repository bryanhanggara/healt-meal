import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/app/controllers/login_controller.dart';
import 'package:myapp/app/views/views/loading/loading_view.dart';
import 'package:myapp/routes/app_route.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authC = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    tz.initializeTimeZones();
    return StreamBuilder(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
              textTheme: GoogleFonts.outfitTextTheme().apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
            ),
            initialRoute: AppRoute.login,
            getPages: AppRoute.routes,
          );
        }
        return LoadingView();
      },
    );
  }
}
