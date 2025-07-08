import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String country;
  final String imageUrl;
  final String category;
  final String dateTime;
  final String people;
  final String price;
  final Widget? actionButton;

  const BookingCard({
    super.key,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.category,
    required this.dateTime,
    required this.people,
    required this.price,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(imageUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(country, style: TextStyle(color: AppColors.secondayText)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(category,
                        style: TextStyle(color: AppColors.secondayText, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        color: AppColors.context(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: AppColors.primaryTextBlack),
              const SizedBox(width: 8),

                Text(dateTime,
                    style: TextStyle(color: AppColors.primaryTextBlack)),
                Spacer(),
                Icon(Icons.people_outline,
                    size: 16, color: AppColors.primaryTextBlack),
                SizedBox(width: 6),
                Text(people, style: TextStyle(color: AppColors.primaryTextBlack)),
              ],
            ),
            if (actionButton != null) ...[
              const SizedBox(height: 12),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}
