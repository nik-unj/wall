import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textField.dart';
import '../strings.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String error = '';

  void signUp() async {
    setState(() {
      error = '';
    });
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      setState(() {
        error = Strings.samePassword;
      });
    } else {
      try {
        //create a new user
        final currentUser = FirebaseAuth.instance.currentUser!;
        currentUser.updateDisplayName(emailController.text.split('@')[0]);

        //create new doc for user info
        // FirebaseFirestore.instance
        //     .collection(Strings.userCollection)
        //     .doc(userCredential.user!.email)
        //     .set({
        //   'Username': emailController.text.split('@')[0],
        //   'Bio': 'I am new to wall'
        // });
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        setState(() {
          error = e.code;
        });
      }
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
                "New here , lets get started",
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
              CustomTextField(
                controller: confirmPasswordController,
                hint: Strings.cPassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomButton(
                name: Strings.signUp,
                onTap: () {
                  signUp();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Strings.alrAMember,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      Strings.loginHere,
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
