import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CreateMeal.dart';
import 'MealPlans.dart';

class menu extends StatefulWidget {
  @override

  String category;
  menu(this.category);

  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {

  List<String> items = ['Carrot', 'Brocoli', 'Pear', 'Mash'];

  @override
  Widget build(BuildContext context) {
    return Container(child:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(height:20.0),
          ExpansionTile(
            title: Text(widget.category,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            children: <Widget>[
              for ( var i in items ) Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(i),
                  Text('10')
                ],
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}



class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
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
            CustomListTile(Icons.list, 'Shopping List', () => {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingList()),
            )}),
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
        title: Text('Shopping List'),
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
          Container(child: menu('Fresh Food')),
          Container(child: menu('Bakery')),
          Container(child: menu('Frozen Food')),
          Container(child: menu('Food Cupboard')),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}
