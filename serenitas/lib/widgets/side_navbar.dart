import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
import '../controller/navigation.dart';

class CustomDrawer extends StatefulWidget {
  final Color boxColor;
  final List<Map<String, String>> buttons;

  const CustomDrawer({
    super.key,
    required this.boxColor,
    required this.buttons,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double _dragDistance = 0.0;
  final double _maxDragDistance = 250.0; // Max drag distance (drawer width)

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<AccountData>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragDistance += details.primaryDelta!;
          if (_dragDistance < 0) {
            _dragDistance = 0;
          } else if (_dragDistance > _maxDragDistance) {
            _dragDistance = _maxDragDistance;
          }
        });
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (_dragDistance > _maxDragDistance / 2) {
            _dragDistance = _maxDragDistance;
          } else {
            _dragDistance = 0.0;
          }
        });
      },
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: loginController.profilePicture != null
                    ? MemoryImage(loginController.profilePicture!)
                    : const AssetImage('assets/profile.png') as ImageProvider,
              ),
              accountName: Text(loginController.currentUser ?? 'Guest'),
              accountEmail: Text(loginController.currentGender ?? 'Not Specified'),
              decoration: BoxDecoration(color: widget.boxColor),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.buttons.length,
                itemBuilder: (context, index) {
                  final button = widget.buttons[index];
                  return ListTile(
                    title: Text(button['name'] ?? 'Unknown'),
                    onTap: () {
                      navigationProvider.navigate(
                          context, button['target'] ?? '/');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}