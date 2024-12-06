import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final trailingColor = isDarkMode ? Colors.grey[300] : Colors.grey;

    return ListTile(
      leading: Icon(icon, color: iconColor), // Adaptive icon color
      title: Text(
        title,
        style: TextStyle(color: textColor), // Adaptive text color
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: trailingColor), // Adaptive trailing icon color
      onTap: onTap,
    );
  }
}
