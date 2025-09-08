import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/home/domain/local/cencel_booking_response_model.dart';

import 'package:kobeur/feature/home/domain/local/get_home_response_model.dart';
import 'package:kobeur/feature/home/domain/local/update_offer_response_model.dart';
import 'package:kobeur/feature/home/services/local/local_home_service_interface.dart';

import '../domain/local/get_booking_details_response_model.dart';
import '../domain/local/get_trip_response_api_bookings_model.dart';

class LocalHomeTripController extends GetxController implements GetxService {
  // final localHomeController = Get.find<LocalHomeController>();

  final LocalHomeServiceInterface localHomeServiceInterface;

  LocalHomeTripController(this.localHomeServiceInterface);

  UpdateOfferResponseModel updateOfferResponseModel =
      UpdateOfferResponseModel();
  GetHomeResponseModel getHomeResponseModel = GetHomeResponseModel();
  GetTripsDetailsResponseModel getBookingDetailsResponseModel =
      GetTripsDetailsResponseModel();
  GetTripResponseApiBookingsModel getTripResponseApiBookingsModel =
      GetTripResponseApiBookingsModel();
  CancelBookingResponseModel cancelBookingResponseModel =
      CancelBookingResponseModel();

  bool isLoading = false;

  Future<void> updateOffer({
    required String offerId,
    required String category,
    required String offerType,
    required String pricePerPerson,
    required String maxParticipants,
    required String title,
    required String description,
    required String availabilityDate,
    required XFile photos,
    required String availabilityTimeSlots,
  }) async {
    try {
      isLoading = true;
      update();

      print(
        "offerId: $offerId" +
            "category: $category" +
            "offerType: $offerType" +
            "pricePerPerson: $pricePerPerson" +
            "maxParticipants: $maxParticipants" +
            "title: $title" +
            "description: $description" +
            "availabilityDate: $availabilityDate" +
            "photos: $photos" +
            "availabilityTimeSlots: $availabilityTimeSlots",
      );

      final response = await localHomeServiceInterface.updateOffer(
        offerId: offerId,
        category: category,
        offerType: offerType,
        pricePerPerson: pricePerPerson,
        maxParticipants: maxParticipants,
        title: title,
        description: description,
        availabilityDate: availabilityDate,
        photos: photos,
        availabilityTimeSlots: availabilityTimeSlots,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Offer updated successfully from local \n");
        updateOfferResponseModel = UpdateOfferResponseModel.fromJson(
          response.body,
        );
        isLoading = false;
        update();
      } else {
        print("❌ Failed to update offer from local: ${response.statusCode}\n");
        Get.snackbar(
          "Error",
          "Failed to update offer: ${response.body['message']}",
        );
      }
    } catch (e) {
      print("⚠️ Error updating offer from local: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getHome() async {
    try {
      isLoading = true;
      update();

      final response = await localHomeServiceInterface.getHome();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getHome : for local fetched successfully\n");
        getHomeResponseModel = GetHomeResponseModel.fromJson(response.body);

        isLoading = false;
        update();
      }
    } catch (e) {
      print("⚠️ Error fetching profile: $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getBookingDetails(String tripId) async {
    try {
      isLoading = true;
      update();

      final response = await localHomeServiceInterface.getBookingDetails(
        tripId,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getBookingDetails: for local fetched successfully\n");
        getBookingDetailsResponseModel = GetTripsDetailsResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getBookingDetails : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getBookings(String status) async {
    try {
      isLoading = true;
      update();

      final response = await localHomeServiceInterface.getBookings(status);

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ getBookings : for local fetched successfully\n");
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);

        isLoading = false;
        update();
      } else {
        getTripResponseApiBookingsModel =
            GetTripResponseApiBookingsModel.fromJson(response.body);
      }
    } catch (e) {
      print("⚠️ Error fetching profile : getBookings : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> cencelBooking(String bookingId) async {
    try {
      isLoading = true;
      update();

      final response = await localHomeServiceInterface.cencelBookings(
        bookingId,
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ CancelBooking : for local fetched successfully\n");
        cancelBookingResponseModel = CancelBookingResponseModel.fromJson(
          response.body,
        );

        isLoading = false;
        update();
      } else if (response.statusCode == 400) {
        print(" Cannot cancel less than 24 hours before scheduled time\n");

        Get.snackbar(
          "less than 24 hours left",
          "Cannot cancel less than 24 hours before scheduled time",
        );
        cancelBookingResponseModel = CancelBookingResponseModel.fromJson(
          response.body,
        );
        isLoading = false;
        update();
      } else {
        print(
          " ❌ Error fetching LocalHomeController : cencelBooking : ${response.body['message']}\n",
        );
        Get.snackbar("error", "${response.body['message']}");
      }
    } catch (e) {
      print("⚠️ Error fetching LocalHomeController : cencelBooking : $e\n");
    } finally {
      isLoading = false;
      update();
    }
  }
}
