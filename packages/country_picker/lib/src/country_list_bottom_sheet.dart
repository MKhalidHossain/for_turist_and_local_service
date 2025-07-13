// import 'package:flutter/material.dart';

// import 'country.dart';
// import 'country_list_theme_data.dart';
// import 'country_list_view.dart';

// class CountryPickerScreenLikeBottomSheet extends StatelessWidget {

//   final  ValueChanged<Country> onSelect;
//   final VoidCallback? onClosed;
//   final List<String>? favorite;
//   final List<String>? exclude;
//   final List<String>? countryFilter;
//   final bool showPhoneCode ;
//   final CustomFlagBuilder? customFlagBuilder ;
//   final CountryListThemeData? countryListTheme;
//   final  bool searchAutofocus ;
//   final bool showWorldWide ;
//   final bool showSearch ;
//   final bool moveAlongWithKeyboard ;

//   const CountryPickerScreenLikeBottomSheet({super.key, 
//   required this.onSelect, 
//   this.onClosed, 
//   this.favorite, 
//   this.exclude, 
//   this.countryFilter,
//   required this.showPhoneCode,
//   this.customFlagBuilder, 
//   this.countryListTheme, 
//   this.searchAutofocus=false, 
//   this.showWorldWide=false,
//   this.showSearch =true,
//   this.moveAlongWithKeyboard =false,
//       });
//  @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final statusBarHeight = MediaQuery.of(context).padding.top;

//     final height = countryListTheme?.bottomSheetHeight ??
//         deviceHeight - (statusBarHeight + (kToolbarHeight / 1.5));
//     final width = countryListTheme?.bottomSheetWidth;

//     Color? backgroundColor = countryListTheme?.backgroundColor ??
//         Theme.of(context).bottomSheetTheme.backgroundColor ??
//         (Theme.of(context).brightness == Brightness.light
//             ? Colors.white
//             : Colors.black);

//     final BorderRadius borderRadius = countryListTheme?.borderRadius ??
//         const BorderRadius.only(
//           topLeft: Radius.circular(40.0),
//           topRight: Radius.circular(40.0),
//         );

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         title: const Text("Select Country"),
//         backgroundColor: backgroundColor,
//         elevation: 0,
//         foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             onClosed?.call();
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: moveAlongWithKeyboard
//             ? MediaQuery.of(context).viewInsets
//             : EdgeInsets.zero,
//         child: Container(
//           height: height,
//           width: width,
//           padding: countryListTheme?.padding,
//           margin: countryListTheme?.margin,
//           decoration: BoxDecoration(
//             color: backgroundColor,
//             borderRadius: borderRadius,
//           ),
//           child: CountryListView(
//             onSelect: (country) {
//               onSelect(country);
//               Navigator.pop(context);
//             },
//             exclude: exclude,
//             favorite: favorite,
//             countryFilter: countryFilter,
//             showPhoneCode: showPhoneCode,
//             countryListTheme: countryListTheme,
//             searchAutofocus: searchAutofocus,
//             showWorldWide: showWorldWide,
//             showSearch: showSearch,
//             customFlagBuilder: customFlagBuilder,
//           ),
//         ),
//       ),
//     );
//   }
// }