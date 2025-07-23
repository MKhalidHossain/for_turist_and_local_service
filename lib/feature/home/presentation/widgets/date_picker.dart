import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomStyledCalendar extends StatefulWidget {
  final void Function(String) onDateSelected;

  const CustomStyledCalendar({Key? key, required this.onDateSelected})
    : super(key: key);

  @override
  State<CustomStyledCalendar> createState() => _CustomStyledCalendarState();
}

class _CustomStyledCalendarState extends State<CustomStyledCalendar> {
  DateTime currentMonth = DateTime.now();
  DateTime? selectedDate;

  final List<String> weekDays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    String formatted = DateFormat('dd/MM/yy').format(date);
    widget.onDateSelected(formatted);
  }

  List<List<DateTime?>> _generateCalendar(DateTime month) {
    List<List<DateTime?>> calendar = [];
    DateTime firstDay = DateTime(month.year, month.month, 1);
    int firstWeekday = firstDay.weekday;
    DateTime startDay = firstDay.subtract(Duration(days: firstWeekday - 1));

    for (int i = 0; i < 6; i++) {
      List<DateTime?> week = [];
      for (int j = 0; j < 7; j++) {
        DateTime day = startDay.add(Duration(days: i * 7 + j));
        if (day.month == month.month || day.isAtSameMomentAs(firstDay)) {
          week.add(day);
        } else {
          week.add(null); // For empty slots
        }
      }
      calendar.add(week);
    }
    return calendar;
  }

  @override
  Widget build(BuildContext context) {
    final calendar = _generateCalendar(currentMonth);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _previousMonth,
                    icon: const Icon(Icons.chevron_left, size: 26),
                  ),
                  Text(
                    DateFormat(
                      'MMM yyyy',
                    ).format(currentMonth), // Shows: Dec 2025
                    // DateFormat.yMMMM().format(currentMonth), // Dec 2025
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: _nextMonth,
                    icon: const Icon(Icons.chevron_right, size: 26),
                  ),
                ],
              ),
              // // Selected Date Badge
              if (selectedDate != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffFFC2C9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      DateFormat('EEE, MMM d').format(selectedDate!),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
              //const SizedBox(height: 8),
            ],
          ),
          const SizedBox(height: 8),

          // // Selected Date Badge
          // if (selectedDate != null)
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 12,
          //         vertical: 4,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.pinkAccent,
          //         borderRadius: BorderRadius.circular(20),
          //       ),
          //       child: Text(
          //         DateFormat('EEE, MMM d').format(selectedDate!),
          //         style: const TextStyle(color: Colors.white, fontSize: 12),
          //       ),
          //     ),
          //   ),
          // const SizedBox(height: 8),

          // Week Days Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                weekDays
                    .map(
                      (day) => Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 8),

          // Dates Grid
          Column(
            children:
                calendar.map((week) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        week.map((date) {
                          if (date == null) {
                            return const SizedBox(width: 40, height: 40);
                          }
                          bool isSelected = selectedDate == date;
                          bool isCurrentMonth =
                              date.month == currentMonth.month;

                          return GestureDetector(
                            onTap: () => _selectDate(date),
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Color(0xffFF3951)
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : isCurrentMonth
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
