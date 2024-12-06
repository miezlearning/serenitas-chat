import 'package:flutter/material.dart';
import 'package:serenitas/widgets/list_tile.dart';
import 'package:serenitas/widgets/section_header.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 157, 54, 175),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // User avatar
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/user_avatar.png'),
                  ),
                  const SizedBox(width: 16),
                  // User info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Username',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Account'),
            CustomListTile(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            CustomListTile(
              icon: Icons.lock,
              title: 'Privasi & Keamanan',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Pengaturan Aplikasi'),
            CustomListTile(
              icon: Icons.color_lens,
              title: 'Tampilan',
              onTap: () {
                Navigator.pushNamed(context, '/appearance');
              },
            ),
            const SizedBox(height: 20),
            const SectionHeader(title: 'Support'),
            CustomListTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      // backgroundColor: Colors.white,
    );
  }
}
