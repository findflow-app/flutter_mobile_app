import 'package:findflow_mobile/providers.dart';
import 'package:findflow_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthState authState = ref.watch(authServiceProvider);

    if (authState is! AuthAuthenticated) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    AuthAuthenticated userData = authState as AuthAuthenticated;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile",
            style: TextStyle(fontSize: 24.0),
          ),
          Text("Name: ${userData.user.name}"),
          Text("Email: ${userData.user.email}"),
          Text("Phone: ${userData.user.phone_number}"),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(authServiceProvider.notifier).logout();
            },
            child: Text("Logout"),
          )
        ],
      ),
    );
  }
}
