import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class RegistSymptomCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> symptoms;
  final Function(List<String>)? onSymptomsSelected;
  final List<String> selectedTypes;
  final Function(List<String>) onTypesSelected;

  const RegistSymptomCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.symptoms,
    required this.onTypesSelected,
    required this.selectedTypes,
    this.onSymptomsSelected,
  });
  @override
  State<RegistSymptomCard> createState() => _RegistSymptomCardState();
}

class _RegistSymptomCardState extends State<RegistSymptomCard> {
  Widget _buildFilterChips(Map<String, dynamic> symptom) {
    final colorScheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final isSelected = widget.selectedTypes.contains(symptom['id']);

    return FilterChip(
      label: Text(
        symptom['label'],
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : colorScheme.onSurface,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        final updatedList = List<String>.from(widget.selectedTypes);

        if (selected) {
          updatedList.add(symptom['id']);
        } else {
          updatedList.remove(symptom['id']);
        }

        widget.onTypesSelected(updatedList);
        widget.onSymptomsSelected?.call(updatedList);
      },
      backgroundColor: brightness == Brightness.light
          ? Colors.white
          : colorScheme.surface,
      selectedColor: AppTheme.primaryMedium,
      showCheckmark: false,
      side: BorderSide(
        color: isSelected ? AppTheme.primaryMedium : colorScheme.outlineVariant,
        width: 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      pressElevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(widget.icon, color: theme.colorScheme.primary),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(widget.subtitle, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
            Wrap(
              runSpacing: 2.0,
              spacing: 18.0,
              children: [
                ...widget.symptoms.map((s) => _buildFilterChips(s)).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
