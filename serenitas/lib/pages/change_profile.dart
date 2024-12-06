import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data'; // Add this import

class ChangeProfilePicturePage extends StatefulWidget {
  const ChangeProfilePicturePage({super.key});

  @override
  State<ChangeProfilePicturePage> createState() => _ChangeProfilePicturePageState();
}

class _ChangeProfilePicturePageState extends State<ChangeProfilePicturePage> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _selectedImage; // Change type to Uint8List

  Future<void> _selectFromGallery() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes(); // Read image as bytes
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes(); // Read image as bytes
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  void _saveProfilePicture() {
    if (_selectedImage != null) {
      // Implement saving logic here, such as uploading to a server or saving locally
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Change Profile Picture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose an option to change your profile picture:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.purple),
              title: const Text('Select from Gallery'),
              onTap: _selectFromGallery,
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.purple),
              title: const Text('Take a New Photo'),
              onTap: _takePhoto,
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null) ...[
              Center(
                child: Image.memory(
                  _selectedImage!,
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 20),
            ],
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: _saveProfilePicture,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
