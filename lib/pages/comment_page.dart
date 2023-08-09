import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/comment.dart';
import 'package:wall/components/custom_textField.dart';
import 'package:wall/helper/toTime.dart';
import 'package:wall/strings.dart';
import 'package:wall/styles.dart';

class CommentPage extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  const CommentPage(
      {super.key,
      required this.message,
      required this.user,
      required this.postId,
      required this.time});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void addComment(String text) {
    if (text.trim().isNotEmpty) {
      FirebaseFirestore.instance
          .collection(Strings.postCollection)
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentText": text,
        "CommentUser": currentUser.email,
        "CommentTime": Timestamp.now()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.white2bg(),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Comments",
                  style: CustomStyle.blackOswald(20),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.black,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(Strings.postCollection)
                      .doc(widget.postId)
                      .collection("Comments")
                      .orderBy('CommentTime', descending: false)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final comm = snapshot.data!.docs[index];
                          return Comment(
                            user: comm['CommentUser'],
                            text: comm['CommentText'],
                            time: toDate(comm['CommentTime']),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error ${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.60),
            child: Container(
              color: CustomStyle.white2bg(),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/person.png'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomTextField(
                          controller: commentController,
                          hint: "Comment as ${currentUser.email}",
                          obscureText: false),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      addComment(commentController.text);
                      setState(() {
                        commentController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
