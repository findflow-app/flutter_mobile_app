import 'package:findflow_mobile/login_page/sign_up_page.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:findflow_mobile/services/user_service.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findflow_mobile/components/fullscreen_view.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void handleAuthStateChange(AuthState state) {
    // if auth failure, show snackbar
    if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          state.error,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ));
    }

    // if authloading, show loading dialog
    if (state is AuthLoading) {
      showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void handleLogin() {
    ref.watch(authServiceProvider.notifier).login(
          _usernameController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(
        authServiceProvider, (_, state) => handleAuthStateChange(state));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Image.asset("assets/images/find_flow_logo.png",
            height: 40, color: Theme.of(context).colorScheme.primary),
      ),
      body: FullscreenView(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              const Text("Log in",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 40,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: handleLogin,
                            child: const Text('Log in',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  ),
                  child: const Text("Don't have an account? Sign up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
              Expanded(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
