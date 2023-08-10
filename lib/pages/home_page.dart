import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/add_post.dart';
import 'package:wall/components/loading_widget.dart';
import 'package:wall/components/post_tile.dart';
import 'package:wall/helper/toDate.dart';
import 'package:wall/strings/strings.dart';
import 'package:wall/style/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController messageController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

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

  void addPost(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      context: ctx,
      builder: (ctx) => const SizedBox(height: 350, child: AddPost()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.white2bg(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 0, bottom: 75),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.black,
          ),
          onPressed: () => addPost(context),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              child: Container(
                height: 200,
                width: double.maxFinite,
                color: CustomStyle.whitebg(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome home,\n${currentUser.displayName ?? currentUser.email}",
                        style: CustomStyle.blackNeue(35),
                      ),
                      Text(
                        Strings.start,
                        style: CustomStyle.blackOswald(15)
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(Strings.postCollection)
                  .orderBy(
                    'TimeStamp',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 70),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return PostTile(
                          message: post['Message'],
                          user: post['UserEmail'],
                          postId: post.id,
                          time: toDate(post['TimeStamp']),
                          likes: List<String>.from(post['Likes']),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                return const Loading();
              },
            ),
          ],
        ),
      ),
    );
  }
}
