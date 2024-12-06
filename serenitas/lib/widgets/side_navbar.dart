import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
import '../controller/navigation.dart';

class CustomDrawer extends StatefulWidget {
  final String imagepath;
  final Color boxColor;
  final List<Map<String, String>> buttons;

  const CustomDrawer({
    Key? key,
    required this.imagepath,
    required this.boxColor,
    required this.buttons,
  }) : super(key: key);

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
          // Update drag distance while dragging horizontally
          _dragDistance += details.primaryDelta!;
          if (_dragDistance < 0) {
            _dragDistance = 0; // Prevent dragging past the left edge
          } else if (_dragDistance > _maxDragDistance) {
            _dragDistance = _maxDragDistance; // Limit drag to max distance
          }
        });
      },
      onHorizontalDragEnd: (details) {
        // Decide whether the drawer should be fully open or closed after the drag
        setState(() {
          if (_dragDistance > _maxDragDistance / 2) {
            _dragDistance = _maxDragDistance; // Snap to fully open
          } else {
            _dragDistance = 0.0; // Snap to fully closed
          }
        });
      },
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(widget.imagepath),
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
