import 'package:flutter/material.dart';

class RoleButton extends StatelessWidget {
  const RoleButton({
    super.key,
    required this.isSelected,
    required this.lable,
    required this.onTap,
    required this.theme,
  });

  final bool isSelected;
  final String lable;
  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isSelected
        ? (isDark ? Colors.black : Colors.white)
        : (isDark ? Colors.white : Colors.black);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              lable,
              style: TextStyle(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
