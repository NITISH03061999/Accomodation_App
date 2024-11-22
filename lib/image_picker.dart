import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryImagePicker extends StatefulWidget {
  const GalleryImagePicker({super.key});

  @override
  State<GalleryImagePicker> createState() => _GalleryImagePickerState();
}

class _GalleryImagePickerState extends State<GalleryImagePicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display selected image or a placeholder
        _image != null
            ? Image.file(_image!, height: 200, width: 200, fit: BoxFit.cover)
            : Container(
                height: 200,
                width: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 80, color: Colors.grey),
              ),

        const SizedBox(height: 16),

        // Button to pick image from gallery
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.photo_library),
          label: const Text("Pick Image from Gallery"),
        ),
      ],
    );
  }
}
