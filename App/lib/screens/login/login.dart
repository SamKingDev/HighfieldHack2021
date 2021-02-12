import 'dart:io';

import 'package:famealy/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61,107,137, 1),
      appBar: AppBar(
        title: Text(
            "Famealy - Login",
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {Navigator.pushNamed(context, '/profile');},
              child: Text('Login with Google'),
            ),
            RaisedButton(
              onPressed: (){exit(0);},
              child: Text('Exit')
            )
          ],
        ),
      ),
    );
  }
}