class City {
  final String cityId;
  final String cityName;
  final String createdBy;
  final String createdDate;
  final String createdTime;
  final bool isActive;
  final bool isVerified;
  final String pincode;
  final String state;

  City({
    required this.cityId,
    required this.cityName,
    required this.createdBy,
    required this.createdDate,
    required this.createdTime,
    required this.isActive,
    required this.isVerified,
    required this.pincode,
    required this.state,
  });

  // Factory method to create a City object from a map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityId: map['cityId'] ?? '',
      cityName: map['cityName'] ?? '',
      createdBy: map['createdBy'] ?? '',
      createdDate: map['createdDate'] ?? '',
      createdTime: map['createdTime'] ?? '',
      isActive: map['isActive'] ?? false,
      isVerified: map['isVerified'] ?? false,
      pincode: map['pincode'] ?? '',
      state: map['state'] ?? '',
    );
  }

  // Method to convert a City object to a map
  Map<String, dynamic> toMap() {
    return {
      'cityId': cityId,
      'cityName': cityName,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'createdTime': createdTime,
      'isActive': isActive,
      'isVerified': isVerified,
      'pincode': pincode,
      'state': state,
    };
  }
}
