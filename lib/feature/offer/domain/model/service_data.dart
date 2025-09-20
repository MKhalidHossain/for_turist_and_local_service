class ServiceData {
  static final ServiceData _instance = ServiceData._internal();
  factory ServiceData() => _instance;
  ServiceData._internal();

  // All service data in one place
  String? selectedCategory;
  String? selectedOfferType;
  String? selectedPrcing;
  String? selectedparticipants;
  String? userGivenOfferTitle;
  String? userGivenOfferDescription;
  List<String> uploadedPhotos = [];
  
  // Track selected dates
  List<DateTime> selectedDates = [];

  // Map each date to multiple selected time slots
  Map<DateTime, List<String>> selectedDateSlots = {};

  String? selectedTime; // optional, can be removed if using selectedDateSlots

  // Clear all data
  void clear() {
    selectedCategory = null;
    selectedOfferType = null;
    selectedPrcing = null;
    selectedparticipants = null;
    userGivenOfferTitle = null;
    userGivenOfferDescription = null;
    selectedTime = null;
    uploadedPhotos.clear();
    selectedDates.clear();
    selectedDateSlots.clear();
  }

  // Print current data (for debugging)
  void printData() {
    print('=== Service Data ===');
    print('Category: $selectedCategory');
    print('Offer: $selectedOfferType');
    print('Pricing: $selectedPrcing');
    print('Participants: $selectedparticipants');
    print('Title: $userGivenOfferTitle');
    print('Description: $userGivenOfferDescription');
    print('Time: $selectedTime');
    print('Photos: ${uploadedPhotos.length}');
    print('Dates: ${selectedDates.length}');
    print('Time Slots per Date:');
    selectedDateSlots.forEach((date, slots) {
      print('  ${date.toIso8601String()}: $slots');
    });
  }
}
