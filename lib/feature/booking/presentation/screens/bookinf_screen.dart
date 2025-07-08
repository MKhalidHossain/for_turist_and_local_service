import 'package:flutter/material.dart';

import '../../../../core/common/button/button_widget.dart';
import '../widgets/bookingtabber_widget.dart';
import '../widgets/upcoming_cart_widget.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('My Bookings', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          BookingTabBar(),
          const SizedBox(height: 12),


          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: 9,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => BookingCard(
                name: 'Jerome Bell',
                country: 'China',
                imageUrl: 'assets/images/user.png',
                category: 'Restaurant',
                dateTime: '9:00 AM, 11/06/25',
                people: '04 People',
                price: '\$125.00',
                actionButton: SecondaryButton(
                  onPressed: () {
                    // handle tap
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
