import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const String City = 'City';
const String Area = 'Area';

class Dropdown extends StatefulWidget {
  final String dropdownName;
  final String collectionName;
  final List<String> selectedItem;
  final Function? onStatusChanged;
  final String keyName;
  final String? cityId;

  Dropdown({
    super.key,
    required this.collectionName,
    required this.selectedItem,
    required this.dropdownName,
    required this.keyName,
    this.cityId,
    this.onStatusChanged,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue =
        widget.selectedItem.isNotEmpty ? widget.selectedItem.first : null;
  }

  Future<List<DropdownMenuItem<String>>> _getDropdownItems() async {
    QuerySnapshot snapshot;
    if (widget.collectionName == 'City') {
      snapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get();
    } else if (widget.collectionName == 'Area') {
      snapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .where('cityId', isEqualTo: widget.cityId ?? '')
          .get();
    } else {
      throw Exception('Invalid collection name');
    }

    List<DropdownMenuItem<String>> listItems = [
      DropdownMenuItem(
          value: "0", child: Text("Select ${widget.dropdownName}")),
    ];
    for (var item in snapshot.docs) {
      listItems.add(
          DropdownMenuItem(value: item.id, child: Text(item[widget.keyName])));
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: FutureBuilder<List<DropdownMenuItem<String>>>(
        future: _getDropdownItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: snapshot.data!,
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                  widget.selectedItem[0] = value!;
                  if (widget.onStatusChanged != null) {
                    widget.onStatusChanged!(); // Call the callback function
                  }
                });
              },
              isExpanded: true,
              value: selectedValue,
            ),
          );
        },
      ),
    );
  }
}
