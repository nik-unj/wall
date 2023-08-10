import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/components/like_button.dart';
import 'package:wall/pages/comment_page.dart';
import 'package:wall/style/styles.dart';

class PostTile extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;
  const PostTile(
      {super.key,
      required this.message,
      required this.user,
      required this.postId,
      required this.likes,
      required this.time});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  TextEditingController commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  int comments = 0;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access the doc in firebase
    DocumentReference postRef = FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void showComments(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      context: ctx,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: CommentPage(
          user: widget.user,
          postId: widget.postId,
          message: widget.message,
          time: widget.time,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/person.png'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user,
                          style: CustomStyle.blackConcertBold(20),
                        ),
                        Text(
                          widget.time,
                          style: CustomStyle.blackOswald(10)
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15),
                child: Text(widget.message,
                    style: CustomStyle.blackOswald(16)
                        .copyWith(color: Colors.grey)),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      LikeButton(
                        isLiked: isLiked,
                        onTap: toggleLike,
                      ),
                      const SizedBox(width: 2),
                      Center(
                        child: Text(widget.likes.length.toString(),
                            textAlign: TextAlign.center,
                            style: CustomStyle.blackConcer(15)
                                .copyWith(color: Colors.grey)),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      showComments(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.comment_outlined),
                      ],
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
