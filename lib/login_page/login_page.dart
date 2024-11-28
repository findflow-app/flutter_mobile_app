import 'package:findflow_mobile/app_bar.dart';
import 'package:findflow_mobile/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Image.asset("assets/images/find_flow_logo.png", height: 40, color: ThemeManager.instance.currentMode.colorScheme.primary),
      ),

      body: Center(
        child: Column(
          children: [

            Expanded(
              child: Container(),
            ),
            
            const Text("Log in", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),

            const SizedBox(
              height: 40,
            ),  

            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ThemeManager.instance.currentMode.colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Login', style: TextStyle(fontSize: 20)),
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
              child: Text("Don't have an account? Sign up", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)),
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