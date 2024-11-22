// property_form_logic.dart
import 'package:accomodation/modals/roomdetail.dart';
import 'package:accomodation/screens/AddedRooms.dart';
import 'package:flutter/material.dart';

class PropertyFormLogic {
  static final List<PropertyDetails> propertyList = [];

  // Dropdown lists
  final List<String> placeTypes = ['House', 'PG', 'Guest House', 'Flat'];
  final List<String> sharingTypes = ['Single', 'Double', 'Triple', 'None'];
  final List<String> roomsAvailable = ['One', 'Two', 'Three', 'Four'];
  final List<String> furnishings = [
    'Unfurnished',
    'Semi Furnished',
    'Fully Furnished'
  ];

  final List<String> availableFor = ['Girls', 'Boys', 'Couple', 'Family'];

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Selected values
  String? selectedPlaceType;
  String? selectedSharing;
  String? selectedRoomsAvailable;
  String? selectedFurnishing;
  String? selectedAvailabilityFor;

  // Amenities
  Map<String, bool> amenities = {
    'WIFI': false,
    'Food': false,
    'HouseKeeping': false,
    'Laundry': false,
    'Parking': false,
    'Television': false,
  };

  // Rent slider
  double rentSliderValue = 15000;

  static var property;

  void addProperty() {
    PropertyDetails property = PropertyDetails(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
      city: cityController.text,
      zip: zipController.text,
      country: countryController.text,
      description: descriptionController.text,
      contact: contactController.text,
      date: dateController.text,
      placeType: selectedPlaceType ?? '',
      sharingType: selectedSharing ?? '',
      roomsAvailable: selectedRoomsAvailable ?? '',
      furnishingType: selectedFurnishing ?? '',
      availableFor: selectedAvailabilityFor ?? '',
      amenities: amenities.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
      rentSliderValue: rentSliderValue,
    );

    propertyList.add(property);
  }

  List<PropertyDetails> getPropertyList() {
    return propertyList;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    countryController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    dateController.dispose();
  }

  void clearForm() {
    // Clear text fields
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    cityController.clear();
    zipController.clear();
    countryController.clear();
    descriptionController.clear();
    contactController.clear();
    dateController.clear();

    // Reset dropdown selections
    selectedPlaceType = null;
    selectedSharing = null;
    selectedRoomsAvailable = null;
    selectedFurnishing = null;
    selectedAvailabilityFor = null;

    // Reset amenities
    amenities.updateAll((key, value) => false);

    // Reset rent slider
    rentSliderValue = 15000;

    // Notify listeners if using a state management solution like Provider
    // For example: notifyListeners();
  }
}
