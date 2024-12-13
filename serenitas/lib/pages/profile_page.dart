import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
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
            CircleAvatar(
              radius: 80,
              backgroundImage: Provider.of<AccountData>(context).profilePicture != null
                    ? MemoryImage(Provider.of<AccountData>(context).profilePicture!)
                    : const AssetImage('assets/profile.png') as ImageProvider
            ),
            const SizedBox(height: 16),
            Text(
              Provider.of<AccountData>(context).currentUser ?? 'Guest',
              style: const TextStyle(
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
