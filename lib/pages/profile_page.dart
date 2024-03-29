import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall/strings/strings.dart';
import 'package:wall/style/styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: 'Enter new $field'),
          onChanged: ((value) {
            newValue = value;
          }),
        ),
        actions: [
          TextButton(
            onPressed: (() => Navigator.pop(context)),
            child: const Text(Strings.cancel),
          ),
          TextButton(
            onPressed: (() => Navigator.of(context).pop(newValue)),
            child: const Text(Strings.save),
          ),
        ],
      ),
    );

    //update the firebase data
    if (newValue.trim().isNotEmpty) {
      if (field == 'Name') {
        await currentUser.updateDisplayName(newValue);
      } else {
        await currentUser.updatePhotoURL(newValue);
      }
      setState(() {
        currentUser = FirebaseAuth.instance.currentUser!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyle.white2bg(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              elevation: 5,
              child: Container(
                width: double.maxFinite,
                color: CustomStyle.whitebg(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, top: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.profile,
                        style: CustomStyle.blackOswald(25),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(50),
                child: currentUser.photoURL == null
                    ? const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/person.png'),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(currentUser.photoURL ?? ''),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.email}: ${currentUser.email}",
                        style: CustomStyle.blackOswald(20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${Strings.name}: ${currentUser.displayName ?? '-'}",
                        style: CustomStyle.blackOswald(20),
                      ),
                      InkWell(
                        onTap: () => editField('Name'),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          "${Strings.url}: ${currentUser.photoURL ?? '-'}",
                          style: CustomStyle.blackOswald(20),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: () => editField('Image'),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.logout,
                        style: CustomStyle.blackOswald(20),
                      ),
                      InkWell(
                        onTap: () => FirebaseAuth.instance.signOut(),
                        child: const Icon(Icons.logout_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
