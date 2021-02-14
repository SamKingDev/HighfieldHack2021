import 'dart:async';

import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MealPlans.dart';
import 'ShoppingList.dart';

class createMeal extends StatefulWidget {
  @override
  _createMealState createState() => _createMealState();
}

class _createMealState extends State<createMeal> {

  String selectedValue = 'Carrot';
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
                      () =>
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    )
                  }),
              CustomListTile(
                  Icons.group,
                  'Family Group',
                      () =>
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FamilyPage()),
                    )
                  }),
              CustomListTile(
                  Icons.fastfood,
                  'Meal Plan',
                      () =>
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealPlans()),
                    )
                  }),
              CustomListTile(Icons.list, 'Shopping List', () =>
              {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingList()),
              )}),
              CustomListTile(Icons.add, 'Create New Meal', () =>
              {
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
          title: Text('Create New Meal'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              child:Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage(
                        'assets/logo.png'),
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text ('Create A New Meal',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Meal Name'),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Number of Portions'),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,15.0,8.0,0.0),
                    child: Text('Ingredients',
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
                  ),
                  Row(
                    children: [
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
                        items: <String>['Carrot', 'Brocoli', 'Parsnip', 'Sausage']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Quantity'),
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        splashColor: Colors.grey[200],
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                    child : ingredientsDropDown(),
                  ),
                  Container(
                    child: RaisedButton.icon(
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.list),
                      label: Text('Create New Meal'),
                    ),
                  ),
                ],
              ),
            ),
            Container(

            ),
            Container(

            ),
            Container(

            ),
            Container(

            ),
            Container(

            ),
          ]),
        )
    );
  }
}



class ingredientsDropDown extends StatefulWidget {
  @override
  _ingredientsDropDown createState() => _ingredientsDropDown();
}

class _ingredientsDropDown extends State<ingredientsDropDown> {

  List<String> items = ['Carrot', 'Brocoli', 'Pear', 'Mash'];

  @override
  Widget build(BuildContext context) {
    return Container(child:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          ExpansionTile(
            title: Text('Ingredients',
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
                  IconButton(
                    icon: Icon(Icons.delete),
                    splashColor: Colors.grey[200],
                    onPressed: () {},
                  ),
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
