import 'package:accomodation/modals/roomdetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'EditApproveButtonScreen.dart';

class Approvalpendingrooms extends StatefulWidget {
  const Approvalpendingrooms({
    super.key,
  });

  @override
  State<Approvalpendingrooms> createState() =>
      _AddedroomsState(); // need to understand
}

class _AddedroomsState extends State<Approvalpendingrooms> {
//   future(){

//  }
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db
          .collection('properties')
          .where('isverified', isEqualTo: false)
          .get(),
      builder: (context, snapshot) {
        //context will contain the deafult screeen and future will contain the data after recieving

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData == false) {
          return const Text('No Data Found');
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs
                .length, //this is used to get data lenght from database
            itemBuilder: (context, index) {
              final property = PropertyDetails.fromMap(snapshot
                  .data!.docs[index]
                  .data()); //herethe database data according to index is stored in this variable
              return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              EditApproveButtonscreen(
                                  propertyDetails: property),
                        ),
                      ).then(
                        (value) {
                          setState(() {});
                        },
                      );
                    },
                    title: Text(property.placename),
                  ));
            }

            //
            );
      },
    ); //future will contain async await logic and builder will contain ui code
  }
}
