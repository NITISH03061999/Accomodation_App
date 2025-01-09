import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String cityId;
  final String cityName;

  City({
    required this.cityId,
    required this.cityName,
  });

  // Factory method to create a City object from a map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      cityId: map['cityId'] ?? '',
      cityName: map['cityName'] ?? '',
    );
  }
}

class CityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch cities and copy to a list
  Future<List<City>> fetchCities() async {
    List<City> cityList = [];

    try {
      QuerySnapshot snapshot = await _firestore.collection('city').get();

      for (var doc in snapshot.docs) {
        // Convert each document to a City object and add it to the list
        cityList.add(City.fromMap(doc.data() as Map<String, dynamic>));
        print(cityList);
      }
    } catch (e) {
      print('Error fetching cities: $e');
    }

    return cityList;
  }
}
