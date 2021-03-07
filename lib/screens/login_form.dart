import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ninja_trips/screens/home.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email;
  String _password;
  String _messageError;

  void _submit(BuildContext context) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      signIn(context);
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      print('Email $_email');
      print('Mdp $_password');
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }

      if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      _messageError = 'E-mail ou mot de passe invalide';

      Fluttertoast.showToast(
          msg: _messageError,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      print(_messageError);
    }
  }

  Future<void> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      Fluttertoast.showToast(
          msg: "Oops ! Une erreur s'est produite",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRect(
                    child: Image.asset(
                      'images/docuto.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Se connecter avec Google",
                    onPressed: () async {
                      await signInWithGoogle(context);
                    },
                  ),
                  TextFormField(
                    onChanged: (val) => val.trim(),
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onSaved: (val) => _email = val.trim(),
                    validator: (val) => val.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val.trim())
                        ? 'Veuillez entrer un e-mail valide'
                        : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mot de passe'),
                    validator: (val) => val.isEmpty ? 'Veuillez entrez un mot de passe' : null,
                    onSaved: (val) => _password = val,
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text('Se connecter'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
