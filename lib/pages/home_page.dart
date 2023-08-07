import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/add_post.dart';
import 'package:wall/components/wall_post.dart';
import 'package:wall/helper/toTime.dart';
import 'package:wall/strings.dart';
import 'package:wall/styles.dart';

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
                        "Welcome home,\n${currentUser.displayName!}",
                        style: CustomStyle.blackNeue(35),
                      ),
                      Text(
                        "Let's Start→",
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
                        return WallPost(
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );

    //   return Scaffold(
    //     appBar: AppBar(
    //       elevation: 1.0,
    //       backgroundColor: Colors.white,
    //       iconTheme: const IconThemeData(color: Colors.black),
    //       title: const Text(""),
    //     ),
    //     drawer: MyDrawer(
    //       onProfileTap: () {
    //         Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: ((context) => const ProfilePage())));
    //       },
    //       onLogoutTap: signOut,
    //     ),
    //     body: Container(
    //       decoration: const BoxDecoration(
    //           image: DecorationImage(
    //               fit: BoxFit.fill, image: AssetImage('assets/images/wall.jpg'))),
    //       child: Center(
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 15.0),
    //                 child: Row(
    //                   children: [
    //                     Expanded(
    //                       child: CustomTextField(
    //                         controller: messageController,
    //                         hint: Strings.enterMessage,
    //                         obscureText: false,
    //                       ),
    //                     ),
    //                     IconButton(
    //                       onPressed: postMessage,
    //                       icon: const Icon(
    //                         Icons.send,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Expanded(
    //                 child: StreamBuilder(
    //                   stream: FirebaseFirestore.instance
    //                       .collection(Strings.postCollection)
    //                       .orderBy(
    //                         'TimeStamp',
    //                         descending: true,
    //                       )
    //                       .snapshots(),
    //                   builder: (context, snapshot) {
    //                     if (snapshot.hasData) {
    //                       return ListView.builder(
    //                         itemCount: snapshot.data!.docs.length,
    //                         itemBuilder: (context, index) {
    //                           final post = snapshot.data!.docs[index];
    //                           return WallPost(
    //                             message: post['Message'],
    //                             user: post['UserEmail'],
    //                             postId: post.id,
    //                             time: toDate(post['TimeStamp']),
    //                             likes: List<String>.from(post['Likes']),
    //                           );
    //                         },
    //                       );
    //                     } else if (snapshot.hasError) {
    //                       return Text('Error ${snapshot.error}');
    //                     }
    //                     return const Center(
    //                       child: CircularProgressIndicator(),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
  }
}
