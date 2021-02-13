import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class joinFamily extends StatefulWidget {
  @override
  _joinFamilyState createState() => _joinFamilyState();
}

class _joinFamilyState extends State<joinFamily> {
  final familyIdInput = TextEditingController();
  StreamSubscription<User> loginStateSubscription;
  var userId = "";

  @override
  void dispose() {
    familyIdInput.dispose();
    super.dispose();
  }

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
        DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(fbUser.uid);
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
        title: Text('Join A Family'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image(image: AssetImage(
              'assets/logo.png'),
            height: 60,
          ),
          SizedBox(height: 30),
          Text('Enter Family Code Below:',
              style: TextStyle(
                fontSize: 30.0,

              )),
          SizedBox(height: 50),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Code Here'),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
            controller: familyIdInput,
          ),
          SizedBox(height: 50),
          RaisedButton.icon(
            color: Colors.white,
            onPressed: () async {
              if (familyIdInput.text == null || familyIdInput.text == ""){
                return showDialog(context: context, builder: (context) {
                  return AlertDialog(
                      content: Text("Invalid Family ID")
                  );
                });
              }
              DocumentSnapshot family = await FirebaseFirestore.instance
                  .collection('families').doc(familyIdInput.text).get();
              print(family.data());
              if (family.data() == null)
                return showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    content: Text("Invalid Family ID")
                  );
                });
              else {
                FirebaseFirestore.instance.collection("users").doc(userId).update({"familyId": familyIdInput.text, "role": "Newb"});
              }
            }, icon: Icon(Icons.send), label: Text('Join Family'),)
        ],
      ),
    );
  }
}
