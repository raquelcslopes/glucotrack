import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/prsentation/widgets/drawer.dart';
import 'package:flutter_app/features/home/prsentation/widgets/header.dart';
import 'package:flutter_app/features/home/prsentation/widgets/selection_card.dart';
import 'package:flutter_app/features/user/presentation/provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userNotifierProvider).user;
    final userName = user!.name;
    final userProfilePic = user.profilePic;

    return Scaffold(
      drawer: DrawerWidget(useName: userName, profilePic: userProfilePic),
      body: Column(
        children: [
          Header(name: userName),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SelectionCard(
                icon: Icons.water_drop_outlined,
                title: 'Check Glucose',
                subtitle: 'Record new reading',
                onTap: () => Navigator.pushNamed(context, '/glucose-regist'),
              ),

              SelectionCard(
                icon: Icons.document_scanner_outlined,
                title: 'Log Symptoms',
                subtitle: 'Note how you feel',
                onTap: () => Navigator.pushNamed(context, 'glucose'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
