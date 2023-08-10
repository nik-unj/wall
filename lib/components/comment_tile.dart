import 'package:flutter/material.dart';
import 'package:wall/style/styles.dart';

class CommentTile extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const CommentTile(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: CustomStyle.whitebg(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user,
                          style: CustomStyle.blackOswaldBold(12),
                        ),
                        const SizedBox(width: 5,),
                        Text(
                          time,
                          style: CustomStyle.blackOswald(10),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(text, style: CustomStyle.blackOswald(12)),
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
