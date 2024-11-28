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

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Container(
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer),
            child:  Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 10,),
                      Text("Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          // controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const TextField(
                          obscureText: true,
                          // controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(authServiceProvider.notifier).logout();
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Log out', style: TextStyle(fontWeight: FontWeight.bold))),
                        
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}