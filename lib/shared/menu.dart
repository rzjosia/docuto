import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja_trips/screens/home.dart';
import 'package:ninja_trips/screens/login_form.dart';

class Menu {
  static Drawer getMenu(BuildContext context) => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
'''
DoCuto

${FirebaseAuth.instance.currentUser?.displayName?.toUpperCase()}
${FirebaseAuth.instance.currentUser.email}
''',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            ListTile(
              title: Text('Medecins'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            ListTile(
              title: Text('Mes rendez-vous'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Deconnexion'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginForm()));
              },
            )
          ],
        ),
      );
}
