import 'package:findflow_mobile/components/fullscreen_view.dart';
import 'package:findflow_mobile/login_page/login_page.dart';
import 'package:findflow_mobile/providers.dart';
import 'package:findflow_mobile/services/user_service.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void handleSignup() {
    ref.watch(authServiceProvider.notifier).signUp(
          _emailController.text,
          _passwordController.text,
          _fullnameController.text,
          _phoneNumberController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
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
              const Text("Sign up",
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
                            controller: _fullnameController,
                            decoration: const InputDecoration(
                              labelText: 'Full name',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Phone number',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: handleSignup,
                            child: const Text('Sign up',
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Already have an account? Log in",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
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
