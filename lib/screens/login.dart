import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_new_project/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dashboard.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Image.asset("assets/images/logo.png", width: 200),
            Image.asset("assets/images/front_image.png", width: 70, height: 250),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _showErrorDialog(String message) async {
    return showDialog(
      context: context,
      // Make sure you have access to the context where the dialog should be shown.
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Create a map to represent your data
    final Map<String, dynamic> data = {
      "email": username,
      "password": password,
    };
    print('Username: $username');
    print('Password: $password');
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8080/user/authenticate'),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(data),
      );

    if (response.statusCode == 200) {
      // Successful login
      final responseJson = json.decode(response.body);
      print("Login successful: $responseJson");

      // Navigate to the Dashboard or perform other actions
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else {
      _showErrorDialog('Invalid username or password');
      print("Login with status code ${response.statusCode}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(

                filled: true,
                fillColor: Colors.white,
                hintText: 'Username',
                contentPadding:
                EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),

                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(

                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
                contentPadding:
                EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),

                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)
                ),
                textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            child: const Text('Log In'),
          ),
          const SizedBox(height: 30),
          RichText(
              text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Don't have an account",
                        style: TextStyle(
                            color: Colors.black)
                    ),
                    TextSpan(
                        text: " Sign Up",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          }
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}