import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../strings.dart';
import '../components/custom_button.dart';
import '../components/custom_textField.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;

  const LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String error = '';

  void signIn() async {
    setState(() {
      error = '';
    });
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      setState(() {
        error = e.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 100, color: Colors.grey),
              const SizedBox(height: 20),
              error.isNotEmpty ? Text(error) : Container(),
              const SizedBox(height: 20),
              const Text(
                "Good to see you again",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hint: Strings.email,
                obscureText: false,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hint: Strings.password,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                name: Strings.signIn,
                onTap: () {
                  signIn();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Strings.notAMember,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      Strings.registerHere,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
