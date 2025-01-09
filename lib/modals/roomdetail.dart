import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDetails {
  // Owner details
  final String placename;
  final String id;
  final String name;
  final String email;
  final String address;
  final String selectedstate;
  final String selectedcity;
  final String zip;
  final String country;
  final String description;
  final String contact;
  bool isactive = false;
  final DateTime? createdat; // not on ui
  bool isverified = false;
  final String? createdby; //userid aayegi isme
  final String? updatedby; //updated by who    not on ui
  DateTime? updatedat; //updated when date    not on ui

  // Property details
  final String placeType;
  final String sharingType;
  final String roomsAvailable;
  final String furnishingType;
  final String availableFor;
  final List<String> amenities;
  dynamic selectedrent;

  PropertyDetails({
    required this.placename,
    required this.id,
    required this.name,
    required this.email,
    required this.selectedstate,
    required this.address,
    required this.selectedcity,
    required this.zip,
    required this.country,
    required this.description,
    required this.contact,
    required this.placeType,
    required this.sharingType,
    required this.roomsAvailable,
    required this.furnishingType,
    required this.availableFor,
    required this.amenities,
    required this.selectedrent,
    required this.createdby, //userid aayegi isme
    required this.isactive,
    required this.isverified,
    required this.createdat, //date
    required this.updatedby, //updated by who
    required this.updatedat, //date
  });

  /// Converts the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'placename': placename,
      'name': name,
      'email': email,
      'state': selectedstate,
      'address': address,
      'selectedcity': selectedcity,
      'zip': zip,
      'country': country,
      'description': description,
      'contact': contact,
      'placeType': placeType,
      'sharingType': sharingType,
      'roomsAvailable': roomsAvailable,
      'furnishingType': furnishingType,
      'availableFor': availableFor,
      'amenities': amenities,
      'selectedrent': selectedrent,
      'isactive': isactive,
      'createdat': createdat != null ? Timestamp.fromDate(createdat!) : null,
      'updatedat': updatedat != null ? Timestamp.fromDate(updatedat!) : null,
      'isverified': isverified,
      'createdby': createdby,
      'updatedby': updatedby,
    };
  }

  /// Creates an instance from a Map
  factory PropertyDetails.fromMap(Map<String, dynamic> map) {
    //there is a doubt in it
    return PropertyDetails(
      placename: map['placename'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      selectedstate: map['state'] ?? '',
      address: map['address'] ?? '',
      selectedcity: map['city'] ?? '',
      zip: map['zip'] ?? '',
      country: map['country'] ?? '',
      description: map['description'] ?? '',
      contact: map['contact'] ?? '',
      placeType: map['placeType'] ?? '',
      sharingType: map['sharingType'] ?? '',
      roomsAvailable: map['roomsAvailable'] ?? '',
      furnishingType: map['furnishingType'] ?? '',
      availableFor: map['availableFor'] ?? '',
      amenities: List<String>.from(map['amenities'] ?? []),
      selectedrent: map['selectedrent'] != null,
      isactive: map['isactive'] ?? false,
      isverified: map['isverified'] ?? false,
      createdat: map['createdat'] != null
          ? (map['createdat'] as Timestamp).toDate()
          : null,
      updatedat: map['updatedat'] != null
          ? (map['updatedat'] as Timestamp).toDate()
          : null,
      createdby: map['createdby'] ?? '',
      updatedby: map['updatedby'] ?? '',
    );
  }
}
