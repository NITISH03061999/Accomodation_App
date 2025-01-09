import 'package:accomodation/screens/approvalpending.dart';
import 'package:accomodation/screens/approvedproperty.dart';
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
                text: 'Approved Rooms',
              ),
              Tab(
                icon: Icon(Icons.assignment_turned_in),
                text: 'Approval Pending Rooms ',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ApprovedRooms(),
            Approvalpendingrooms(),
          ],
        ),
      ),
    );
  }
}
