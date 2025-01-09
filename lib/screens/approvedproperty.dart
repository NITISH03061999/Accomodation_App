import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:accomodation/modals/roomdetail.dart';
import 'package:flutter/material.dart';

import 'approvedroomsdetails.dart';

class ApprovedRooms extends StatelessWidget {
  const ApprovedRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where('isverified', isEqualTo: true) // Assuming you use this field
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching properties'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No approved properties available.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final approvedPropertiesList = snapshot.data!.docs.map((doc) {
            return PropertyDetails.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: approvedPropertiesList.length,
            itemBuilder: (context, index) {
              final property = approvedPropertiesList[index];
              return ListTile(
                key: ValueKey(property.placename),
                title: Text(property.placename),
                subtitle: Text(property.address),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Approvedroomsdetails(
                        propertyId: snapshot.data!.docs[index].id, // Pass ID
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
