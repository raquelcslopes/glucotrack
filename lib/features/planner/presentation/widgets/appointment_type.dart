import 'package:flutter/material.dart';

class AppointmentTypeCard extends StatelessWidget {
  final String selectedType;
  final Function(String) onSelected;

  AppointmentTypeCard({
    super.key,
    required this.onSelected,
    required this.selectedType,
  });

  final List<Map<String, dynamic>> types = [
    {
      'id': 'nutrition',
      'name': 'Nutrition',
      'bgcolor': Color(0x2010B981),
      'color': Color(0xFF10B981),
    },

    {
      'id': 'medicine',
      'name': 'Medicine',
      'bgcolor': Color(0x33F97316),
      'color': Color(0xFFF97316),
    },

    {
      'id': 'endocrinologist',
      'name': 'Endocrinologist',
      'bgcolor': Color(0x3306B6D4),
      'color': Color(0xFF06B6D4),
    },
  ];

  Widget _builChips(Map<String, dynamic> type, BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = selectedType == type['id'];

    return FilterChip(
      padding: EdgeInsets.all(8),
      label: Text(
        type['name'],
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        onSelected(type['id']);
      },
      backgroundColor: theme.cardColor,
      selectedColor: type['bgcolor'] as Color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      showCheckmark: false,
      side: BorderSide(
        color: isSelected ? type['color'] : theme.colorScheme.outlineVariant,
        width: 2,
      ),
      pressElevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.dashboard_customize_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Appointment Type',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Wrap(
                spacing: 11.0,
                runSpacing: 2.0,
                alignment: WrapAlignment.center,
                children: [
                  ...types.map((type) => _builChips(type, context)).toList(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
