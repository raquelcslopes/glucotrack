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
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.surface,
          width: 1.5,
        ),
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
      alignment: Alignment.center,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0d7a7a), Color(0xFF16a29d)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(25),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: 30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          Padding(
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
        ],
      ),
    );
  }
}
