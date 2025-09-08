import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kobeur/core/extensions/text_extensions.dart';
import 'package:kobeur/core/themes/app_color.dart';
import 'package:kobeur/feature/chat/tourist/message/presentation/screens/chat_screen.dart';
import 'package:kobeur/feature/profile/controllers/profile_controller.dart';
import 'package:kobeur/feature/profile/domain/model/get_profile_response_model.dart';
import '../../../../../core/common/button/button_widget.dart';
import '../../../../trip_module/presentation/screens/local/booking_details_screen.dart';
import '../../../../trip_module/presentation/widgets/upcoming_cart_widget.dart';
import '../../../controllers/local_home_controller.dart';

class HomeScreenLocal extends StatefulWidget {
  const HomeScreenLocal({super.key});

  @override
  State<HomeScreenLocal> createState() => _HomeScreenLocalState();
}

class _HomeScreenLocalState extends State<HomeScreenLocal> {
  late LocalHomeController localHomeController;
  late ProfileController profileController;
  String? liveTripId;
  // String? totalPrice;

  @override
  void initState() {
    super.initState();
    localHomeController = Get.find<LocalHomeController>();
    profileController = Get.find<ProfileController>();
    profileController.getUserProfile();

    _initializeHomeData();

    print(
      "Home Screen (initState): ${localHomeController.getHomeResponseModel.data?.upcomingTrips.length}",
    );
  }

  Future<void> _initializeHomeData() async {
    await localHomeController.getHome();
    setState(() {
      liveTripId = localHomeController.getHomeResponseModel.data?.liveTrip?.id;
      if (liveTripId != null) {
        localHomeController.getBookingDetails(liveTripId!);
      }
    });
    print(
      "Home Screen (initState): Upcoming Trips: ${localHomeController.getHomeResponseModel.data?.upcomingTrips.length ?? 0}",
    );
    print(
      "Home Screen (initState): Total Tours: ${localHomeController.getHomeResponseModel.data?.totalTours ?? 0}",
    );
  }

  String formatTripDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "0:00 AM, 00/00/00";
    }

    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      String formattedDate = DateFormat(
        "h:mm a, dd/MM/yy",
      ).format(parsedDate.toLocal());
      return formattedDate;
    } catch (e) {
      return "0:00 AM, 00/00/00";
    }
  }

  // String totalPrice(String pricePerPerson, String participants) {
  //   int total = int.parse(pricePerPerson) * int.parse(participants);
  //   return total.toString();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return GetBuilder<LocalHomeController>(
          builder: (localHomeController) {
            final bookingDetails =
                localHomeController.getBookingDetailsResponseModel.data;
            print("Booking Details: $bookingDetails");

            return localHomeController.isLoading && profileController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Scaffold(
                  backgroundColor: const Color(0xFFF5F5F5),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey[200],
                                child: Obx(
                                  () => ClipOval(
                                    child:
                                        (profileController.image.value !=
                                                    null &&
                                                (profileController
                                                        .getProfileResponseModel
                                                        ?.data
                                                        ?.profileImage
                                                        ?.isNotEmpty ??
                                                    false))
                                            ? Image.network(
                                              profileController.image.value,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Image.asset(
                                                  'assets/images/profileBlankImage.png',
                                                  fit: BoxFit.cover,
                                                  width: 70,
                                                  height: 70,
                                                );
                                              },
                                            )
                                            : Image.asset(
                                              'assets/images/profileBlankImage.png',
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                            ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  " ${profileController.name.value ?? 'No Name'}"
                                      .text22Black700(),
                                  "${profileController.nationality.value ?? 'Nationality'}"
                                      .text14Grey(),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// Stats Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _StatCard(
                                  image: 'assets/icons/dolar.png',
                                  label: "Earnings",
                                  value:
                                      "\$${localHomeController.getHomeResponseModel.data?.earnings.toString() ?? 'no data'}",

                                  subText: "All time",
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _StatCard(
                                  image: 'assets/icons/totalTour.png',
                                  label: "Total Tour",
                                  value:
                                      "${localHomeController.getHomeResponseModel.data?.totalTours.toString() ?? 'no data'}",
                                  subText: "All time",
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: _StatCard(
                                  image: 'assets/icons/starIcon.png',
                                  label: "Rating",
                                  value:
                                      "${localHomeController.getHomeResponseModel.data?.averageRating ?? 'no data'}",
                                  subText: "5.0",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          "Live Trip".text20Black700(),

                          const SizedBox(height: 12),

                          //                       Column(
                          //   children: bookingDetailsList != null && bookingDetailsList!.isNotEmpty
                          //       ? bookingDetailsList!.map((booking) {
                          //           return Padding(
                          //             padding: const EdgeInsets.only(bottom: 12),
                          //             child: GestureDetector(
                          //               onTap: () => Get.to(() => BookingDetailsScreen(
                          //                     bookingDetails: booking,
                          //                   )),
                          //               child: BookingCard(
                          //                 name: booking.touristName ?? 'No Name',
                          //                 country: booking.touristCountry ?? 'No Data',
                          //                 imageUrl: 'assets/images/user.png',
                          //                 category: booking.offerId?.category ?? 'No Category',
                          //                 dateTime: formatTripDate(booking.date),
                          //                 people:
                          //                     '${booking.participants?.toString().padLeft(2, '0')} People',
                          //                 price:
                          //                     "\$${booking.offerId?.pricePerPerson?.toStringAsFixed(2) ?? '0.00'}",
                          //                 actionButton: SecondaryButton(
                          //                   text: "Message Tourist",
                          //                   onPressed: () => Get.to(() => ChatScreen()),
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         }).toList()
                          //       : [
                          //           Center(
                          //             child: Text(
                          //               "No bookings found",
                          //               style: TextStyle(color: Colors.grey),
                          //             ),
                          //           ),
                          //         ],
                          // )
                          GestureDetector(
                            onTap:
                                () => Get.to(
                                  () => BookingDetailsScreen(
                                    bookingDetails: bookingDetails,
                                  ),
                                ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: BookingCard(
                                    name:
                                        "${bookingDetails?.touristName} " ??
                                        'No Name',
                                    country:
                                        "${bookingDetails?.touristCountry} " ??
                                        'No data',
                                    //
                                    // need to image add
                                    imageUrl: 'assets/images/user.png',
                                    category:
                                        "${bookingDetails?.offerId?.category}",

                                    dateTime: formatTripDate(
                                      bookingDetails?.date,
                                    ),

                                    people:
                                        '${bookingDetails?.participants?.toString().padLeft(2, '0')} People' ??
                                        'No Data',
                                    // people: '04 People',
                                    price:
                                        "\$${bookingDetails?.offerId!.pricePerPerson?.toStringAsFixed(2) ?? 'no data'}",
                                    actionButton: SecondaryButton(
                                      text: "Message Tourist",
                                      onPressed: () {
                                        Get.to(() => ChatScreen());
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
          },
        );
      },
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
