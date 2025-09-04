import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/home/domain/local/get_home_response_model.dart';
import 'package:kobeur/feature/home/domain/local/update_offer_response_model.dart';
import 'package:kobeur/feature/home/services/local/local_home_service_interface.dart';

class LocalHomeController extends GetxController implements GetxService {
  final localHomeController = Get.find<LocalHomeController>();

  final LocalHomeServiceInterface localHomeServiceInterface;

  LocalHomeController({required this.localHomeServiceInterface});

  UpdateOfferResponseModel updateOfferResponseModel =
      UpdateOfferResponseModel();
  GetHomeResponseModel getHomeResponseModel = GetHomeResponseModel();

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
    } catch (e) {}
  }

  Future<void> getHome() async {
    try {
      isLoading = true;
      update();

      final response = await localHomeServiceInterface.getHome();

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("✅ Home for local fetched successfully\n");
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
    update();
  }
}
