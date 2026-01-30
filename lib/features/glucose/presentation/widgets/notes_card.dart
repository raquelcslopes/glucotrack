import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final TextEditingController controller;

  const NotesCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                'Notes (optional)',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: 11),
            TextFormField(
              controller: controller,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: 'E.g: After lunch, felt fine...',
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 90),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
