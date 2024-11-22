// property_details.dart

class PropertyDetails {
  // Owner details
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zip;
  final String country;
  final String description;
  final String contact;
  final String date;

  // Property details
  final String placeType;
  final String sharingType;
  final String roomsAvailable;
  final String furnishingType;
  final String availableFor;

  final List<String> amenities;
  final double rentSliderValue;

  // Image data (if any) can be added here

  PropertyDetails({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zip,
    required this.country,
    required this.description,
    required this.contact,
    required this.date,
    required this.placeType,
    required this.sharingType,
    required this.roomsAvailable,
    required this.furnishingType,
    required this.availableFor,
    required this.amenities,
    required this.rentSliderValue,
  });
}
