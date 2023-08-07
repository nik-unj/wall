import 'package:flutter/material.dart';
import 'package:wall/components/list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;
  MyDrawer({super.key, required this.onLogoutTap, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),
          MyListTile(
            icon: Icons.home,
            name: "H O M E",
            onTap: () => Navigator.pop(context),
          ),
          MyListTile(
            icon: Icons.person,
            name: "Profile",
            onTap: onProfileTap,
          ),
          MyListTile(
            icon: Icons.logout,
            name: "Logout",
            onTap: onLogoutTap,
          ),
        ],
      ),
    );
  }
}
