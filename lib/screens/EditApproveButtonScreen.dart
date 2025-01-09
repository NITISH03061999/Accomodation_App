// ignore_for_file: unused_element
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accomodation/image_picker.dart';
import 'package:accomodation/modals/roomdetail.dart';
import 'propert_form_logic.dart';

class EditApproveButtonscreen extends StatefulWidget {
  final PropertyDetails propertyDetails;
  // ignore: prefer_typing_uninitialized_variables
  //

  const EditApproveButtonscreen({
    required this.propertyDetails,
    super.key,
  });

  @override
  State<EditApproveButtonscreen> createState() =>
      _EditApproveButtonscreenState();
}

class _EditApproveButtonscreenState extends State<EditApproveButtonscreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final db = FirebaseFirestore.instance;

  // Define controllers for all form fields
  late TextEditingController placenameController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController zipController;
  late TextEditingController countryController;
  late TextEditingController descriptionController;
  late TextEditingController contactController;
  late TextEditingController selectedrentController;

  // Dropdown field variables
  String? selectedPlaceType;
  String? selectedSharing;
  String? selectedRoomsAvailable;
  String? selectedFurnishing;
  String? selectedAvailabilityFor;
  String? createdby;
  DateTime? createdat;
  DateTime? updatedat;
  String? updatedby;

  // ignore: prefer_typing_uninitialized_variables

  bool isactive = false;
  bool isverified = false;

  final List<String> placeTypes = ['Residential', 'Commercial', 'Industrial'];
  final List<String> sharingTypes = ['Single', 'Double', 'Triple'];
  final List<String> roomsAvailable = ['1', '2', '3', '4'];
  final List<String> furnishingTypes = [
    'Furnished',
    'Semi-Furnished',
    'Unfurnished'
  ];
  final List<String> availabilityOptions = [
    'Students',
    'Families',
    'Professionals'
  ];
  // ignore: non_constant_identifier_names
  final propertyFormLogic = PropertyFormLogic();

  // ignore: prefer_typing_uninitialized_variables
  late final amenities;

  // ignore: prefer_typing_uninitialized_variables

  @override
  void initState() {
    super.initState();
    amenities = propertyFormLogic.amenities;
    isactive = widget.propertyDetails.isactive;
    isverified = widget.propertyDetails.isverified;

    createdby = widget.propertyDetails.createdby;
    createdat = propertyFormLogic.createdat;

    // // Initialize controllers with values from the received data
    placenameController =
        TextEditingController(text: widget.propertyDetails.placename);
    nameController = TextEditingController(text: widget.propertyDetails.name);
    selectedrentController =
        TextEditingController(text: widget.propertyDetails.selectedrent);

    emailController = TextEditingController(text: widget.propertyDetails.email);
    addressController =
        TextEditingController(text: widget.propertyDetails.address);
    zipController = TextEditingController(text: widget.propertyDetails.zip);
    countryController =
        TextEditingController(text: widget.propertyDetails.country);
    descriptionController =
        TextEditingController(text: widget.propertyDetails.description);
    contactController =
        TextEditingController(text: widget.propertyDetails.contact);

    for (String amenity in widget.propertyDetails.amenities) {
      if (amenities.containsKey(amenity)) {
        amenities[amenity] = true;
      }
    }

    // Set default values for dropdowns
    selectedPlaceType = placeTypes[0];
    selectedSharing = sharingTypes[0];
    selectedRoomsAvailable = propertyFormLogic.roomsAvailable[0];
    selectedFurnishing = furnishingTypes[0];
    selectedAvailabilityFor = availabilityOptions[0];
    updatedby = '';
  }

  @override
  void dispose() {
    // Dispose controllers to free memory
    placenameController.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    zipController.dispose();
    countryController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    updatedby = '';

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Property Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      'Enter Property Details:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    const GalleryImagePicker(),
                    const SizedBox(height: 20),
                    buildTextField(nameController, 'Owner Name',
                        'Enter owner name', TextInputType.text),
                    const SizedBox(height: 16),
                    buildTextField(emailController, 'Email',
                        'Enter email address', TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    buildTextField(contactController, 'Contact',
                        'Enter contact number ', TextInputType.phone),
                    const SizedBox(height: 16),
                    buildTextField(addressController, 'Address',
                        'Enter property address', TextInputType.streetAddress),
                    const SizedBox(height: 16),
                    buildTextField(zipController, 'ZIP Code', 'Enter ZIP code',
                        TextInputType.number),
                    const SizedBox(height: 16),
                    buildTextField(countryController, 'Country',
                        'Enter country name', TextInputType.text),
                    const SizedBox(height: 16),
                    buildTextField(selectedrentController, 'Rent',
                        'Enter Rent Required', TextInputType.number),
                    const SizedBox(height: 16),
                    buildDropdownField(
                      label: 'Place Type',
                      value: selectedPlaceType,
                      items: placeTypes,
                      onChanged: (value) => setState(() {
                        selectedPlaceType = value!;
                      }),
                    ),
                    const SizedBox(height: 16),
                    buildDropdownField(
                      label: 'Sharing Type',
                      value: selectedSharing,
                      items: sharingTypes,
                      onChanged: (value) => setState(() {
                        selectedSharing = value!;
                      }),
                    ),
                    const SizedBox(height: 16),
                    buildDropdownField(
                      label: 'Rooms Available',
                      value: selectedRoomsAvailable,
                      items: propertyFormLogic.roomsAvailable,
                      onChanged: (value) => setState(() {
                        selectedRoomsAvailable = value!;
                      }),
                    ),
                    const SizedBox(height: 16),
                    buildDropdownField(
                      label: 'Furnishing Type',
                      value: selectedFurnishing,
                      items: furnishingTypes,
                      onChanged: (value) => setState(() {
                        selectedFurnishing = value!;
                      }),
                    ),
                    const SizedBox(height: 16),
                    buildDropdownField(
                      label: 'Available For',
                      value: selectedAvailabilityFor,
                      items: availabilityOptions,
                      onChanged: (value) => setState(() {
                        selectedAvailabilityFor = value!;
                      }),
                    ),
                    const SizedBox(height: 16),
                    const Text('Amenities:', style: TextStyle(fontSize: 16)),
                    ...amenities.keys.map((amenity) {
                      return CheckboxListTile(
                        title: Text(amenity),
                        value: amenities[amenity],
                        onChanged: (value) => setState(() {
                          amenities[amenity] = value!;
                        }),
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    buildCheckboxSelector(
                      label: 'Is Active',
                      value: isactive,
                      onChanged: (value) => setState(() {
                        isactive = value ?? false;
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 74, 49)),
                  onPressed: () {
                    print('decline button has been pressed ');
                    if (_formKey.currentState?.validate() ?? false) {
                      Future<void> deletePropertyFromFirestore(
                          String documentId) async {
                        try {
                          await db
                              .collection('properties')
                              .doc(documentId)
                              .delete();
                          print("Property deleted successfully");
                        } catch (e) {
                          print("Error deleting property: $e");
                        }
                      }

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('the data has been declined')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Decline',
                      style:
                          TextStyle(color: Color.fromARGB(255, 249, 249, 249))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 253, 126)),
                  onPressed: () {
                    print('accept button has been pressed ');
                    widget.propertyDetails.isverified = true;
                    widget.propertyDetails.updatedat = DateTime.now();

                    db
                        .collection('properties')
                        .doc(widget.propertyDetails.id)
                        .set(widget.propertyDetails.toMap());

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data has been approved")),
                    );
                  },
                  child: const Text('Approve',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      String hint, TextInputType inputType) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget buildCheckboxSelector({
    required String label,
    required bool value,
    required void Function(bool?) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildDateEditor({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required void Function(DateTime selectedDate) onDateSelected,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Tap to select a date',
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          controller.text =
              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
          onDateSelected(selectedDate);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date.';
        }
        return null;
      },
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<dynamic> items,
    required ValueChanged<dynamic> onChanged,
  }) {
    return DropdownButtonFormField<dynamic>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem<dynamic>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please select $label' : null,
    );
  }
}
