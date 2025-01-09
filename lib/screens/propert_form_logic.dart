import 'package:accomodation/modals/roomdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accomodation/modals/cities.dart';

class PropertyFormLogic {
  static final db = FirebaseFirestore.instance;
  PropertyFormLogic() {
    getcitiesdata();
  }
  static Future<void> getcitiesdata() async {
    try {
      final citydocs = await db.collection('City').get();
      cities = citydocs.docs.map((city) => City.fromMap(city.data())).toList();

      //print(cities.first.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  static List<City> cities = [];

  // FirebaseApp secondryapp = Firebase.app('secondryapp');
  // static final hdcDB = FirebaseFirestore.instanceFor(app: secondryapp);

  final List<String> placeTypes = ['House', 'PG', 'Guest House', 'Flat'];
  final List<String> sharingTypes = ['Single', 'Double', 'Triple', 'None'];
  final List<String> roomsAvailable = ['One', 'Two', 'Three', 'Four'];
  final List<String> furnishings = [
    'Unfurnished',
    'Semi Furnished',
    'Fully Furnished'
  ];

  final List<String> availableFor = ['Girls', 'Boys', 'Couple', 'Family'];
  final TextEditingController placenameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController selectedcityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController selectedrentController = TextEditingController();

  late DateTime? createdat = DateTime.now();
  String? updatedby;
  DateTime? updatedat;

  String? selectedPlaceType;
  String? selectedstate;

  String? selectedSharing;
  String? selectedRoomsAvailable;
  String? selectedFurnishing;
  String? selectedAvailabilityFor;
  String? createdby;
  String? selectedcity;
  String id = '';

  bool isactive = false;
  bool isverified = false;
  void main() {
// Print the current date and time
  }

  Map<String, bool> amenities = {
    'WIFI': false,
    'Food': false,
    'HouseKeeping': false,
    'Laundry': false,
    'Parking': false,
    'Television': false,
  };

  // ignore: prefer_typing_uninitialized_variables
  // static var property;

  // Future<void> addProperty() async {
  //   try {
  //     final property = PropertyDetails(
  //         id: DateTime.now().microsecondsSinceEpoch.toString(),
  //         placename: placenameController.text,
  //         name: nameController.text,
  //         email: emailController.text,
  //         address: addressController.text,
  //         zip: zipController.text,
  //         country: countryController.text,
  //         description: descriptionController.text,
  //         contact: contactController.text,
  //         placeType: selectedPlaceType ?? '',
  //         sharingType: selectedSharing ?? '',
  //         roomsAvailable: selectedRoomsAvailable ?? '',
  //         furnishingType: selectedFurnishing ?? '',
  //         availableFor: selectedAvailabilityFor ?? '',
  //         amenities: amenities.entries
  //             .where((MapEntry<String, bool> entry) => entry.value)
  //             .map((MapEntry<String, bool> entry) => entry.key)
  //             .toList(),
  //         selectedrent: selectedrentController.text,
  //         selectedstate: selectedstate ?? '',
  //         selectedcity: selectedcity ?? '',
  //         isactive: isactive,
  //         createdat: DateTime.now(),
  //         createdby: createdby,
  //         isverified: isverified,
  //         updatedat: DateTime.now(),
  //         updatedby: updatedby.toString());

  //     await db.collection('properties').add(property.toMap());
  //     print("Property added successfully");
  //   } catch (e) {
  //     print("Error adding property: $e");
  //   }
  // }

  void dispose() {
    placenameController.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    selectedcityController.dispose();
    zipController.dispose();

    countryController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    createdby = null;
    isverified = false;
    updatedat = null;
    updatedby = null;
    selectedrentController.dispose();
    isactive = false;
  }

  void clearForm() {
    // Clear text fields
    nameController.clear();
    emailController.clear();
    addressController.clear();
    zipController.clear();
    countryController.clear();
    descriptionController.clear();
    contactController.clear();
    dateController.clear();
    createdat = null;
    selectedrentController.dispose();

    createdby = null;

    updatedat = null;

    // Reset dropdown selections
    selectedPlaceType = null;
    selectedSharing = null;
    selectedRoomsAvailable = null;
    selectedFurnishing = null;
    selectedAvailabilityFor = null;
    selectedstate = null;
    selectedcity = null;

    // Reset amenities
    amenities.updateAll((key, value) => false);

    // Reset rent slider
  }
}
