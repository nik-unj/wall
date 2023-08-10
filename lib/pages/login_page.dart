import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/custom_button.dart';
import 'package:wall/components/custom_textField.dart';
import 'package:wall/components/loading_widget.dart';
import 'package:wall/strings/strings.dart';
import 'package:wall/style/styles.dart';


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
    showDialog(context: context, builder: (context) => const Loading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
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
                'assets/images/key.png',
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
                Strings.seeAgain,
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
                child: CustomButton(
                  name: Strings.signIn,
                  onTap: () {
                    signIn();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.notAMember,
                      style: CustomStyle.blackOswald(15),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(Strings.registerHere,
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
