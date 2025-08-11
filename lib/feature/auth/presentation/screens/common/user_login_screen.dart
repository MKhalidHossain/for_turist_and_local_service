// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/common/button/button_widget.dart';
// import 'package:kobeur/core/constants/app_colors.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
// import '../../../../../core/validation/validators.dart';
// import '../../../../../core/widgets/app_logo.dart';
// import '../../../../../core/widgets/app_scaffold.dart';
// import '../../../../../core/widgets/or_divider_with_circle_widget.dart';
// import '../../../../../helpers/custom_snackbar.dart';
// import 'forgot_password_screen.dart';
// import 'user_signup_screen.dart';

// class UserLoginScreen extends StatefulWidget {
//   const UserLoginScreen({super.key});

//   @override
//   State<UserLoginScreen> createState() => UserLoginScreenState();
// }

// class UserLoginScreenState extends State<UserLoginScreen> {
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final ScrollController _scrollController = ScrollController();

//   late TextEditingController _emailController;
//   late TextEditingController _passwordController;

//   @override
//   void initState() {
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();

//     // Add listener to scroll when keyboard appears
//     _emailFocus.addListener(_scrollToShowButton);
//     _passwordFocus.addListener(_scrollToShowButton);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocus.removeListener(_scrollToShowButton);
//     _passwordFocus.removeListener(_scrollToShowButton); // fixed
//     _emailFocus.dispose();
//     _passwordFocus.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToShowButton() {
//     if ((_emailFocus.hasFocus || _passwordFocus.hasFocus) &&
//         _scrollController.hasClients) {
//       // prevent crash
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GetBuilder<AuthController>(
//       builder: (authController) {
//         return AppScaffold(
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               return Column(
//                 children: [
//                   // Scrollable content (excluding Sign Up button)
//                   Expanded(
//                     child: SingleChildScrollView(
//                       controller: _scrollController,
//                       padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//                       ),
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           minHeight: constraints.maxHeight,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const SizedBox(height: 40),
//                               AppLogo(),
//                               const SizedBox(height: 32),
//                               Center(
//                                 child: Text(
//                                   'Welcome back',
//                                   style: TextStyle(
//                                     color: AppColors.context(context).textColor,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                               ),
//                               Center(
//                                 child: Text(
//                                   'sign in to access your account',
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 24),

//                               // Email Field
//                               TextFormField(
//                                 controller: _emailController,
//                                 focusNode: _emailFocus,
//                                 keyboardType: TextInputType.emailAddress,
//                                 decoration: InputDecoration(
//                                   prefixIcon: Padding(
//                                     padding: EdgeInsets.all(12.0),
//                                     child: Image.asset(
//                                       'assets/images/email.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                   ),
//                                   hintText: 'Email',
//                                   hintStyle: TextStyle(
//                                     color: AppColors.secondayText,
//                                   ),
//                                 ),
//                                 onFieldSubmitted:
//                                     (_) => FocusScope.of(
//                                       context,
//                                     ).requestFocus(_passwordFocus),
//                                 textInputAction: TextInputAction.next,
//                                 validator: Validators.email,
//                                 style: TextStyle(
//                                   color: AppColors.secondayText,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),

//                               const SizedBox(height: 16),

//                               // Password Field
//                               TextFormField(
//                                 controller: _passwordController,
//                                 focusNode: _passwordFocus,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   prefixIcon: Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: Image.asset(
//                                       'assets/images/password.png',
//                                       width: 24,
//                                       height: 24,
//                                     ),
//                                   ),
//                                   hintText: 'Password',
//                                   hintStyle: TextStyle(
//                                     color: AppColors.secondayText,
//                                   ),
//                                 ),
//                                 onFieldSubmitted:
//                                     (_) => FocusScope.of(context).unfocus(),
//                                 textInputAction: TextInputAction.done,
//                                 style: TextStyle(
//                                   color: AppColors.secondayText,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),

//                               const SizedBox(height: 8),

//                               // Forgot Password
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   onPressed:
//                                       () => Get.to(ForgotPasswordScreen()),
//                                   child: 'Forgot Password?'.text14Red(),
//                                 ),
//                               ),

//                               const SizedBox(height: 16),

//                               const SizedBox(height: 12),

//                                // Login button
//                             context.primaryButton(
//                               onPressed: () {
//                                 String email = _emailController.text;
//                                 String password = _passwordController.text;
//                                 if (email.isEmpty) {
//                                   showCustomSnackBar('email is required'.tr);
//                                 } else if (password.isEmpty) {
//                                   showCustomSnackBar('password_is_required'.tr);
//                                 } else if (password.length < 5) {
//                                   showCustomSnackBar(
//                                     'minimum password length is 8',
//                                   );
//                                 } else {
//                                   authController.login(email, password);
//                                 }

//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => BottomNavigationBar(),
//                                 //   ),
//                                 // );
//                               },
//                               text: "Login",
//                             ),

//                               /// Login button
//                               // context.primaryButton(
//                               //   onPressed: () async{
//                               //     String email = _emailController.text;
//                               //     String password = _passwordController.text;
//                               //     if (email.isEmpty) {
//                               //       showCustomSnackBar('email is required'.tr);
//                               //     } else if (password.isEmpty) {
//                               //       showCustomSnackBar(
//                               //         'password_is_required'.tr,
//                               //       );
//                               //     } else if (password.length < 5) {
//                               //       showCustomSnackBar(
//                               //         'minimum password length is 8',
//                               //       );
//                               //     } else {
//                               //       await authController.login(email, password);
//                               //     }

//                               //     // Navigator.push(
//                               //     //   context,
//                               //     //   MaterialPageRoute(
//                               //     //     builder: (context) => BottomNavigationBar(),
//                               //     //   ),
//                               //     // );
//                               //   },
//                               //   text: "Login",
//                               // ),

//                               const SizedBox(height: 24),
//                               OrDividerWithCircle(),
//                               const SizedBox(height: 16),

//                               // Google Sign In
//                               OutlinedButton.icon(
//                                 onPressed: () {},
//                                 icon: Image.asset(
//                                   'assets/images/google.png',
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                                 label: Text("Continue With Google"),
//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: Size(double.infinity, 48),
//                                   side: BorderSide(color: Colors.grey),
//                                 ),
//                               ),

//                               const SizedBox(height: 12),

//                               // Apple Sign In
//                               OutlinedButton.icon(
//                                 onPressed: () {},
//                                 icon: Image.asset(
//                                   'assets/images/apple.png',
//                                   height: 24,
//                                   width: 24,
//                                 ),
//                                 label: Text("Continue With Apple"),
//                                 style: OutlinedButton.styleFrom(
//                                   minimumSize: Size(double.infinity, 48),
//                                   side: BorderSide(color: Colors.grey),
//                                 ),
//                               ),

//                               // Add extra space at the bottom when keyboard is closed
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).viewInsets.bottom > 0
//                                         ? 0
//                                         : 60,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Fixed Sign Up Button (stays at bottom)
//                   Padding(
//                     padding: EdgeInsets.only(
//                       bottom:
//                           MediaQuery.of(context).viewInsets.bottom > 0
//                               ? MediaQuery.of(context).viewInsets.bottom
//                               : 16,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account? ",
//                           style: TextStyle(
//                             color: AppColors.primaryTextBlack,
//                             fontSize: 14,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => Get.to(UserSignupScreen()),
//                           child: Text(
//                             'Sign up',
//                             style: TextStyle(
//                               color: AppColors.context(context).primaryColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/core/constants/app_colors.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';
import '../../../../../core/validation/validators.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/or_divider_with_circle_widget.dart';
import '../../../../../helpers/custom_snackbar.dart';
import 'forgot_password_screen.dart';
import 'user_signup_screen.dart';

//import '../widgets/app_scaffold.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => UserLoginScreenState();
}

class UserLoginScreenState extends State<UserLoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(
      builder: (authController) {
        return AppScaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: size.height),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // 🔥 Center vertically
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            AppLogo(),
                            const SizedBox(height: 32),
                            Center(
                              child: Text(
                                'Welcome back',
                                style: TextStyle(
                                  color: AppColors.context(context).textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'sign in to access your account',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            const SizedBox(height: 12),

                            /// Email
                            TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/images/email.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                hint: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: AppColors.secondayText,
                                  ),
                                ),
                              ),
                              onFieldSubmitted:
                                  (_) => FocusScope.of(
                                    context,
                                  ).requestFocus(_passwordFocus),
                              textInputAction: TextInputAction.done,
                              validator: Validators.email,
                              style: TextStyle(
                                color: AppColors.secondayText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              autofillHints: const [AutofillHints.email],
                            ),

                            const SizedBox(height: 12),

                            /// Password
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/images/password.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                hint: Text(
                                  'Password',
                                  style: TextStyle(
                                    color: AppColors.secondayText,
                                  ),
                                ),
                              ),
                              obscureText: true,
                              onFieldSubmitted:
                                  (_) => FocusScope.of(
                                    context,
                                  ).requestFocus(_passwordFocus),
                              textInputAction: TextInputAction.done,
                              //validator: Validators.email,
                              style: TextStyle(
                                color: AppColors.secondayText,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              autofillHints: const [AutofillHints.email],
                            ),
                            const SizedBox(height: 12),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(ForgotPasswordScreen());
                                },
                                child: 'Forgot Password ?'.text14Red(),
                              ),
                            ),

                            const SizedBox(height: 12),

                            /// Login button
                            context.primaryButton(
                              onPressed: () {
                                String email = _emailController.text;
                                String password = _passwordController.text;
                                if (email.isEmpty) {
                                  showCustomSnackBar('email is required'.tr);
                                } else if (password.isEmpty) {
                                  showCustomSnackBar('password_is_required'.tr);
                                } else if (password.length < 5) {
                                  showCustomSnackBar(
                                    'minimum password length is 8',
                                  );
                                } else {
                                  authController.login(email, password);
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => BottomNavigationBar(),
                                //   ),
                                // );
                              },
                              text: "Login",
                            ),
                            const SizedBox(height: 16),
                            OrDividerWithCircle(),
                            const SizedBox(height: 16),

                            /// Google
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/google.png',
                                  height: 24,
                                  width: 24,
                                ),
                                label: Text(
                                  "Continue With Google",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.background,
                                  foregroundColor: AppColors.primaryTextBlack,
                                  elevation: 1,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            /// Apple
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/apple.png',
                                  height: 24,
                                  width: 24,
                                ),
                                label: Text(
                                  "Continue With Apple",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.background,
                                  foregroundColor: AppColors.primaryTextBlack,
                                  elevation: 1,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.primaryTextBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.context(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
