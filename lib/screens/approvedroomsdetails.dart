import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:accomodation/modals/roomdetail.dart';
import 'package:flutter/material.dart';

class Approvedroomsdetails extends StatelessWidget {
  final String propertyId; // Document ID of the property

  const Approvedroomsdetails({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('approvedproperties')
            .doc(propertyId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Property not found'));
          }

          final propertyData = snapshot.data!.data() as Map<String, dynamic>;
          final propertyDetails = PropertyDetails.fromMap(propertyData);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Property Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                buildDetailTile('Owner Name', propertyDetails.name),
                buildDetailTile('Email', propertyDetails.email),
                buildDetailTile('Address', propertyDetails.address),
                buildDetailTile('City', propertyDetails.selectedcity),
                buildDetailTile('City', propertyDetails.selectedstate),
                buildDetailTile('ZIP Code', propertyDetails.zip),
                buildDetailTile('Country', propertyDetails.country),
                buildDetailTile('Description', propertyDetails.description),
                buildDetailTile('Contact', propertyDetails.contact),
                buildDetailTile('Place Type', propertyDetails.placeType),
                buildDetailTile('Sharing Type', propertyDetails.sharingType),
                buildDetailTile(
                    'Rooms Available', propertyDetails.roomsAvailable),
                buildDetailTile(
                    'Furnishing Type', propertyDetails.furnishingType),
                buildDetailTile('Available For', propertyDetails.availableFor),
                const Text(
                  'Amenities:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...propertyDetails.amenities
                    .map((amenity) => Text('• $amenity')),
                const SizedBox(height: 16),
                const Text(
                  'Rent:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('${propertyDetails.selectedrent} rupees'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(value),
        const Divider(),
      ],
    );
  }
}
