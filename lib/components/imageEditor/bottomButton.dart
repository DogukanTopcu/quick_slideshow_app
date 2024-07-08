import 'package:flutter/material.dart';

Map<String, String> _translations = {};
String i18n(String sourceString) =>
    _translations[sourceString.toLowerCase()] ?? sourceString;

class BottomButton extends StatelessWidget {
  final VoidCallback? onTap, onLongPress;
  final IconData icon;
  final String text;

  const BottomButton({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              i18n(text),
            ),
          ],
        ),
      ),
    );
  }
}
