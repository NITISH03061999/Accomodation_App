import 'package:accomodation/modals/roomdetail.dart';
import 'package:accomodation/screens/AddedRooms.dart';
import 'package:accomodation/screens/ApproveRooms.dart';
import 'package:flutter/material.dart';

class ManagerRooms extends StatelessWidget {
  const ManagerRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Rooms'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.add),
                text: 'Added Rooms',
              ),
              Tab(
                icon: Icon(Icons.assignment_turned_in),
                text: 'Approved Rooms',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Addedrooms(),
            Approverooms(), // Corrected to ApproveRooms()
          ],
        ),
      ),
    );
  }
}
