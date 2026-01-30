import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class MeasurementCard extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTypeSelected;

  MeasurementCard({super.key, required this.onTypeSelected, this.selectedType});

  List<Map<String, dynamic>> measurementTypes = [
    {'id': 'fasting', 'label': 'Fasting', 'icon': Icons.local_cafe},
    {'id': 'pre-meal', 'label': 'Before Meal', 'icon': Icons.restaurant},
    {'id': 'post-meal', 'label': 'After Meal', 'icon': Icons.local_dining},
    {'id': 'bedtime', 'label': 'Before Bed', 'icon': Icons.bedtime},
    {'id': 'random', 'label': 'Random', 'icon': Icons.shuffle},
  ];

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 11.0,
      runSpacing: 11.0,
      children: measurementTypes.map((type) {
        return FilterChip(
          label: Text(
            type['label'],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selectedType == type['id']
                  ? AppTheme.primaryDark
                  : AppTheme.primaryMedium,
            ),
          ),
          avatar: Icon(
            type['icon'],
            size: 20,
            color: selectedType == type['id']
                ? AppTheme.primaryDark
                : AppTheme.primaryMedium,
          ),
          selected: selectedType == type['id'],
          onSelected: (selected) {
            if (selected) {
              onTypeSelected(type['id']);
            }
          },
          backgroundColor: Colors.white,
          selectedColor: const Color.fromARGB(29, 29, 120, 116),
          showCheckmark: false,
          side: BorderSide(
            color: selectedType == type['id']
                ? AppTheme.primaryDark
                : AppTheme.primaryLight,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          pressElevation: 0,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Measurement Type',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.black,
              ),
            ),
            SizedBox(height: 11),

            _buildFilterChips(),
          ],
        ),
      ),
    );
  }
}
