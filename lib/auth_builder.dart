import 'package:findflow_mobile/login_page/login_page.dart';
import 'package:findflow_mobile/main_page/devices_tab.dart';
import 'package:findflow_mobile/main_page/main_page.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:findflow_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthBuilder extends ConsumerWidget {
  const AuthBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);

    ref.listen(authServiceProvider, (prevState, _) {
      if (prevState is AuthLoading) {
        Navigator.pop(context);
      }
    });

    if (authState is AuthInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (authState is AuthUnauthenticated ||
        authState is AuthFailure ||
        authState is AuthLoading) {
      return const LoginScreen();
    }

    if (authState is AuthAuthenticated) {
      // Navigator.pop(context);
      // Navigator.of(context).pop();
      return MainScreen();
    }

    return Container();

    // return BlocBuilder<authService, AuthState>(builder: (context, state) {
    //   if (state is AuthInitial)
    //     return SplashScreen();
    //   else if (state is AuthUnauthenticated ||
    //       state is AuthFailure ||
    //       state is AuthLoading) {
    //     return LoginPage();
    //   } else if (state is AuthAuthenticated) {
    //     Navigator.pop(context);
    //     return HomePage();
    //   }
    //   return Container();
    // });
  }
}
