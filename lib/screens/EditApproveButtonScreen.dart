import 'package:flutter/material.dart';
import 'package:accomodation/image_picker.dart';
import 'package:accomodation/modals/roomdetail.dart';

class EditApproveButtonscreen extends StatefulWidget {
  final PropertyDetails propertyDetails;

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

  // Define controllers for all form fields
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController zipController;
  late final TextEditingController countryController;
  late final TextEditingController descriptionController;
  late final TextEditingController contactController;
  late final TextEditingController dateController;

  // Dropdown field variables
  String? selectedPlaceType;
  String? selectedSharing;
  String? selectedRoomsAvailable;
  String? selectedFurnishing;
  String? selectedAvailabilityFor;

  final List<String> placeTypes = ['Residential', 'Commercial', 'Industrial'];
  final List<String> sharingTypes = ['Single', 'Double', 'Triple'];
  final List<String> roomsAvailable = ['1', '2', '3+'];
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

  // Checkbox field variables
  Map<String, bool> amenities = {
    'WiFi': false,
    'Parking': false,
    'Gym': false,
    'Swimming Pool': false,
  };

  double rentSliderValue = 5000;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with values from the received data
    nameController = TextEditingController(text: widget.propertyDetails.name);
    emailController = TextEditingController(text: widget.propertyDetails.email);
    phoneController = TextEditingController(text: widget.propertyDetails.phone);
    addressController =
        TextEditingController(text: widget.propertyDetails.address);
    cityController = TextEditingController(text: widget.propertyDetails.city);
    zipController = TextEditingController(text: widget.propertyDetails.zip);
    countryController =
        TextEditingController(text: widget.propertyDetails.country);
    descriptionController =
        TextEditingController(text: widget.propertyDetails.description);
    contactController =
        TextEditingController(text: widget.propertyDetails.contact);
    dateController = TextEditingController(text: widget.propertyDetails.date);

    for (var amenity in widget.propertyDetails.amenities) {
      print(widget.propertyDetails.amenities);
      if (amenities.containsKey(amenity)) {
        amenities[amenity] = true;
        print('it worked');
      }
    }
    for (int i = 0; i < widget.propertyDetails.amenities.length; i++) {
      print(widget.propertyDetails.amenities[i]);
    }
    for (int i = 0; i < amenities.length; i++) {
      print(amenities[i]);
    }

    // Set default values for dropdowns
    selectedPlaceType = placeTypes[0];
    selectedSharing = sharingTypes[0];
    selectedRoomsAvailable = roomsAvailable[0];
    selectedFurnishing = furnishingTypes[0];
    selectedAvailabilityFor = availabilityOptions[0];
  }

  @override
  void dispose() {
    // Dispose controllers to free memory
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    countryController.dispose();
    descriptionController.dispose();
    contactController.dispose();
    dateController.dispose();
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
                    buildTextField(phoneController, 'Phone Number',
                        'Enter phone number', TextInputType.phone),
                    const SizedBox(height: 16),
                    buildTextField(addressController, 'Address',
                        'Enter property address', TextInputType.streetAddress),
                    const SizedBox(height: 16),
                    buildTextField(cityController, 'City', 'Enter city name',
                        TextInputType.text),
                    const SizedBox(height: 16),
                    buildTextField(zipController, 'ZIP Code', 'Enter ZIP code',
                        TextInputType.number),
                    const SizedBox(height: 16),
                    buildTextField(countryController, 'Country',
                        'Enter country name', TextInputType.text),
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
                      items: roomsAvailable,
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
                    const Text('Rent:', style: TextStyle(fontSize: 16)),
                    Slider(
                      value: rentSliderValue,
                      min: 1000,
                      max: 10000,
                      divisions: 10,
                      label: rentSliderValue.toStringAsFixed(0),
                      onChanged: (value) => setState(() {
                        rentSliderValue = value;
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
                    // Handle "Decline"
                  },
                  child: const Text('Decline',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    // Handle "Approve"
                  },
                  child: const Text('Approve',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      print({
                        "name": nameController.text,
                        "email": emailController.text,
                        "phone": phoneController.text,
                        "address": addressController.text,
                        "city": cityController.text,
                        "zip": zipController.text,
                        "country": countryController.text,
                        "placeType": selectedPlaceType,
                        "sharingType": selectedSharing,
                        "roomsAvailable": selectedRoomsAvailable,
                        "furnishingType": selectedFurnishing,
                        "availableFor": selectedAvailabilityFor,
                        "amenities": amenities.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList(),
                        "rentSliderValue": rentSliderValue,
                      });
                    }
                  },
                  child: const Text('Save Changes',
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

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem(
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
