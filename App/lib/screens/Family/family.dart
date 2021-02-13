import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Meal/MealPlan.dart';
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
              CustomListTile(
                  Icons.fastfood,
                  'Meal Plan',
                  () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mealPlan()),
                        )
                      }),
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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 50,
              ),
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/family.jpg'),
                    radius: 50.0,
                  ),
                ),
              ),
            ),
            Container(
                child: Column(
              children: [
                CustomProfileTile(Icons.group, 'Members', 'FIODJFIJSD'),
                CustomProfileTile(Icons.account_box, 'Name', 'FIODJFIJSD'),
                dietryRequirementsTile((){}, Icons.assignment, 'Dietry Requirements'),
                CustomProfileTile(
                    Icons.announcement, 'Allergies', 'FIODJFIJSD'),
              ],
            )),
            Container(

            ),
            Container(
              child: RaisedButton.icon(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.fastfood),
                label: Text('View Weekly Meal Plan'),
              ),
            ),
            Container(
              child: RaisedButton.icon(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(Icons.list),
                label: Text('View Shopping List'),
              ),
            ),
            Container(),
            Container(),
          ]),
        ));
  }
}

class FamilyListWidget extends StatefulWidget {
  @override
  _FamilyListWidgetState createState() => _FamilyListWidgetState();
}

class _FamilyListWidgetState extends State<FamilyListWidget> {
  List<IconData> icons = [
    Icons.group,
    Icons.account_box,
    Icons.assignment,
    Icons.announcement
  ];

  List<String> information = [
    'Members',
    'Name',
    'Dietry Requirements',
    'Allergies',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: ListView.builder(
        itemCount: information.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icons[index]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        information[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Text('Emma'),
              ],
            ),
          );
        },
      ),
    ));
  }
}


class dietryRequirementsTile extends StatefulWidget {
  Function onTap;
  String requirement;
  IconData icon;
  String text;

    dietryRequirementsTile(this.onTap, this.icon, this.text);

  @override
  _dietryRequirementsTile createState() => _dietryRequirementsTile();
}

class _dietryRequirementsTile extends State<dietryRequirementsTile> {
  String selectedValue = 'None';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400]))),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(widget.icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
              DropdownButton<String>(
                value: selectedValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                    color: Colors.deepPurple
                ),
                underline: Container(
                    height: 2,
                    color: Colors.deepPurple
                ),
                onChanged: (String newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: <String>['None', 'Vegan', 'Vegetarian', 'Pescetarian']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}