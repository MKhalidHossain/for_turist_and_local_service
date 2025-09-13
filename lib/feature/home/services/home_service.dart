import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/local/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  final HomeRepositoryInterface localHomeRepositoryInterface;

  HomeService(this.localHomeRepositoryInterface);

  @override
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
  }) async {
    return await localHomeRepositoryInterface.updateOffer(
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
  }

  @override
  Future<Response> getHome() async {
    return await localHomeRepositoryInterface.getHome();
  }

  @override
  Future<Response> getBookingDetails(String tripId) async {
    return await localHomeRepositoryInterface.getBookingDetails(tripId);
  }

  @override
  Future<Response> getBookingsAll() async {
    return await localHomeRepositoryInterface.getBookingsAll();
  }

  @override
  Future<Response> getBookings(String status) async {
    return await localHomeRepositoryInterface.getBookings(status);
  }

  @override
  Future<Response> cencelBookings(String id) async {
    return await localHomeRepositoryInterface.cencelBookings(id);
  }
  


   //
  // ************ tourist ************ //
  //
    @override
  Future<Response> getSuperHatch() async{
    return await localHomeRepositoryInterface.getSuperHatch();
  }
  
  @override
  Future<Response> addFavOrRemove(String localId) async{
    return await localHomeRepositoryInterface.addFavOrRemove(localId);
  }
  
  @override
  Future<Response> cancelTrip(String localId) async{
    return await localHomeRepositoryInterface.cancelTrip(localId);
  }
  
  @override
  Future<Response> getFav() async{
    return await localHomeRepositoryInterface.getFav();
  }
  
  @override
  Future<Response> getFavoriteHatch()async {
    return await localHomeRepositoryInterface.getFavoriteHatch();
  }
  
  @override
  Future<Response> getLocalDetails(String localId)async {
    return await localHomeRepositoryInterface.getLocalDetails(localId);
  }
  
  @override
  Future<Response> getOfferDetails(String localId, String offerId) async{
    return await localHomeRepositoryInterface.getOfferDetails(localId, offerId);
  }
  
  @override
  Future<Response> searchOffer(String country, String date, String participants, String languages, String offerType) async{
    return await localHomeRepositoryInterface.searchOffer(country, date, participants, languages, offerType);
  }
  
  @override
  Future<Response> rateALocal(String localId, String comment, String rating) async{
    return await localHomeRepositoryInterface.rateALocal(localId, comment, rating);
  }
}
