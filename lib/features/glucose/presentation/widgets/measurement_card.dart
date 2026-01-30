import 'package:flutter/material.dart';

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

  Widget _buildFilterChips(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 19.0,
      runSpacing: 11.0,
      children: measurementTypes.map((type) {
        final isSelected = selectedType == type['id'];

        return FilterChip(
          label: Text(
            type['label'],
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : colorScheme.secondary,
            ),
          ),
          avatar: Icon(
            type['icon'],
            size: 20,
            color: isSelected ? Colors.white : colorScheme.secondary,
          ),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              onTypeSelected(type['id']);
            }
          },
          backgroundColor: brightness == Brightness.light
              ? Colors.white
              : colorScheme.surface,
          selectedColor: colorScheme.primary,
          showCheckmark: false,
          side: BorderSide(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          pressElevation: 0,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                'Measurement Type',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 11),
            _buildFilterChips(context),
          ],
        ),
      ),
    );
  }
}
