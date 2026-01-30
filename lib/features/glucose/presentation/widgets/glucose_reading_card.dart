import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class GlucoseReadingCard extends StatefulWidget {
  final TextEditingController controller;

  GlucoseReadingCard({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() {
    return _GlucoseReadingCardState();
  }
}

class _GlucoseReadingCardState extends State<GlucoseReadingCard> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {});
  }

  Widget _buildResultContainer(BuildContext context) {
    final value = int.tryParse(widget.controller.text);

    if (value == null) {
      return SizedBox.shrink();
    }

    if (value < 70) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(47, 245, 159, 11),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          'Low - Attention!',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppTheme.warning),
        ),
      );
    }

    if (value >= 70 && value <= 100) {
      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(54, 16, 185, 129),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          'Normal ✓',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(color: AppTheme.success),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(41, 239, 68, 68),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        'High - Attention!',
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(color: AppTheme.error),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
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
              'Glucose Reading',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 11),
            TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              controller: widget.controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter your blood sugar',
                fillColor: const Color.fromARGB(173, 231, 236, 235),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
            SizedBox(height: 11),

            _buildResultContainer(context),
          ],
        ),
      ),
    );
  }
}
