import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String name;
  const Header({super.key, required this.name});

  Widget _buildDrawerIcon(BuildContext context) {
    return InkWell(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Icon(
        Icons.menu,
        color: Theme.of(context).colorScheme.surface,
        size: 24,
      ),
    );
  }

  Widget _buildAppName(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.monitor_heart_rounded,
          color: Theme.of(context).colorScheme.surface,
        ),
        SizedBox(width: 5),
        Text(
          'GlucoTrack',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileWidget(BuildContext context, String userName) {
    final names = userName.trim().split(' ');

    final abv = '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();

    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: Text(
          abv,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.surface,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDrawerIcon(context),
            _buildAppName(context),
            _buildProfileWidget(context, name),
          ],
        ),
      ),
    );
  }
}
