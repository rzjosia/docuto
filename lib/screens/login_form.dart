import 'package:flutter/material.dart';
import 'package:ninja_trips/screens/home.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  String _username;
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    validator: (val) => val.isEmpty
                        ? 'Please enter your e-mail address.'
                        : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your password.' : null,
                    onSaved: (val) => _password = val,
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text('Log In'),
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
