import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';

class ChangeProfilePicturePage extends StatefulWidget {
  const ChangeProfilePicturePage({super.key});

  @override
  State<ChangeProfilePicturePage> createState() => _ChangeProfilePicturePageState();
}

class _ChangeProfilePicturePageState extends State<ChangeProfilePicturePage> {
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _selectFromGallery(AccountData accountData) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes(); // Read image as bytes
      accountData.updateProfilePicture(imageBytes);
    }
  }

  Future<void> _takePhoto(AccountData accountData) async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes(); // Read image as bytes
      accountData.updateProfilePicture(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountData = Provider.of<AccountData>(context);
    final Uint8List? currentProfilePicture = accountData.profilePicture;

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
              onTap: () => _selectFromGallery(accountData),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.purple),
              title: const Text('Take a New Photo'),
              onTap: () => _takePhoto(accountData),
            ),
            const SizedBox(height: 20),
            if (currentProfilePicture != null) ...[
              Center(
                child: Image.memory(
                  currentProfilePicture,
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}