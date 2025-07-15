import 'package:flutter/material.dart';
import 'package:kobeur/core/themes/app_color.dart';

import '../../themes/text_style.dart';

extension ButtonStyleExtensions on BuildContext {
  Widget primaryButton({
    required VoidCallback onPressed,
    required String text,
    double? width,
    double? height,
    bool isLoading = false,
    IconData? icon,
    double borderRadius = 8,
    Color? backgroundColor,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 51,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          foregroundColor: Colors.black,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: AppText.mdMedium_16.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'outfit',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (icon != null) ...[
                      SizedBox(width: 8),
                      Icon(icon, size: 20, color: Colors.black),
                    ],
                  ],
                ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    this.text = 'Message Local',
    this.height = 51,
    this.width,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Center(
          child: Text(
            text,
            style: AppText.mdMedium_16.copyWith(
              color: AppColors.primaryColor,
              fontSize: fontSize ?? 16,
              fontFamily: 'outfit',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shevaandrii/core/themes/app_colors.dart';
// import 'package:shevaandrii/core/themes/text_style.dart';

// extension ButtonStyleExtensions on BuildContext {
//   Widget primaryButton({
//     required VoidCallback onPressed,
//     required String text,
//     double? width,
//     double? height,
//     bool isLoading = false,
//     IconData? icon,
//     double borderRadius = 12,

//   }) {
//     return SizedBox(
//       width: width ?? 250,
//       height: height ?? 48,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.buttonbackgroundcolor,
//           foregroundColor: Colors.black,
//           elevation: 2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(64),
//           ),
//         ),
//         child:
//             isLoading
//                 ? SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                   ),
//                 )
//                 : Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       text,
//                       style: AppText.mdMedium_16.copyWith(color: Colors.black),
//                     ),
//                     if (icon != null) ...[
//                       SizedBox(width: 8),
//                       Icon(icon, size: 20, color: Colors.black),
//                     ],
//                   ],
//                 ),
//       ),
//     );
//   }
// }

// Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               child: context.primaryButton(
//                 onPressed: () {
//                   if (_selectedProfile != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Scaffold()),
//                     );
//                   } else {
//                     setState(() {
//                       _showProfileError = true;
//                     });
//                   }
//                 },
//                 text: "Continue",
//                 backgroundColor: _selectedProfile != null
//                     ? AppColors.primaryColor
//                     : Colors.black,
//               ),
//             ),
