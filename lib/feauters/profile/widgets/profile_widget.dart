import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:maine_app/domain/user_theme.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User? user = FirebaseAuth.instance.currentUser;
    final UserTheme theme = GetIt.I.get<UserTheme>();

    if (user == null) {
      return const Center(
          child: Text('No user logged in'),
        );
      
    }

    final String? photoUrl = user.photoURL;
    final String? displayName = user.displayName;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: theme.blocsColor,
      ),
      height: screenSize.height * 0.155,
      width: screenSize.width * 0.90,
      margin: EdgeInsets.only(
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: Row(
        children: [
          const Spacer(),
          if (photoUrl != null)
            CircleAvatar(
              radius: screenSize.width * 0.1,
              backgroundImage: NetworkImage(photoUrl),
            ),
          SizedBox(width: screenSize.width * 0.05),
          const Spacer(),
          if (displayName != null)
            Text(
              displayName,
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
