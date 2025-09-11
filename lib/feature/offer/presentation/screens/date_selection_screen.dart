import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/feature/offer/presentation/screens/service_complete_screen.dart';

class DateSelectionScreen extends StatefulWidget {
  @override
  _DateSelectionScreenState createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  DateTime currentMonth = DateTime(2025, 12, 1);
  List<DateTime> selectedDates = [];
  List<String> selectedSlots = [];

  // Predefined slots
  final Map<String, List<String>> timeSlots = {
    "Morning": [
      "6:00 AM",
      "7:00 AM",
      "8:00 AM",
      "9:00 AM",
      "10:00 AM",
      "11:00 AM",
    ],
    "Afternoon": [
      "12:00 PM",
      "1:00 PM",
      "2:00 PM",
      "3:00 PM",
      "4:00 PM",
      "5:00 PM",
    ],
    "Evening": ["6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM"],
  };

  String get selectedRange {
    if (selectedDates.isEmpty) return "";
    selectedDates.sort((a, b) => a.compareTo(b));
    final start = selectedDates.first;
    final end = selectedDates.last;
    return "${start.day} ${_monthName(start.month)} ${start.year} - "
        "${end.day} ${_monthName(end.month)} ${end.year}";
  }

  String _monthName(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80), // leave space for button
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(color: Colors.black),
                        'Manage Availability'.text22Black700(),
                        const SizedBox(width: 50),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.chevron_left),
                                onPressed: () {
                                  setState(() {
                                    currentMonth = DateTime(
                                      currentMonth.year,
                                      currentMonth.month - 1,
                                    );
                                  });
                                },
                              ),
                              Text(
                                "${_monthName(currentMonth.month)} ${currentMonth.year}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.chevron_right),
                                onPressed: () {
                                  setState(() {
                                    currentMonth = DateTime(
                                      currentMonth.year,
                                      currentMonth.month + 1,
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Selected Date Range
                        if (selectedRange.isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              selectedRange,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    // Calendar Header

                    // Calendar
                    Container(
                      height: size.height * 0.35,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Weekdays
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children:
                                  ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                                      .map(
                                        (day) => Expanded(
                                          child: Center(
                                            child: Text(
                                              day,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Calendar Grid
                          Expanded(child: _buildCalendarGrid()),
                        ],
                      ),
                    ),
                    if (selectedRange.isNotEmpty)
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: selectedRange.text20Black700(),
                      ),
                    // Time Slots
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children:
                            timeSlots.keys.map((section) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children:
                                        timeSlots[section]!.map((slot) {
                                          final isSelected = selectedSlots
                                              .contains(slot);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedSlots.remove(slot);
                                                } else {
                                                  selectedSlots.add(slot);
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: (size.width) * .45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color:
                                                      isSelected
                                                          ? Colors.red
                                                          : Colors.grey[400]!,
                                                ),
                                                color:
                                                    isSelected
                                                        ? Colors.red
                                                            .withOpacity(0.1)
                                                        : Colors.transparent,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 18,
                                                    color:
                                                        isSelected
                                                            ? Colors.red
                                                            : Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    slot,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          isSelected
                                                              ? Colors.red
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Next Button (pinned at bottom)
            Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      selectedSlots.isNotEmpty
                          ? () => Get.to(ServiceCompleteScreen())
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isSelected = selectedDates.any(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedDates.removeWhere(
                  (d) =>
                      d.year == date.year &&
                      d.month == date.month &&
                      d.day == date.day,
                );
              } else {
                selectedDates.add(date);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFFFFE1E5) : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Color(0xFFFF3951) : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: dayWidgets,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/offer/presentation/screens/service_complete_screen.dart';

// class DateSelectionScreen extends StatefulWidget {
//   @override
//   _DateSelectionScreenState createState() => _DateSelectionScreenState();
// }

// class _DateSelectionScreenState extends State<DateSelectionScreen> {
//   DateTime currentMonth = DateTime(2025, 12, 1);
//   List<DateTime> selectedDates = [];
//   List<String> selectedSlots = [];

//   // Predefined slots
//   final Map<String, List<String>> timeSlots = {
//     "Morning": [
//       "6:00 AM",
//       "7:00 AM",
//       "8:00 AM",
//       "9:00 AM",
//       "10:00 AM",
//       "11:00 AM",
//     ],
//     "Afternoon": [
//       "12:00 PM",
//       "1:00 PM",
//       "2:00 PM",
//       "3:00 PM",
//       "4:00 PM",
//       "5:00 PM",
//     ],
//     "Evening": ["6:00 PM", "7:00 PM", "8:00 PM", "9:00 PM"],
//   };

//   String get selectedRange {
//     if (selectedDates.isEmpty) return "";
//     selectedDates.sort((a, b) => a.compareTo(b));
//     final start = selectedDates.first;
//     final end = selectedDates.last;
//     return "${start.day} ${_monthName(start.month)} ${start.year} - ${end.day} ${_monthName(end.month)} ${end.year}";
//   }

//   String _monthName(int month) {
//     const months = [
//       "",
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ];
//     return months[month];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BackButton(color: Colors.black),
//                 'Manage Availability'.text22Black700(),
//                 const SizedBox(width: 50),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Calendar Header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.chevron_left),
//                     onPressed: () {
//                       setState(() {
//                         currentMonth = DateTime(
//                           currentMonth.year,
//                           currentMonth.month - 1,
//                         );
//                       });
//                     },
//                   ),
//                   Text(
//                     "${_monthName(currentMonth.month)} ${currentMonth.year}",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.chevron_right),
//                     onPressed: () {
//                       setState(() {
//                         currentMonth = DateTime(
//                           currentMonth.year,
//                           currentMonth.month + 1,
//                         );
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Selected Date Range
//             if (selectedRange.isNotEmpty)
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Text(
//                   selectedRange,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),

//             // Calendar
//             Container(
//               height: 250,
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   // Weekdays
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       children:
//                           ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
//                               .map(
//                                 (day) => Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       day,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                     ),
//                   ),
//                   SizedBox(height: 10),

//                   // Calendar Grid
//                   Expanded(child: _buildCalendarGrid()),
//                 ],
//               ),
//             ),

//             // Time Slots
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 children:
//                     timeSlots.keys.map((section) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             section,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Wrap(
//                             spacing: 12,
//                             runSpacing: 12,
//                             children:
//                                 timeSlots[section]!.map((slot) {
//                                   final isSelected = selectedSlots.contains(
//                                     slot,
//                                   );
//                                   return GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         if (isSelected) {
//                                           selectedSlots.remove(slot);
//                                         } else {
//                                           selectedSlots.add(slot);
//                                         }
//                                       });
//                                     },
//                                     child: Container(
//                                       width: 140,
//                                       height: 45,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                           color:
//                                               isSelected
//                                                   ? Colors.red
//                                                   : Colors.grey[400]!,
//                                         ),
//                                         color:
//                                             isSelected
//                                                 ? Colors.red.withOpacity(0.1)
//                                                 : Colors.transparent,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(
//                                             Icons.access_time,
//                                             size: 18,
//                                             color:
//                                                 isSelected
//                                                     ? Colors.red
//                                                     : Colors.grey[600],
//                                           ),
//                                           const SizedBox(width: 6),
//                                           Text(
//                                             slot,
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                               color:
//                                                   isSelected
//                                                       ? Colors.red
//                                                       : Colors.black,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       );
//                     }).toList(),
//               ),
//             ),

//             // Next Button
//             Container(
//               padding: EdgeInsets.all(20),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed:
//                       selectedSlots.isNotEmpty
//                           ? () => Get.to(ServiceCompleteScreen())
//                           : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     disabledBackgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     'Next',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalendarGrid() {
//     final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
//     final lastDayOfMonth = DateTime(
//       currentMonth.year,
//       currentMonth.month + 1,
//       0,
//     );
//     final firstWeekday = firstDayOfMonth.weekday;
//     final daysInMonth = lastDayOfMonth.day;

//     List<Widget> dayWidgets = [];

//     for (int i = 1; i < firstWeekday; i++) {
//       dayWidgets.add(Container());
//     }

//     for (int day = 1; day <= daysInMonth; day++) {
//       final date = DateTime(currentMonth.year, currentMonth.month, day);
//       final isSelected = selectedDates.any(
//         (d) =>
//             d.year == date.year && d.month == date.month && d.day == date.day,
//       );

//       dayWidgets.add(
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               if (isSelected) {
//                 selectedDates.removeWhere(
//                   (d) =>
//                       d.year == date.year &&
//                       d.month == date.month &&
//                       d.day == date.day,
//                 );
//               } else {
//                 selectedDates.add(date);
//               }
//             });
//           },
//           child: Container(
//             margin: EdgeInsets.all(0),
//             decoration: BoxDecoration(
//               color: isSelected ? Color(0xFFFFE1E5) : Colors.transparent,
//               borderRadius: BorderRadius.circular(1),
//             ),
//             child: Center(
//               child: Text(
//                 day.toString(),
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: isSelected ? Color(0xFFFF3951) : Colors.black,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return GridView.count(
//       crossAxisCount: 7,
//       padding: EdgeInsets.all(16),
//       children: dayWidgets,
//       physics: NeverScrollableScrollPhysics(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kobeur/core/extensions/text_extensions.dart';
// import 'package:kobeur/feature/offer/presentation/screens/service_complete_screen.dart';

// class DateSelectionScreen extends StatefulWidget {
//   @override
//   _DateSelectionScreenState createState() => _DateSelectionScreenState();
// }

// class _DateSelectionScreenState extends State<DateSelectionScreen> {
//   DateTime currentMonth = DateTime(2025, 12, 1);
//   List<DateTime> selectedDates = [];

//   @override
//   void initState() {
//     super.initState();
//     // Pre-select some dates as shown in the image
//     selectedDates = [
//       DateTime(2025, 12, 25),
//       DateTime(2025, 12, 26),
//       DateTime(2025, 12, 27),
//       DateTime(2025, 12, 28),
//       DateTime(2025, 12, 29),
//       DateTime(2025, 12, 30),
//       DateTime(2025, 12, 31),
//       DateTime(2026, 1, 1),
//       DateTime(2026, 1, 2),
//       DateTime(2026, 1, 3),
//       DateTime(2026, 1, 4),
//       DateTime(2026, 1, 5),
//       DateTime(2026, 1, 6),
//       DateTime(2026, 1, 7),
//       DateTime(2026, 1, 8),
//       DateTime(2026, 1, 9),
//       DateTime(2026, 1, 10),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 BackButton(color: Colors.black),
//                 'Manage Availability'.text22Black700(),
//                 SizedBox(width: 50),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Calendar Header
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.chevron_left),
//                     onPressed: () {
//                       setState(() {
//                         currentMonth = DateTime(
//                           currentMonth.year,
//                           currentMonth.month - 1,
//                         );
//                       });
//                     },
//                   ),
//                   Text(
//                     'Dec 2025',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.chevron_right),
//                     onPressed: () {
//                       setState(() {
//                         currentMonth = DateTime(
//                           currentMonth.year,
//                           currentMonth.month + 1,
//                         );
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Selected Date Range
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Text(
//                 'Dec 25 - 10 Dec 25',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),

//             // Calendar
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     // Week days header
//                     Row(
//                       children:
//                           ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
//                               .map(
//                                 (day) => Expanded(
//                                   child: Center(
//                                     child: Text(
//                                       day,
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                     ),
//                     SizedBox(height: 10),

//                     // Calendar Grid
//                     Expanded(child: _buildCalendarGrid()),
//                   ],
//                 ),
//               ),
//             ),

//             Container(
//               padding: EdgeInsets.all(20),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed:
//                       selectedDates.isNotEmpty
//                           ? () => Get.to(ServiceCompleteScreen())
//                           : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     disabledBackgroundColor: Colors.grey[300],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     'Next',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalendarGrid() {
//     final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
//     final lastDayOfMonth = DateTime(
//       currentMonth.year,
//       currentMonth.month + 1,
//       0,
//     );
//     final firstWeekday = firstDayOfMonth.weekday;
//     final daysInMonth = lastDayOfMonth.day;

//     List<Widget> dayWidgets = [];

//     // Add empty cells for days before the first day of the month
//     for (int i = 1; i < firstWeekday; i++) {
//       dayWidgets.add(Container());
//     }

//     // Add days of the month
//     for (int day = 1; day <= daysInMonth; day++) {
//       final date = DateTime(currentMonth.year, currentMonth.month, day);
//       final isSelected = selectedDates.any(
//         (selectedDate) =>
//             selectedDate.year == date.year &&
//             selectedDate.month == date.month &&
//             selectedDate.day == date.day,
//       );

//       dayWidgets.add(
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               if (isSelected) {
//                 selectedDates.removeWhere(
//                   (selectedDate) =>
//                       selectedDate.year == date.year &&
//                       selectedDate.month == date.month &&
//                       selectedDate.day == date.day,
//                 );
//               } else {
//                 selectedDates.add(date);
//               }
//             });
//           },
//           child: Container(
//             margin: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               color: isSelected ? Colors.red : Colors.transparent,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(
//                 day.toString(),
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: isSelected ? Colors.white : Colors.black,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return GridView.count(crossAxisCount: 7, children: dayWidgets);
//   }
// }
