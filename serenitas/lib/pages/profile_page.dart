import 'package:flutter/material.dart';
import 'package:serenitas/pages/change_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar and Username
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            ListTile(
        leading: const Icon(Icons.edit),
        title: const Text('Change Profile Picture'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangeProfilePicturePage(),
            ),
          );
        },
      ),

          ],
        ),
      ),
    );
  }
}
