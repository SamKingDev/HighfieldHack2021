import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FamilyPage extends StatefulWidget {
  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
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
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.lightBlueAccent, Colors.blue])),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Material(
                      elevation: 20,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
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
            CustomListTile(Icons.fastfood, 'Meal Plan', () => {}),
            CustomListTile(Icons.list, 'Shopping List', () => {}),
            CustomListTile(Icons.help, 'Tutorial', () => {}),
            CustomListTile(Icons.logout, 'Logout', () => {authBloc.logout()}),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Your Family Group'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              height: 50,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/family.jpg'),
                  radius: 50.0,
                ),
              ),
            ),
            //CustomRow('Members:', '...'),
            //CustomRow('Name:', '...'),
            //CustomRow('Dietry Preferences:', '...'),
            //CustomRow('Allergies:', '...'),
            RaisedButton.icon(
              color: Colors.white,
              onPressed: (){}, icon: Icon (Icons.fastfood) , label: Text ('View Weekly Meal Plan'),),
            RaisedButton.icon(
              color: Colors.white,
              onPressed: (){}, icon: Icon (Icons.list) , label: Text ('View Shopping List'),),

          ],
        ),
      ),
    );
  }
}
