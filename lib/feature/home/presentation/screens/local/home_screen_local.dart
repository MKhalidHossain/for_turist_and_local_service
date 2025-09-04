import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/themes/app_color.dart';
import 'package:kobeur/feature/chat/tourist/message/presentation/screens/chat_screen.dart';
import '../../../../../core/common/button/button_widget.dart';
import '../../../../trip_module/presentation/screens/booking_details_screen.dart';
import '../../../../trip_module/presentation/widgets/upcoming_cart_widget.dart';

class HomeScreenLocal extends StatelessWidget {
  const HomeScreenLocal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Hello, User Name".text22Black700(),
                      "@username".text14Grey(),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.add, color: Colors.white, size: 36),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: _StatCard(
                      image: 'assets/icons/dolar.png',
                      label: "Earnings",
                      value: "\$5250",
                      subText: "All time",
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      image: 'assets/icons/totalTour.png',
                      label: "Total Tour",
                      value: "105",
                      subText: "All time",
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _StatCard(
                      image: 'assets/icons/starIcon.png',
                      label: "Rating",
                      value: "4.9",
                      subText: "5.0",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              "Live Trip".text20Black700(),

              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Get.to(() => BookingDetailsScreen()),
                child: Column(
                  children: List.generate(
                    2, // itemCount
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BookingCard(
                        name: 'Jerome Bell',
                        country: 'China',
                        imageUrl: 'assets/images/user.png',
                        category: 'Restaurant',
                        dateTime: '9:00 AM, 11/06/25',
                        people: '04 People',
                        price: '\$125.00',
                        actionButton: SecondaryButton(
                          text: "Message Tourist",
                          onPressed: () {
                            Get.to(() => ChatScreen());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Upcoming Trip + See All
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Upcoming Trip".text20Black700(),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// Upcoming Trip List
              GestureDetector(
                onTap: () => Get.to(() => BookingDetailsScreen()),
                child: Column(
                  children: List.generate(
                    3, // itemCount
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BookingCard(
                        name: 'Jerome Bell',
                        country: 'China',
                        imageUrl: 'assets/images/user.png',
                        category: 'Restaurant',
                        dateTime: '9:00 AM, 11/06/25',
                        people: '04 People',
                        price: '\$125.00',
                        actionButton: SecondaryButton(
                          text: "Message Tourist",
                          onPressed: () {
                            Get.to(() => ChatScreen());
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Column(
              //   children: List.generate(
              //     3,
              //     (index) => Padding(
              //       padding: const EdgeInsets.only(bottom: 12),
              //       child: TripCardWidget(
              //         name: "Kristin Watson",
              //         country: "China",
              //         category: "Restaurant",
              //         dateTime: "9:00 AM, 11/06/25",
              //         people: "04 People",
              //         price: "\$125.00",
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String image;
  final String label;
  final String value;
  final String subText;

  const _StatCard({
    required this.image,
    required this.label,
    required this.value,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon(iamge, color: AppColors.primaryColor, size: 18),
              Image.asset(image, height: 18, width: 18),
              const SizedBox(width: 6),
              label.text14Grey(),
              // Text(
              //   label,
              //   style: const TextStyle(
              //     fontSize: 12,
              //     color: Colors.grey,

              //     fontWeight: FontWeight.w500,
              //     fontFamily: 'Poppins',
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              if (subText.isNotEmpty) "/$subText".text10DarkGrey(),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------- Trip Card ----------------

class TripCardWidget extends StatelessWidget {
  final String name;
  final String country;
  final String category;
  final String dateTime;
  final String people;
  final String price;

  const TripCardWidget({
    super.key,
    required this.name,
    required this.country,
    required this.category,
    required this.dateTime,
    required this.people,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Avatar + Info + Price
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      country,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Date & People Row
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                dateTime,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                people,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => ChatScreen()),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Message Tourist"),
            ),
          ),
        ],
      ),
    );
  }
}
