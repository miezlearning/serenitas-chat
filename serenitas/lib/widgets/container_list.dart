import 'package:flutter/material.dart';

class MainListContainer extends StatefulWidget {
  final String nama;
  const MainListContainer(
    {
      super.key,
      required this.nama
    }
  );

  
  @override
  State<MainListContainer> createState() => _MainListContainerState();
}

class _MainListContainerState extends State<MainListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30,
              ),
            ),
            Container(
              width: 150,
              height: 90,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                widget.nama,
              ),
            ),
            const Spacer(),
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.more_horiz),
            )
          ],
        ),
      ),
    );
  }
}
