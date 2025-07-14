import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/feature/auth/presentation/screens/tourist_or_local_screen.dart';
import 'core/services/profile_storage_service.dart';
import 'feature/auth/controllers/auth_controller.dart';
import 'helpers/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDI();
  if (!Get.find<AuthController>().isFirstTimeInstall()) {
    print("object ---------------000000000000-----------------");

    

    Get.find<AuthController>().setFirstTimeInstall();
    Get.lazyPut(() => ProfileStorageService());
  } else {
    print("object ---------------11111111111-----------------");
  }

  Get.put(AppBarTheme());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffF5F5F5)),
      ),
      home:
          TouristORLocalScreen(),
          //UserLoginScreen(),

      // SpokenLanguageScreen(),
    );
  }
}
