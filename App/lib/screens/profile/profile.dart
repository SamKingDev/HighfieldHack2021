import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/Meal/CreateMeal.dart';
import 'package:famealy/screens/ShoppingList/ShoppingList.dart';
import 'package:famealy/screens/Meal/MealPlans.dart';
import 'package:famealy/screens/ShoppingList/ShoppingListMealPlans.dart';
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
  var email = "";
  var fullName = "";
  var userId = "";
  var familyName = "";
  bool familyFound = false;

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
        documentReference.snapshots().listen((event) {
          setState(() {
            if (!mounted) return;
            email = event.data()["email"];
            fullName = event.data()["full_name"];
            if (event.data()["familyId"] != null &&
                event.data()["familyId"] != "") {
              DocumentReference familyReference = FirebaseFirestore.instance
                  .collection('families')
                  .doc(event.data()["familyId"]);
              familyReference.snapshots().listen((fEvent) {
                setState(() {
                  if (!mounted) return;
                  familyName = fEvent.data()["name"];
                  familyFound = true;
                });
              });
            } else {
              familyName = "No current family";
              familyFound = false;
            }
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
                          MaterialPageRoute(builder: (context) => MealPlans()),
                        )
                      }),
              CustomListTile(Icons.list, 'Shopping List', () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingListMealPlans()),
                )
              }),
              CustomListTile(Icons.add, 'Create New Meal', () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => createMeal()),
                )
              }),
              CustomListTile(Icons.help, 'Tutorial', () => {}),
              CustomListTile(Icons.logout, 'Logout', () => {authBloc.logout()}),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Your Profile'),
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
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 50.0,
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  CustomProfileTile(Icons.account_box, 'Name', fullName),
                  CustomProfileTile(Icons.alternate_email, 'Email', email),
                  CustomProfileTile(Icons.group, 'Family Group', familyName),
                  Visibility(
                    child: ButtonTheme(
                      height: 20,
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.pushNamed(context, '/aboutFamily');
                        }, //
                        child: Text('Become a family.'),
                      ),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: !familyFound,
                  ),
                  Visibility(
                    child: ButtonTheme(
                      height: 20,
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(userId)
                              .update({"familyId": "", "role": ""});
                        }, //
                        child: Text('Leave Family.'),
                      ),
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: familyFound,
                  ),
                  dietryRequirementsTile(
                          () {}, Icons.assignment, 'Dietry Requirements'),
                  allergyTile(() {}, Icons.announcement, 'Allergies'),
                ],
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
          ]),
        ));
  }
}

class CustomListTile extends StatefulWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400]))),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: widget.onTap,
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
                    )
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

class CustomProfileTile extends StatefulWidget {
  IconData icon;
  String text;
  String content;

  CustomProfileTile(this.icon, this.text, this.content);

  @override
  _CustomProfileTileState createState() => _CustomProfileTileState();
}

class _CustomProfileTileState extends State<CustomProfileTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              Text(widget.content),
            ],
          ),
        ),
      ),
    );
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
                style: TextStyle(color: Colors.black),
                underline: Container(height: 2, color: Colors.black),
                onChanged: (String newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: <String>['None', 'Vegan', 'Vegetarian', 'Pescetarian']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class allergyTile extends StatefulWidget {
  Function onTap;
  String requirement;
  IconData icon;
  String text;

  allergyTile(this.onTap, this.icon, this.text);

  @override
  _allergyTile createState() => _allergyTile();
}

class _allergyTile extends State<allergyTile> {
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
                style: TextStyle(color: Colors.black),
                underline: Container(height: 2, color: Colors.black),
                onChanged: (String newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: <String>[
                  'None',
                  'Gluten',
                  'Crustaceans',
                  'Eggs',
                  'Fish',
                  'Peanuts',
                  'Soya',
                  'Milk',
                  'Tree Nuts',
                  'Celery',
                  'Mustard',
                  'Sesame',
                  'Sulphites',
                  'Lupin',
                  'Molluscs'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
