import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/constants/splash_screen.dart';
import 'package:kobeur/core/services/profile_storage_service.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import 'package:kobeur/feature/auth/presentation/screens/common/tourist_or_local_screen.dart';
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
  //final authController = Get.find<AuthController>();

  bool isLoading = true;
  bool? isFirstTime;
  String? userRole;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    setState(() => isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime!) {
      await prefs.setBool('first_time', false);
      Get.lazyPut(() => ProfileStorageService());
    }

    final authController = Get.find<AuthController>();
    isLoggedIn = authController.isLoggedIn();

    debugPrint('isFirstTime: $isFirstTime, isLoggedIn: $isLoggedIn');

    if (isLoggedIn) {
      await _loadUserRole();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadUserRole() async {
    await profileController.getUserProfile();
    userRole = profileController.getProfileResponseModel?.data?.role;
    debugPrint('Loaded User Role: $userRole');
  }

  // Call this after login to reload role
  // Future<void> reloadAfterLogin() async {
  //   setState(() => isLoading = true);
  //   await _loadUserRole();
  //   setState(() => isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SplashScreen();

      //      BottomNavbar();
    }

    return GetBuilder<AuthController>(
      builder: (authController) {
        debugPrint(
          'isFirstTime: $isFirstTime, isLoggedIn: ${authController.isLoggedIn()}, userRole: $userRole',
        );

        if (isFirstTime!) {
          const SplashScreen();
        }

        if (isFirstTime! && authController.isLoggedIn()) {
          debugPrint('First time user, redirecting to TouristORLocalScreen\n');
          return const TouristORLocalScreen();
        } else if (authController.isLoggedIn()) {
          userRole =
              profileController.getProfileResponseModel?.data?.role
                  ?.toLowerCase();
          // userRole = profileController.userRole.toString().toLowerCase();
          // profileController.getUserRole();
          // reload user role if not loaded yet2
          // if (userRole == null) {
          //   _loadUserRole().then((_) {
          //     setState(() {}); // refresh after role is fetched
          //   });
          //   return const SplashScreen(); // temporary loader until role is fetched
          // }
          debugPrint('User is logged in, userRole: $userRole \n');
          if (userRole.toString().toLowerCase() == 'local') {
            return BottomNavbar();
          } else if (userRole.toString().toLowerCase() == 'tourist') {
            return CreateFirstServiceScreen();
          } else {
            debugPrint('User role is null, redirecting to SelectRoleScreen\n');
            return const TouristORLocalScreen();
          }
        }
        return UserLoginScreen();
      },
    );
  }
}




// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final profileController = Get.find<ProfileController>();
//   bool isLoading = true;
//   String? userRole;

//   bool? isFirstTime;

//   @override
//   void initState() {
//     super.initState();
//     _checkFirstTime();
//     _loadUserProfile();
//   }

//   void _loadUserProfile() async {
//     await profileController.getUserProfile();
//     userRole = profileController.getProfileResponseModel?.data?.role;
//     print('User Role: $userRole');
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> _checkFirstTime() async {
//     final prefs = await SharedPreferences.getInstance();

//     // Get first time install flag
//     isFirstTime = prefs.getBool('first_time') ?? true;

//     if (isFirstTime!) {
//       // Mark as not first time anymore
//       await prefs.setBool('first_time', false);

//       // Register storage service for first time setup
//       Get.lazyPut(() => ProfileStorageService());
//     }

//     // Done loading
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       // Show loading while checking SharedPreferences
//       return SplashScreen();
//     }

//     return GetBuilder<AuthController>(
//       builder: (authController) {
//         if (userRole == null) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (isFirstTime!) {
//           return const SplashScreen();
//         } else if (authController.isLoggedIn()) {
//           debugPrint('User is logged in, navigating to BottomNavbar');
//           return userRole == 'local'
//               ? const BottomNavbar() // Local user → go to BottomNavbar
//               : const UserLoginScreen();
//         } else {
//           return const UserLoginScreen(); // Not logged in → go to login screen
//         }
//       },
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Your imports
// import 'package:kobeur/core/constants/splash_screen.dart';
// import 'package:kobeur/core/services/profile_storage_service.dart';
// import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
// import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
// import 'package:kobeur/feature/auth/presentation/screens/common/user_login_screen.dart';
// import 'package:kobeur/feature/auth/presentation/screens/common/tourist_or_local_screen.dart';
// import 'package:kobeur/feature/offer/presentation/screens/create_first_service_screen.dart';
// import 'package:kobeur/navigation/bottom_navigationber_screen.dart';
// import 'package:kobeur/helpers/dependency_injection.dart';

// // 🔹 This function decides which page to show
// Future<Widget> whichPage() async {
//   final authController = Get.find<AuthController>();
//   final profileController = Get.find<ProfileController>();

//   if (authController.isLoggedIn()) {
//     await profileController.getUserProfile();
//     final userRole = profileController.getProfileResponseModel?.data?.role;
//     debugPrint('User is logged in, userRole: $userRole');

//     if (userRole != null && userRole.toLowerCase() == 'local') {
//       return BottomNavbar();
//     } else if (userRole != null && userRole.toLowerCase() == 'tourist') {
//       return CreateFirstServiceScreen();
//     } else {
//       debugPrint('User role is null or unknown, redirecting to SelectRoleScreen');
//       return const TouristORLocalScreen();
//     }
//   }

//   return UserLoginScreen();
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDI(); // Dependency injection
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Kobeur',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffF5F5F5)),
//       ),
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool isLoading = true;
//   bool? isFirstTime;
//   Widget? nextScreen;

//   @override
//   void initState() {
//     super.initState();
//     _initApp();
//   }

//   Future<void> _initApp() async {
//     final prefs = await SharedPreferences.getInstance();
//     isFirstTime = prefs.getBool('first_time') ?? true;

//     if (isFirstTime!) {
//       await prefs.setBool('first_time', false);
//       Get.lazyPut(() => ProfileStorageService());
//     }

//     // Get the correct page from whichPage()
//     nextScreen = await whichPage();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       // Show splash until we know where to go
//       return const SplashScreen(nextScreen: TouristORLocalScreen());
//     }

//     // Show splash for 3 seconds, then go to the decided page
//     return SplashScreen(nextScreen: nextScreen!);
//   }
// }

