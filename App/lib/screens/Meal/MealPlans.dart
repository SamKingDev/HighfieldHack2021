import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/Meal/GenerateMealPlan.dart';
import 'package:famealy/screens/Meal/SelectDay.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealPlans extends StatefulWidget {
  @override
  _MealPlansState createState() => _MealPlansState();
}

class _MealPlansState extends State<MealPlans> {

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
            CustomListTile(Icons.list, 'Shopping List', () => {}),
            CustomListTile(Icons.help, 'Tutorial', () => {}),
            CustomListTile(Icons.logout, 'Logout', () => {authBloc.logout()}),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Choose Week'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {createNewMealPlan(context);},
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
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
              child: DateListTile('date1', () {
            redirect(context);
          })),
          Container(
              child: DateListTile('date2', () {
            redirect(context);
          })),
          Container(
              child: DateListTile('date3', () {
            redirect(context);
          })),
          Container(
              child: DateListTile('date4', () {
            redirect(context);
          })),
          Container(
              child: DateListTile('date5', () {
            redirect(context);
          })),
        ]),
      ),
    );
  }
}

Function redirect(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => selectDay()),
  );
}

Function createNewMealPlan(context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => generateMealPlan()),
  );
}

class DateListTile extends StatefulWidget {
  String date;
  Function onTap;

  DateListTile(this.date, this.onTap);

  @override
  _DateListTile createState() => _DateListTile();
}

class _DateListTile extends State<DateListTile> {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.date,
                          style: TextStyle(
                            fontSize: 20.0,
                          )),
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
