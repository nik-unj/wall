import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/strings.dart';
import 'package:wall/styles.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController messageController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!;

  void postMessage() {
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection(Strings.postCollection).add({
        'UserEmail': currentUser.email,
        'Message': messageController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
      setState(() {
        messageController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  "Create Post",
                  style: CustomStyle.blackConcertBold(25),
                ),
              ),
              TextField(
                controller: messageController,
                maxLines: 7,
                autocorrect: false,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Write Message ...",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        postMessage();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Post",
                          style: CustomStyle.blackOswaldBold(18),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
