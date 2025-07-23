// import 'package:flutter/material.dart';

// import '../../../domain/model/offers_item.dart';

// class FoodOffersScreen extends StatefulWidget {
//   const FoodOffersScreen({super.key});

//   @override
//   State<FoodOffersScreen> createState() => _FoodOffersScreenState();
// }

// class _FoodOffersScreenState extends State<FoodOffersScreen> {
//   String? selectedOffer;

//   final List<OfferItem> offers = [
//     OfferItem(
//       'City Tour',
//       'Take tourists around the city and show them the most beautiful places',
//       Icons.location_city,
//       'city_tour',
//     ),
//     OfferItem(
//       'Food Tour',
//       'Show tourists the best local restaurants and street food',
//       Icons.restaurant,
//       'food_tour',
//     ),
//     OfferItem(
//       'Art Tour',
//       'Guide visitors through art galleries, museums, and cultural sites',
//       Icons.palette,
//       'art_tour',
//     ),
//     OfferItem(
//       'Sightseeing',
//       'Show tourists the most popular attractions and landmarks',
//       Icons.camera_alt,
//       'sightseeing',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Experience',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'What is your Offer?',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               itemCount: offers.length,
//               itemBuilder: (context, index) {
//                 final offer = offers[index];
//                 final isSelected = selectedOffer == offer.value;

//                 return Container(
//                   margin: EdgeInsets.only(bottom: 12),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedOffer = offer.value;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected ? Colors.red : Colors.grey[300]!,
//                           width: isSelected ? 2 : 1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 5,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color:
//                                   isSelected
//                                       ? Colors.red.withOpacity(0.1)
//                                       : Colors.grey[100],
//                               borderRadius: BorderRadius.circular(24),
//                             ),
//                             child: Icon(
//                               offer.icon,
//                               size: 24,
//                               color: isSelected ? Colors.red : Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   offer.title,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color:
//                                         isSelected ? Colors.red : Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   offer.description,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                     height: 1.3,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             width: 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.info_outline,
//                               size: 12,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(20),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed:
//                     selectedOffer != null
//                         ? () => Navigator.pushNamed(context, '/time-setting')
//                         : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                   disabledBackgroundColor: Colors.grey[300],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Next',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

