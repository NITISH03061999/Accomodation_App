// ignore_for_file: avoid_print

import 'package:accomodation/image_picker.dart';
import 'package:accomodation/modals/roomdetail.dart';
import 'package:accomodation/screens/propert_form_logic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:accomodation/widgets/dropdown.dart';

// import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final PropertyFormLogic _formLogic = PropertyFormLogic();
  String createdby = '';
  DateTime? createdat;
  DateTime? updatedat;
  dynamic selectedrent;
  bool isactive = false;
  bool isverified = false;
  List<String> selectedItemCity = ["0"];
  List<String> selectedItemAreaState = ["0"];

  void _onactiveCheckboxChanged(bool? value) {
    setState(() {
      isactive = value ?? false;
      _formLogic.isactive = isactive; // Sync with _formLogic
    });
  }

  @override
  void dispose() {
    _formLogic.dispose();
    super.dispose();
  }

  void _submitForm() async {
    print("********** Pass by value: ${selectedItemCity}");
    if (_formKey.currentState?.validate() ?? false) {
      final db = FirebaseFirestore.instance;

      // Ensure selectedrent is in the correct type

      final property = PropertyDetails(
        selectedcity: selectedItemCity.first,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        placename: _formLogic.placenameController.text,
        name: _formLogic.nameController.text,
        email: _formLogic.emailController.text,
        address: _formLogic.addressController.text,
        zip: _formLogic.zipController.text,
        country: _formLogic.countryController.text,
        description: _formLogic.descriptionController.text,
        contact: _formLogic.contactController.text,
        placeType: _formLogic.selectedPlaceType ?? 'Not Selected',
        selectedstate: _formLogic.selectedstate ?? 'Not Selected',
        sharingType: _formLogic.selectedSharing ?? 'Not Selected',
        roomsAvailable: _formLogic.selectedRoomsAvailable ?? 'Not Selected',
        furnishingType: _formLogic.selectedFurnishing ?? 'Not Selected',
        availableFor: _formLogic.selectedAvailabilityFor ?? 'Not Selected',
        createdby: _formLogic.createdby.toString(),
        createdat: DateTime.now(),
        updatedat: null,
        isverified: _formLogic.isverified,
        isactive: _formLogic.isactive,
        amenities: _formLogic.amenities.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList(),
        selectedrent: _formLogic.selectedrentController.text,
        updatedby: null,
      );

      try {
        await db
            .collection('properties')
            .doc(property.id)
            .set(property.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );
        _formLogic.clearForm();
      } catch (e) {
        print('Error submitting form: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting form.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Enter Room Details:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              const GalleryImagePicker(),
              const SizedBox(height: 20),
              // Place Name
              TextFormField(
                controller: _formLogic.placenameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Place Name:',
                  hintText: 'Enter place name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Place Type Dropdown
              buildDropdownField(
                label: 'Select Place Type',
                value: _formLogic.selectedPlaceType,
                items: _formLogic.placeTypes,
                onChanged: (value) {
                  setState(() {
                    _formLogic.selectedPlaceType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Sharing Type Dropdown
              buildDropdownField(
                label: 'Select Sharing Type',
                value: _formLogic.selectedSharing,
                items: _formLogic.sharingTypes,
                onChanged: (value) {
                  setState(() {
                    _formLogic.selectedSharing = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Tenant Type Dropdown
              buildDropdownField(
                label: 'Select Tenant Type',
                value: _formLogic.selectedAvailabilityFor,
                items: _formLogic.availableFor,
                onChanged: (value) {
                  setState(() {
                    _formLogic.selectedAvailabilityFor = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Rooms Available Dropdown
              buildDropdownField(
                label: 'Number of Rooms Available',
                value: _formLogic.selectedRoomsAvailable,
                items: _formLogic.roomsAvailable,
                onChanged: (value) {
                  setState(() {
                    _formLogic.selectedRoomsAvailable = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Furnishing Type Dropdown
              buildDropdownField(
                label: 'Furnishing Type',
                value: _formLogic.selectedFurnishing,
                items: _formLogic.furnishings,
                onChanged: (value) {
                  setState(() {
                    _formLogic.selectedFurnishing = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Amenities:', style: TextStyle(fontSize: 18)),
              ..._formLogic.amenities.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: _formLogic.amenities[key],
                  onChanged: (bool? value) {
                    setState(() {
                      _formLogic.amenities[key] = value ?? false;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16),
              TextFormField(
                  initialValue:
                      selectedrent != null ? selectedrent.toString() : '',
                  decoration: const InputDecoration(
                    labelText: 'Rent Price',
                    hintText: 'Enter rent price',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rent price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedrent.text = double.tryParse(value) ?? 0.0;
                    });
                  }),
              const SizedBox(height: 16),

              // Owner Details
              const Text('Enter Owner Details:',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.nameController,
                label: 'Owner Name',
                hint: 'Enter owner name',
                inputType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter owner name'
                    : null,
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.emailController,
                label: 'Email',
                hint: 'Enter email address',
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email.';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return 'Enter a valid email.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.contactController,
                label: 'Phone Number',
                hint: 'Enter phone number',
                inputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number.';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit phone number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.addressController,
                label: 'Address',
                hint: 'Enter address',
                inputType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter address.'
                    : null,
              ),
              const SizedBox(height: 16),

              Dropdown(
                collectionName: 'City',
                selectedItem: selectedItemCity,
                dropdownName: 'city',
                keyName: 'cityName',
              ),
              Dropdown(
                collectionName: 'Area',
                selectedItem: selectedItemAreaState,
                dropdownName: 'Area or State',
                keyName: 'areaName',
                cityId: selectedItemCity.toString(),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.zipController,
                label: 'ZIP Code',
                hint: 'Enter ZIP code',
                inputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ZIP code.';
                  }
                  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                    return 'Enter a valid 6-digit ZIP code.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.countryController,
                label: 'Country',
                hint: 'Enter country',
                inputType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter country.'
                    : null,
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _formLogic.descriptionController,
                label: 'Description',
                hint: 'Enter description',
                inputType: TextInputType.multiline,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter description.'
                    : null,
              ),
              const SizedBox(height: 16),
              // Date Validation

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Is Active: ${isactive ? "true" : "false"}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Checkbox(
                    value: isactive,
                    onChanged: _onactiveCheckboxChanged,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<dynamic> buildDropdownField({
    required String label,
    required String? value,
    required List<dynamic> items,
    required void Function(dynamic) onChanged,
  }) {
    if (label == "City") {
      print("*********************** city list: ${items.length}");
    }
    return DropdownButtonFormField<dynamic>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null || value.isEmpty
          ? 'Please select an option for $label.'
          : null,
    );
  } //helper function down that is needed to understand

  TextFormField buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputType inputType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      keyboardType: inputType,
      validator: validator,
    );
  }
}
