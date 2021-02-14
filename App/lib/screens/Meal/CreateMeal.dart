import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/ShoppingList/ShoppingListMealPlans.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MealPlans.dart';
import 'package:famealy/screens/ShoppingList/ShoppingList.dart';

class Food {
  String name;
  int amount;
  String id;

  Food(this.name, this.amount, this.id);

}

class createMeal extends StatefulWidget {
  @override
  _createMealState createState() => _createMealState();
  List<QueryDocumentSnapshot> foodSnapshots = new List<QueryDocumentSnapshot>();
  List<Food> foods = new List<Food>();
}

class _createMealState extends State<createMeal> {
  String selectedValue = 'Carrot';
  String mealTypeSelectedValue = 'Breakfast';
  StreamSubscription<User> loginStateSubscription;
  final quantityInput = TextEditingController();
  final mealNameInput = TextEditingController();
  final portionInput = TextEditingController();

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
    FirebaseFirestore.instance
        .collection('foods')
        .orderBy('name')
        .get()
        .then((value) => setState(() {
      widget.foodSnapshots = value.docs;
      selectedValue = value.docs.first.id;
    }));
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
              CustomListTile(
                  Icons.list,
                  'Shopping List',
                  () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingListMealPlans()),
                        )
                      }),
              CustomListTile(
                  Icons.add,
                  'Create New Meal',
                  () => {
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Create A New Meal',
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Meal Name'),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    controller: mealNameInput,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Number of Portions'),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    controller: portionInput,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 0.0),
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

                        items: widget.foodSnapshots.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                              value: e.id, child: Text(e['name']));
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: mealTypeSelectedValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(height: 2, color: Colors.black),
                        onChanged: (String newValue) {
                          setState(() {
                            mealTypeSelectedValue = newValue;
                          });
                        },

                        items: <String>["Breakfast", "Lunch", "Dinner"].map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                              value: e, child: Text(e));
                        }).toList(),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Quantity'),
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          controller: quantityInput,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        splashColor: Colors.grey[200],
                        onPressed: () {
                          final numericRegex =
                          RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
                          if (quantityInput.text == "" || quantityInput == null || !numericRegex.hasMatch(quantityInput.text)) {
                            return showDialog(
                                context: context, builder: (context) {
                              return AlertDialog(
                                  content: Text("Invalid Quantity")
                              );
                            });
                          }
                          widget.foods.add(new Food(widget.foodSnapshots.firstWhere((element) => element.id == selectedValue)['name'], int.parse(quantityInput.text), selectedValue));
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Container(
                    child: ingredientsDropDown(widget.foods),
                  ),
                  Container(
                    child: RaisedButton.icon(
                      color: Colors.white,
                      icon: Icon(Icons.list),
                      label: Text('Create New Meal'),
                      onPressed: () async {
                        final numericRegex =
                        RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
                        if (widget.foods.length < 1) return showDialog(
                            context: context, builder: (context) {
                          return AlertDialog(
                              content: Text("You must add at least one food")
                          );
                        });
                        if (mealNameInput.text == null || mealNameInput.text == "") return showDialog(
                            context: context, builder: (context) {
                          return AlertDialog(
                              content: Text("You must set the meal name")
                          );
                        });
                        if (portionInput.text == null || portionInput.text == "" || !numericRegex.hasMatch(quantityInput.text)) return showDialog(
                            context: context, builder: (context) {
                          return AlertDialog(
                              content: Text("You must add a number of potions and it must be a number")
                          );
                        });
//                        var foodArray = [];
//                        for(var i in widget.foods)foodArray.add([i.id, i.amount]);
                        DocumentReference docRef = await FirebaseFirestore.instance.collection('meals').add({
                          "name": mealNameInput.text,
                          "type":  mealTypeSelectedValue,
                          "portions": int.parse(quantityInput.text)
                        });
                        for (var i in widget.foods) FirebaseFirestore.instance.collection("meals").doc(docRef.id).collection("food").add({
                          "foodId": i.id,
                          "quantity": i.amount
                        });
                        return showDialog(
                            context: context, builder: (context) {
                          return AlertDialog(
                              content: Text("Meal successfully added")
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(),
            Container(),
            Container(),
            Container(),
            Container(),
          ]),
        ));
  }
}

class ingredientsDropDown extends StatefulWidget {
  List<Food> foods = new List<Food>();

  ingredientsDropDown(this.foods);

  @override
  _ingredientsDropDown createState() => _ingredientsDropDown();
}

class _ingredientsDropDown extends State<ingredientsDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Text(
                'Ingredients',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                if (widget.foods != null) for (var i in widget.foods)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("x " + i.amount.toString() + " " + i.name),
                      IconButton(
                        icon: Icon(Icons.delete),
                        splashColor: Colors.grey[200],
                        onPressed: () {
                          widget.foods.removeWhere((element) => element.id == i.id);
                          setState(() {});
                        },
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
