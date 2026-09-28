import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  const IconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Icon(icon, size: 16, color: Color.fromRGBO(28, 27, 31, 1)),
    );
  }
}
