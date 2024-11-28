import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Login Screen'),
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            
            Container(
              child: Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),

            SizedBox(
              height: 20,
            ),  


            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email', 
                          ),
                        ),
                        const SizedBox(height: 16),
                        const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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