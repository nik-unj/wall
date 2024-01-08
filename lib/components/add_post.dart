import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wall/strings/strings.dart';
import 'package:wall/style/styles.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController messageController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;

  void postMessage() {
    if (messageController.text.isNotEmpty && pickedFile != null) {
      String path = 'files/${currentUser.email}/${Timestamp.now()}';
      File file = File(pickedFile!.path!);
      FirebaseFirestore.instance.collection(Strings.postCollection).add({
        'UserEmail': currentUser.email,
        'Message': messageController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
        'Path': path
      });
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file).whenComplete((() => Navigator.of(context).pop()));
      setState(() {
        messageController.text = '';
        pickedFile = null;
      });
    } else if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection(Strings.postCollection).add({
        'UserEmail': currentUser.email,
        'Message': messageController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
        'Path': ''
      }).whenComplete((() => Navigator.of(context).pop()));
      setState(() {
        messageController.text = '';
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      Strings.createPost,
                      style: CustomStyle.blackConcertBold(25),
                    ),
                  ),
                  TextField(
                    controller: messageController,
                    maxLines: 5,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      hintText: Strings.writemsg,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            selectFile();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Select Image",
                              style: CustomStyle.blackOswaldBold(18)
                                  .copyWith(color: Colors.white),
                            ),
                          )),
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
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              Strings.post,
                              style: CustomStyle.blackOswaldBold(18)
                                  .copyWith(color: Colors.white),
                            ),
                          )),
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
