import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TabChip(label: 'Upcoming', selected: true),
          const SizedBox(width: 8),
          _TabChip(label: 'Completed'),
          const SizedBox(width: 8),
          _TabChip(label: 'Cancelled'),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.4,
      height: 25,
      decoration: BoxDecoration(
        color: selected ? AppColors.context(context).primaryColor : Color(0xFFBFBFBF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
