import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/splash_screen.dart';
import 'package:kobeur/core/services/profile_storage_service.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/user_login_screen.dart';
import 'package:kobeur/helpers/dependency_injection.dart';
import 'package:kobeur/navigation/bottom_navigationber_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/offer/presentation/screens/create_first_service_screen.dart';
import 'feature/profile/controllers/profile_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  //final authController = Get.find<AuthController>();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isFirstTimeInstall;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kobeur',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF5F5F5)),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final profileController = Get.find<ProfileController>();
  bool isLoading = true;
  bool? isFirstTime;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;
    if (isFirstTime!) {
      await prefs.setBool('first_time', false);
      Get.lazyPut(() => ProfileStorageService());
    }

    final authController = Get.find<AuthController>();
    if (authController.isLoggedIn()) {
      await profileController.getUserProfile();
      userRole = profileController.getProfileResponseModel?.data?.role;
      debugPrint('User Role: $userRole');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading while checking SharedPreferences
      return const SplashScreen();
    }

    return GetBuilder<AuthController>(
      builder: (authController) {
        debugPrint(
          'isFirstTime: $isFirstTime, isLoggedIn: ${authController.isLoggedIn()}, userRole: $userRole',
        );

        if (isFirstTime!) {
          return const SplashScreen();
        }
        if (authController.isLoggedIn()) {
          debugPrint('User is logged in, userRole: $userRole');
          return userRole == 'local'
              ? const BottomNavbar()
              : CreateFirstServiceScreen();
        }
        return const UserLoginScreen();
      },
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/feature/auth/presentation/screens/common/description_screen.dart';
// import 'core/constants/splash_screen.dart';
// import 'core/services/profile_storage_service.dart';
// import 'feature/auth/controllers/auth_controller.dart';
// import 'feature/auth/presentation/screens/common/tourist_or_local_screen.dart';
// import 'feature/auth/presentation/screens/common/user_login_screen.dart';
// import 'feature/offer/presentation/details_offer_local.dart';
// import 'feature/profile/presentation/screens/profile_screen.dart';
// import 'helpers/dependency_injection.dart';
// import 'navigation/bottom_navigationber_screen.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();

// //   await initDI();
// //   if (!Get.find<AuthController>().isFirstTimeInstall()) {
// //     print("object ---------------000000000000-----------------");

// //     Get.find<AuthController>().setFirstTimeInstall();
// //     Get.lazyPut(() => ProfileStorageService());
// //   } else {
// //     print("object ---------------11111111111-----------------");
// //   }

// //   Get.put(AppBarTheme());
// //   runApp(MyApp());
// // }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDI();

//   final authController = Get.find<AuthController>();
//   final isFirstTime = await authController.isFirstTimeInstall();

//   if (isFirstTime) {
//     print("object ---------------000000000000-----------------");
//     await authController.setFirstTimeInstall();
//     Get.lazyPut(() => ProfileStorageService());
//   } else {
//     print("object ---------------11111111111-----------------");
//   }

//   runApp(MyApp(isFirstTimeInstall: isFirstTime));
// }

// class MyApp extends StatelessWidget {
//   final bool isFirstTimeInstall;

//   const MyApp({super.key, this.isFirstTimeInstall = false});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffF5F5F5)),
//       ),
//       home:
//           GetBuilder<AuthController>(
//             builder: (authController) {
//               print('isLoggedIn: ${authController.isLoggedIn()}, isFirstTimeInstall: $isFirstTimeInstall');
//               // return OnBoard();
//               if (authController.isLoggedIn()) {
//                 return BottomNavbar();
//               } else if (isFirstTimeInstall) {
//                 return UserLoginScreen();
//               } else {
//                 return SplashScreen();
//               }
//             },
//           ),




//           //  this things is for testing
//           // DetailsOfferLocal(),
//           // ProfileScreen(),
//          // BottomNavbar(),
//       //  TouristORLocalScreen(),
//       // UserLoginScreen(),
//       //DescriptionScreen(),
//       //CreateFirstServiceScreen(),
//       // BottomNavbar(),

//       //SpokenLanguageScreen(),
//     );
//   }
// }
