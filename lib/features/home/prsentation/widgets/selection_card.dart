import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class SelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function() onTap;

  const SelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  Widget _buildIcon() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(169, 0, 0, 0),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildIcon(),

              SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.primaryDark,
                ),
              ),

              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppTheme.textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
