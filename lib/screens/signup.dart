import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_new_project/screens/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_screen.png"), fit: BoxFit.cover
            )
        ),

        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            const SizedBox(height: 20.0),
            Image.asset("assets/images/logo.png", width: 100, height: 150),
            Image.asset("assets/images/front_image.png", width: 100, height: 180),
            const SignInForm(),
          ],
        ),

      ),
    );
  }
}



class SignInForm extends StatefulWidget {


  const SignInForm({super.key});
  @override
  createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();


  void _register() async {

    String username = _userController.text;
    String mobile = _mobileController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String rePwd = _repasswordController.text;

    // Create a map to represent your data
    final Map<String, dynamic> data = {
      "fullName": username,
      "password": password,
      "email" : email,
      "mobileNumber" : mobile,
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8080/user/register'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Successful login
      final responseJson = json.decode(response.body);
      print("Register successful: $responseJson");

      // Navigate to the Dashboard or perform other actions
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginForm()),
      );
    } else if (password != rePwd) {
      _showErrorDialog('Make sure the passwords are the same.');
    } else {
      print("Signup failed with status code ${response.statusCode}");
    }
  }

  Future<void> _showErrorDialog(String message) async {
    return showDialog(
      context: context, // Make sure you have access to the context where the dialog should be shown.
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA6CF6F),
                    hintText: 'Username',
                    contentPadding: const EdgeInsets.all(14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),

              ),
              const SizedBox(width: 10.0), // Add some spacing between the text fields
              Expanded(
                child: TextField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA6CF6F),
                    hintText: 'Mobile No',
                    contentPadding: const EdgeInsets.all(14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA6CF6F),
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.all(14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA6CF6F),
                    hintText: 'Password',
                    contentPadding: const EdgeInsets.all(14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(width: 10.0), // Add some spacing between the text fields
              Expanded(
                child: TextField(
                  controller: _repasswordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFA6CF6F),
                    hintText: 'Re Enter pwd',
                    contentPadding: const EdgeInsets.all(14.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  obscureText: true,
                ),
              ),
            ],
          ),


          const SizedBox(height: 10.0),

          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Sign Up'),
          ),

          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "I already have an account",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: " Log In",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}