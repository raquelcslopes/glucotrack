import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class LocalInfoCard extends StatelessWidget {
  final TextEditingController localController;
  final TextEditingController adressController;

  LocalInfoCard({
    super.key,
    required this.localController,
    required this.adressController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                    Icons.pin_drop_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Location',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                "Hospital/Clinic",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.black,
                ),
              ),
              SizedBox(height: 4),
              TextFormField(
                controller: localController,
                decoration: InputDecoration(
                  hintText: 'Hospital Santo António',
                  fillColor: const Color.fromARGB(146, 238, 238, 238),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(199, 238, 238, 238),
                      width: 2,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18),
              Text(
                "Adress",
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppTheme.black,
                ),
              ),
              SizedBox(height: 4),
              TextFormField(
                controller: adressController,
                decoration: InputDecoration(
                  hintText: 'Largo Prof. Abel Salazar Porto',
                  fillColor: const Color.fromARGB(146, 238, 238, 238),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(199, 238, 238, 238),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
