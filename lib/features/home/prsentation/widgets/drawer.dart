import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/home/prsentation/models/menu_item.dart';

class DrawerWidget extends StatelessWidget {
  final String? profilePic;
  final String useName;

  const DrawerWidget({
    super.key,
    required this.profilePic,
    required this.useName,
  });

  List<MenuItem> _getMenuItems(BuildContext context) {
    return [
      MenuItem(
        icon: Icons.home_rounded,
        label: 'Home',
        onTap: Navigator.pushNamed(context, '/home'),
      ),
      // MenuItem(icon: Icons.history_rounded, label: 'Data history', onTap: (_){}),
      //MenuItem(icon: Icons.document_scanner_outlined, label: 'Glycemic report', onTap: null),
      //MenuItem(icon: Icons.settings_suggest_rounded, label: 'Settings', onTap: null),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(shape: BoxShape.rectangle),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppTheme.primaryDark,
                        backgroundImage: NetworkImage(
                          profilePic ??
                              'https://img.icons8.com/ios/50/FFFFFF/user-male-circle--v1.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            useName,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: AppTheme.primaryDark),
                          ),
                          Text(
                            'email',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: const Color.fromARGB(156, 103, 146, 137),
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
