import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Image.asset("assets/images/find_flow_logo.png",
            height: 40,
            color: Theme.of(context).colorScheme.primary),
      ),
      body: Center(
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
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Name & lastname',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Login',
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
                  onPressed: () => Navigator.pop(context),
                  child: Text("Already have an account? Log in",
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
    );
  }
}
