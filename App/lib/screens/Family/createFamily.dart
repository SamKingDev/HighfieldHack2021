import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'family.dart';

class createFamily extends StatefulWidget {
  @override
  _createFamilyState createState() => _createFamilyState();
}

class _createFamilyState extends State<createFamily> {
  final familyNameInput = TextEditingController();
  StreamSubscription<User> loginStateSubscription;
  var userId = "";

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        userId = fbUser.uid;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Create Family'),
        centerTitle: true,
      ),
    body: Column(
      children: <Widget>[
        Image(image: AssetImage(
            'assets/logo.png'),
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text ('Enter Family Name Below:',
              style: TextStyle(
                fontSize: 30.0,
              )),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Family Name'),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          controller: familyNameInput,
        ),
        SizedBox(height: 10),
        RaisedButton.icon(
          color: Colors.white,
          onPressed: () async {
            DocumentReference docRef = await FirebaseFirestore.instance.collection('families').add({
              "name": familyNameInput.text,
            });
            await FirebaseFirestore.instance.collection("users").doc(userId).update({"familyId": docRef.id, "role": "Creator"});
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FamilyPage()),
            );
          }, icon: Icon (Icons.add) , label: Text ('Create new family'),)
      ],
    ),
    );
  }
}
