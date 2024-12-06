import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String item1;
  final String item2;
  final IconData item1icon;
  final IconData item2icon;

  const CustomBottomNavigationBar(
    {
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.item1,
    required this.item2,
    required this.item1icon,
    required this.item2icon,
    }
  );

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.lightBlue,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.black,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(widget.item2icon),
          label: widget.item1,
        ),
        BottomNavigationBarItem(
          icon: Icon(widget.item2icon),
          label: widget.item2,
        ),
      ],
    );
  }
}
