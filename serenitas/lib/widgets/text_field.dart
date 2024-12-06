import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String label;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    // Fetch theme-aware colors
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDarkMode
        ? const Color.fromARGB(255, 40, 40, 40) // Dark fill color
        : const Color.fromARGB(255, 223, 220, 220); // Light fill color
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return TextField(
      controller: widget.controller,
      style: GoogleFonts.poppins(
        color: textColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor, // Adaptive background color
        labelText: widget.label,
        labelStyle: GoogleFonts.poppins(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        hintText: widget.hint,
        hintStyle: GoogleFonts.poppins(
          color: textColor.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
