import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamSubscription<User> loginStateSubscription;
  var email;
  var fullName;

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
        DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(fbUser.uid);

        documentReference.snapshots().listen((event) {
          setState(() {
            email = event.data()["email"];
            fullName = event.data()["full_name"];
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61,210,204,1),
      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                      Colors.lightBlueAccent,
                      Colors.blue
                    ])
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Material(
                        elevation: 20,
                        child: Padding(padding: EdgeInsets.all(5.0),
                        child: Image.asset('assets/logo.png'),
                      ),
                      ),
                    ],
                  ),
                ),
            ),
            CustomListTile(
                Icons.person,
                'Profile',
                    () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  )
                }),
            CustomListTile(
                Icons.group,
                'Family Group',
                    () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FamilyPage()),
                  )
                }),
            CustomListTile(Icons.fastfood, 'Meal Plan', ()=>{}),
            CustomListTile(Icons.list, 'Shopping List', ()=>{}),
            CustomListTile(Icons.help, 'Tutorial', ()=>{}),
            CustomListTile(Icons.logout, 'Logout', ()=>{authBloc.logout()}),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
            'Your Profile'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(
              'assets/logo.png'),
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 50.0,
                ),
              ),
            ),
            Column(
              children: [
                CustomProfileTile(Icons.account_box, 'Name', 'Emma'),
                CustomProfileTile(Icons.alternate_email, 'Email', 'Group 1'),
                CustomProfileTile(Icons.group, 'Family Group', 'Group 1'),
                ButtonTheme(
                  height: 20,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.pushNamed(context, '/aboutFamily');
                    }, //
                    child: Text('What are family groups?'),
                  ),
                ),
                CustomProfileTile(Icons.assignment, 'Dietry Requirements', 'FIODJFIJSD'),
                CustomProfileTile(Icons.announcement, 'Allergies', 'FIODJFIJSD'),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[400]))
        ),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text,
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
        ),
      ),
    );
  }
}


class CustomProfileTile extends StatelessWidget{

  IconData icon;
  String text;
  String content;

  CustomProfileTile(this.icon, this.text, this.content);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400]))
        ),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,
                        style: TextStyle(
                            fontSize: 16.0
                        ),
                      ),
                    ),
                  ],
                ),
                Text(content),
              ],
            ),
          ),
      ),
    );
  }
}