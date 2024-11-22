import 'package:flutter/material.dart';
import 'package:accomodation/modals/roomdetail.dart';
import "./propert_form_logic.dart";
import 'EditApproveButtonScreen.dart';

class Addedrooms extends StatelessWidget {
  Addedrooms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: PropertyFormLogic.propertyList.length,
      itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => EditApproveButtonscreen(
                    propertyDetails: PropertyFormLogic.propertyList[index],
                  ),
                ),
              );
            },
            title: Text(PropertyFormLogic.propertyList[index].name),
          )),
    );
  }
}
