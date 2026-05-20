import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF101213),
            fontFamily: 'Plus Jakarta Sans',
          ),
        ),
        value: value,
        activeThumbColor: const Color(0xFF4B39EF),
        contentPadding:
            EdgeInsets.zero, // Alinea el texto perfectamente al borde izquierdo
        onChanged: onChanged,
      ),
    );
  }
}
