import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  StreamSubscription<User> loginStateSubscription;

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
              height: 60,
            ),
            Column(
              children: [
                CustomRow('First Name:', '...'),
                CustomRow('Last Name:', '...'),
                SizedBox(height: 20),
                FamilyCustomRow('Family Group:', '...'),
                CustomRow('Dietry Preferences:', '...'),
                CustomRow('Allergies:', '...'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyCustomRow extends StatelessWidget {

  String text;
  String content;

  FamilyCustomRow(this.text, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: labelBoxDecoration(),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: labelBoxDecoration(),
                child: Center(
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      ],
    );
  }
}

class CustomRow extends StatelessWidget {

  String text;
  String content;

  CustomRow(this.text, this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: labelBoxDecoration(),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: labelBoxDecoration(),
            child: Center(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 70),
      ],
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


BoxDecoration labelBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(
        width: 1.0,
      color: Colors.grey[800]
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(15.0) //                 <--- border radius here
    ),
  );
}

