import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';

class FormatTripDateText extends StatelessWidget {
  final String? dateStr;
  final TextStyle? style;

  const FormatTripDateText({super.key, required this.dateStr, this.style});

  String _formatTripDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "0:00 AM, 00/00/00";
    }

    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat("h:mm a, dd/MM/yy").format(parsedDate.toLocal());
    } catch (e) {
      return "0:00 AM, 00/00/00";
    }
  }

  @override
  Widget build(BuildContext context) {
    return _formatTripDate(dateStr).text14Black();
    // Text(
    //   _formatTripDate(dateStr),
    //   style:
    //       style ??
    //       const TextStyle(
    //         fontSize: 14,
    //         color: Colors.black87,
    //         fontWeight: FontWeight.w500,
    //       ),
    // );
  }
}
