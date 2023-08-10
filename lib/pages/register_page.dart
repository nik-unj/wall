import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/style/styles.dart';
import '../components/custom_button.dart';
import '../components/custom_textField.dart';
import '../strings/strings.dart';

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
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((value) => Navigator.pop(context));
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
      backgroundColor: CustomStyle.white2bg(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Material(
          elevation: 15,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/customer-service.png',
                height: 150,
              ),
              const SizedBox(height: 20),
              error.isNotEmpty
                  ? Text(
                      error,
                      style: CustomStyle.blackOswald(15)
                          .copyWith(color: Colors.red),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Text(
                "New here , lets get started",
                style: CustomStyle.blackOswaldBold(25),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  controller: emailController,
                  hint: Strings.email,
                  obscureText: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  controller: passwordController,
                  hint: Strings.password,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  controller: confirmPasswordController,
                  hint: Strings.cPassword,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                  name: Strings.signUp,
                  onTap: () {
                    signUp();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.alrAMember,
                      style: CustomStyle.blackOswald(15),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(Strings.loginHere,
                          style: CustomStyle.blackOswaldBold(15)
                              .copyWith(color: Colors.blueAccent)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
