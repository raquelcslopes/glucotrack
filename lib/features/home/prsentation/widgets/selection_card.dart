import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class SelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;

  const SelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  Widget _buildIcon(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(170),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.surface, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(40),
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 34,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
