import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String _email;
  String _password;
  String _messageError;

  void _submit(BuildContext context) {
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
                    validator: (val) =>
                        val.isEmpty ? 'Veuillez entrez un mot de passe' : null,
                    onSaved: (val) => _password = val,
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _submit(context);
                      },
                      child: Text('Valider'),
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
