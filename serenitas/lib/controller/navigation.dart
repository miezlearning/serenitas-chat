import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  void navigate(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
