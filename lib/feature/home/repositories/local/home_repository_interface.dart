import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kobeur/feature/home/domain/tourist/add_fav_or_remove_fav_response_model.dart';
import 'package:kobeur/feature/home/domain/tourist/rate_a_local_response_model.dart';

abstract class HomeRepositoryInterface {
  Future<Response> updateOffer({
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
  });
  Future<Response> getHome();
  Future<Response> getBookingDetails(String tripId);
  Future<Response> getBookings(String status);
  Future<Response> getBookingsAll();
  Future<Response> cencelBookings(String id);
  //
  // ************ tourist ************ //
  //
  Future<Response> getSuperHatch();
  Future<Response> getFavoriteHatch();
  Future<Response> searchOffer(
    String country,
    String date,
    String participants,
    String languages,
    String offerType,
  );
  Future<Response> getOfferDetails(String localId, String offerId);
  Future<Response> getLocalDetails(String localId);
  Future<Response> addFavOrRemove(String localId);
  Future<Response> getFav();
  Future<Response> rateALocal(String localId, String comment, String rating);
  
  Future<Response> cancelTrip(String localId);
}
