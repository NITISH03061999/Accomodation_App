import 'package:accomodation/image_picker.dart';
import 'package:accomodation/screens/propert_form_logic.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final PropertyFormLogic _formLogic = PropertyFormLogic();

  @override
  void dispose() {
    _formLogic.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formLogic.addProperty();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
      _formLogic.clearForm();
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
                controller: _formLogic.contactController,
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
              // Amenities Checkboxes
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
              // Rent Slider
              const Text('Select Rent Range:', style: TextStyle(fontSize: 18)),
              Slider(
                value: _formLogic.rentSliderValue,
                min: 10000,
                max: 20000,
                divisions: 10,
                label: _formLogic.rentSliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _formLogic.rentSliderValue = value;
                  });
                },
              ),
              Text(
                  'Selected Rent: ${_formLogic.rentSliderValue.round()} rupees'),
              const SizedBox(height: 20),
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
                controller: _formLogic.phoneController,
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
              buildTextField(
                controller: _formLogic.cityController,
                label: 'City',
                hint: 'Enter city',
                inputType: TextInputType.text,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter city.'
                    : null,
              ),
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
                  if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                    return 'Enter a valid 5-digit ZIP code.';
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
              TextFormField(
                controller: _formLogic.dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'Enter date (MM/DD/YYYY)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter a date.';
                //   }
                //   try {
                //     DateFormat('MM/dd/yyyy').parse(value);
                //   } catch (e) {
                //     return 'Enter a valid date (MM/DD/YYYY).';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 20),
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

  DropdownButtonFormField<String> buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
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
  }

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
