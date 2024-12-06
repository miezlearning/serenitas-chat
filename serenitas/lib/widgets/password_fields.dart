import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPassWordField extends StatefulWidget {
  final TextEditingController controller;
  final bool obsecure;
  final Function()? onvisibility;
  final String label;

  const MyPassWordField({
    super.key,
    required this.controller,
    required this.obsecure,
    required this.onvisibility,
    required this.label,
  });

  @override
  State<MyPassWordField> createState() => _MyPassWordFieldState();
}

class _MyPassWordFieldState extends State<MyPassWordField> {
  @override
  Widget build(BuildContext context) {
    // Fetch theme-aware colors
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDarkMode
        ? const Color.fromARGB(255, 40, 40, 40) // Dark fill color
        : const Color.fromARGB(255, 223, 220, 220); // Light fill color
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final iconColor = isDarkMode ? Colors.white70 : Colors.black87;

    return TextField(
      controller: widget.controller,
      obscureText: widget.obsecure, // Hide text if `obsecure` is true
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
        hintText: 'Masukkan kata sandi',
        hintStyle: GoogleFonts.poppins(
          color: textColor.withOpacity(0.7),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            widget.obsecure ? Icons.visibility : Icons.visibility_off,
            color: iconColor, // Adaptive icon color
          ),
          onPressed: widget.onvisibility, // Toggle visibility
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black, // Adaptive border color
          ),
        ),
      ),
    );
  }
}
