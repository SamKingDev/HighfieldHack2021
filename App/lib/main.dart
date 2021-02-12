import 'package:famealy/screens/login/login.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/profile': (context) => Profile(),
    },
  ));
}