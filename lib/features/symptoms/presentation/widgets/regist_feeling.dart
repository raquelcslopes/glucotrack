import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class RegistFeelingCard extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTypeSelected;

  RegistFeelingCard({
    super.key,
    required this.onTypeSelected,
    this.selectedType,
  });

  List<Map<String, dynamic>> feelingTypes = [
    {
      'id': 'mild',
      'label': 'Mild',
      'icon': '😊',
      'subtitle': 'Noticeable symptoms',
    },
    {
      'id': 'moderate',
      'label': 'Moderate',
      'icon': '😐',
      'subtitle': 'Uncomfortable',
    },
    {
      'id': 'severe',
      'label': 'Severe',
      'icon': '😰',
      'subtitle': 'Highly distressing',
    },
  ];

  Widget _buildFilterChips(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;

    return Row(
      children: feelingTypes.map((type) {
        final isSelected = selectedType == type['id'];

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
              onTap: () => onTypeSelected(type['id']),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryMedium
                      : (brightness == Brightness.light
                            ? Colors.white
                            : colorScheme.surface),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryMedium
                        : colorScheme.outlineVariant,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(type['icon'], style: const TextStyle(fontSize: 24)),
                    const SizedBox(height: 8),
                    Text(
                      type['label'],
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type['subtitle'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11,
                        color: isSelected
                            ? Colors.white.withOpacity(0.9)
                            : colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How severe are your symptoms?',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Rate the overall intensity of what you're feeling",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
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
