import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dailyMealPlan extends StatefulWidget {
  String mealPlanId;
  DateTime date;

  dailyMealPlan(mealPlanId, date) {
    this.mealPlanId = mealPlanId;
    this.date = date;
  }

  @override
  _dailyMealPlanState createState() => _dailyMealPlanState();
}

class _dailyMealPlanState extends State<dailyMealPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Your Meal Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 50,
              ),
            ),
          ),
          Container(
            child: mealTile(() {}, "Breakfast", widget.mealPlanId, widget.date),
          ),
          Container(
            child: mealTile(() {}, "Lunch", widget.mealPlanId, widget.date),
          ),
          Container(
            child: mealTile(() {}, "Dinner", widget.mealPlanId, widget.date),
          ),
        ]),
      ),
    );
  }
}

class mealTile extends StatefulWidget {
  Function onTap;
  String mealType;
  String mealPlanId;
  DateTime date;
  List<QueryDocumentSnapshot> breakfastSnapshot;
  List<QueryDocumentSnapshot> lunchSnapshot;
  List<QueryDocumentSnapshot> dinnerSnapshot;
  List<QueryDocumentSnapshot> mealSnapshots;
  List<QueryDocumentSnapshot> availableMeals;
  List<String> mealNames;
  String familyId;
  var correctMeal;
  var updateMeal;

  mealTile(this.onTap, String mealType, mealPlanId, date) {
    this.mealType = mealType;
    this.mealPlanId = mealPlanId;
    this.date = date;
  }

  @override
  _mealTile createState() => _mealTile();
}

class _mealTile extends State<mealTile> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('meals')
        .where("type", isEqualTo: "Breakfast")
        .get()
        .then((value) => setState(() {
              widget.breakfastSnapshot = value.docs;
              if (widget.mealType == "Breakfast")
                widget.availableMeals = value.docs;
            }));
    FirebaseFirestore.instance
        .collection('meals')
        .where("type", isEqualTo: "Lunch")
        .get()
        .then((value) => setState(() {
              widget.lunchSnapshot = value.docs;
              if (widget.mealType == "Lunch")
                widget.availableMeals = value.docs;
            }));
    FirebaseFirestore.instance
        .collection('meals')
        .where("type", isEqualTo: "Dinner")
        .get()
        .then((value) => setState(() {
              widget.dinnerSnapshot = value.docs;
              if (widget.mealType == "Dinner")
                widget.availableMeals = value.docs;
            }));
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
        documentReference.snapshots().listen((event) {
          setState(() {
            if (!mounted) return;
            widget.familyId = event.data()["familyId"];
            FirebaseFirestore.instance
                .collection('families')
                .doc(widget.familyId)
                .collection('mealplan')
                .doc(widget.mealPlanId)
                .collection('meals')
                .where('date', isEqualTo: widget.date)
                .get()
                .then((value) => setState(() {
                      widget.mealSnapshots = value.docs;
                    }));
          });
        });
      }
    });
  }

  String selectedValue;

  @override
  Widget build(BuildContext context) {
    if (widget.mealSnapshots != null &&
        widget.breakfastSnapshot != null &&
        widget.lunchSnapshot != null &&
        widget.dinnerSnapshot != null) {
      for (int i = 0; i < widget.mealSnapshots.length; i++) {
        widget.correctMeal = widget.availableMeals.firstWhere(
                (element) => element.id == widget.mealSnapshots[i]['mealId'],
            orElse: () {});
        if (widget.correctMeal != null) selectedValue = widget.correctMeal.id;
      }
      for (int i = 0; i < widget.availableMeals.length; i++) {
        widget.updateMeal = widget.mealSnapshots.firstWhere(
                (element) => element['mealId'] == widget.availableMeals[i].id,
            orElse: () {});
        if (widget.updateMeal != null) break;
      }
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.mealType),
            DropdownButton<String>(
              value: selectedValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(height: 2, color: Colors.deepPurple),
              onChanged: (String newValue) {
                FirebaseFirestore.instance
                    .collection('families')
                    .doc(widget.familyId)
                    .collection('mealplan')
                    .doc(widget.mealPlanId)
                    .collection('meals')
                    .doc(widget.updateMeal.id)
                    .update({'mealId': newValue})
                .then((value) => setState(() {initState();}))
                .catchError((e) {print(e);});
              },
              items: widget.availableMeals.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                    value: e.id, child: Text(e['name']));
              }).toList(),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
