import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature/auth/controllers/auth_controller.dart';
import 'feature/auth/presentation/screens/user_login_screen.dart';
import 'helpers/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initDI();
    if (!Get.find<AuthController>().isFirstTimeInstall()) {
    print("object ---------------000000000000-----------------");

    Get.find<AuthController>().setFirstTimeInstall();
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
      home: UserLoginScreen(),
    );
  }
}
