import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:kobeur/core/common/button/button_widget.dart';
import 'package:kobeur/feature/auth/controllers/auth_controller.dart';

import '../../../../core/themes/app_color.dart';

class ChangePassword extends StatefulWidget {
  final String userEmail;

  const ChangePassword({super.key, required this.userEmail});

  @override
  State<ChangePassword> createState() => _RestartPasswordState();
}

class _RestartPasswordState extends State<ChangePassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  bool _showNewPassword = false;
  bool _showRepeatPassword = false;

  final _formKey = GlobalKey<FormState>();

  bool get _passwordsMatch =>
      _newPasswordController.text.isNotEmpty &&
      _repeatPasswordController.text.isNotEmpty &&
      _newPasswordController.text == _repeatPasswordController.text;

  InputDecoration _buildInputDecoration({
    required String hintText,
    required Widget suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.secondayText),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.black, width: 1.2),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    );
  }

  void _updateState() => setState(() {});

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_updateState);
    _repeatPasswordController.addListener(_updateState);
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_updateState);
    _repeatPasswordController.removeListener(_updateState);
    // _newPasswordController.dispose();
    // _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: const BackButton(color: AppColors.primaryTextBlack),
        title: const Text(
          "Create new Password",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 32,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 32),

                              /// New Password
                              TextFormField(
                                controller: _newPasswordController,
                                obscureText: !_showNewPassword,
                                style: TextStyle(color: AppColors.secondayText),
                                decoration: _buildInputDecoration(
                                  hintText: "New Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _showNewPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.secondayText,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () =>
                                            _showNewPassword =
                                                !_showNewPassword,
                                      );
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),

                              /// Repeat Password
                              TextFormField(
                                controller: _repeatPasswordController,
                                obscureText: !_showRepeatPassword,
                                style: TextStyle(color: AppColors.secondayText),
                                decoration: _buildInputDecoration(
                                  hintText: "Repeat New Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _showRepeatPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.secondayText,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () =>
                                            _showRepeatPassword =
                                                !_showRepeatPassword,
                                      );
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please repeat your password';
                                  } else if (value !=
                                      _newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 32),

                              /// Continue Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 16,
                                ),
                                child: context.primaryButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (!_passwordsMatch) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Passwords do not match",
                                            ),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                        return;
                                      } else {
                                        print("EMAIL: ${widget.userEmail}");
                                        print(
                                          "PASS: ${_newPasswordController.text}",
                                        );
                                        print(
                                          "CONFIRM PASS: ${_repeatPasswordController.text}",
                                        );

                                        final String pass =
                                            _newPasswordController.text;
                                        final String repPass =
                                            _repeatPasswordController.text;
                                        authController.resetPassword(
                                          widget.userEmail,
                                          pass,
                                          repPass,
                                        );
                                      }

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Password changed successfully",
                                          ),
                                          backgroundColor: Colors.green,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                      // _newPasswordController.clear();
                                      // _repeatPasswordController.clear();
                                    }
                                  },
                                  text: "Continue",
                                  backgroundColor:
                                      _passwordsMatch
                                          ? AppColors.primaryColor
                                          : AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
