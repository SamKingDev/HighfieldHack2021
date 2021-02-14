import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/Family/family.dart';
import 'package:famealy/screens/Meal/CreateMeal.dart';
import 'package:famealy/screens/Meal/MealPlans.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:famealy/screens/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ShoppingListMealPlans.dart';

class menu extends StatefulWidget {
  @override

  String category;
  Map<String, Food> foodMap = new Map<String, Food>();
  menu(this.category, this.foodMap);

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
              for ( var i in widget.foodMap.values ) Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${i.amount}x ${i.name}'),
                  Text('${i.calories * i.amount}')
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
  String mealPlanId = "";
  String familyId = "";
  List<Food> food = new List<Food>();

  ShoppingList(this.mealPlanId, this.familyId);

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
    print(widget.familyId);
    print(widget.mealPlanId);
    FirebaseFirestore.instance.collection("families").doc(widget.familyId).collection("mealplan").doc(widget.mealPlanId).collection("meals").get().then((planMeals) {
      for(var planMeal in planMeals.docs) {
        FirebaseFirestore.instance.collection("meals").doc(planMeal["mealId"]).collection("food").get().then((foodItems) {
          for(var foodItem in foodItems.docs) {
            FirebaseFirestore.instance.collection("foods").doc(foodItem["foodId"]).get().then((food) => {
              setState(() {
                widget.food.add(new Food(food["name"], foodItem["quantity"], food.id, food["calorie"]));
              })
            });
          }
        });
      }
    });
  }

  Widget build(BuildContext context) {
    Map<String, Food> foodMap = new Map<String, Food>();
    for (Food f in widget.food) {
      if (foodMap.containsKey(f.id)){
        Food newFood = new Food(f.name, f.amount + foodMap[f.id].amount, f.id, f.calories);
        foodMap.remove(f.id);
        foodMap.putIfAbsent(newFood.id, () => newFood);
      } else {
        foodMap.putIfAbsent(f.id, () => f);
      }
    }
    print(foodMap.length);
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
              MaterialPageRoute(builder: (context) => ShoppingListMealPlans()),
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
          Container(child: menu('Food', foodMap)),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}
