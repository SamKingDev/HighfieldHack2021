import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famealy/blocs/auth_bloc.dart';
import 'package:famealy/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MealPlans.dart';

class generateMealPlan extends StatefulWidget {
  @override
  _generateMealPlanState createState() => _generateMealPlanState();
}

class _generateMealPlanState extends State<generateMealPlan> {
  @override
  DateTime selectedDate = DateTime.now();
  String familyId = "";

  // ignore: cancel_subscriptions
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
      } else {
        DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(fbUser.uid);
        documentReference.snapshots().listen((event) {
          setState(() {
            if (!mounted) return;
            familyId = event.data()["familyId"];
          });
        });
      }
    });
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('New Meal Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 50,),),),
          Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () => _selectDate(context), // Refer step 3
                    child: Text(
                      'Select Starting Date',
                      style:
                      TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.greenAccent,
                  ),
                ],
              )
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: RaisedButton.icon(
              color: Colors.white,
              icon: Icon(Icons.list),
              label: Text('Create New List'),
              onPressed: () async {
                DateTime endDate = selectedDate.add(new Duration(days: 7));
                DocumentReference docRef = await FirebaseFirestore.instance.collection('families').doc(familyId).collection('mealplan').add({
                  "startDate": selectedDate,
                  "endDate": endDate,
                });
                DateTime currentDate = selectedDate;
                QuerySnapshot breakfastSnapshot = await FirebaseFirestore.instance.collection('meals').where("type", isEqualTo: "Breakfast").get();
                List<QueryDocumentSnapshot> tempBreakfasts = breakfastSnapshot.docs;
                QuerySnapshot lunchSnapshot = await FirebaseFirestore.instance.collection('meals').where("type", isEqualTo: "Lunch").get();
                List<QueryDocumentSnapshot> tempLunches = lunchSnapshot.docs;
                QuerySnapshot dinnerSnapshot = await FirebaseFirestore.instance.collection('meals').where("type", isEqualTo: "Dinner").get();
                List<QueryDocumentSnapshot> tempDinners = dinnerSnapshot.docs;

                WriteBatch batch = FirebaseFirestore.instance.batch();

                Random random = new Random();

                for(int i = 0; i < endDate.difference(selectedDate).inDays; i++){
                  if (tempBreakfasts.isEmpty) tempBreakfasts = breakfastSnapshot.docs;
                  if (tempLunches.isEmpty) tempLunches = lunchSnapshot.docs;
                  if (tempDinners.isEmpty) tempDinners = dinnerSnapshot.docs;

                  int breakfastNumber = random.nextInt(tempBreakfasts.length);
                  batch.set(docRef.collection('meals').doc(), {'date': currentDate, 'mealId': tempBreakfasts[breakfastNumber].id});
                  tempBreakfasts.removeAt(breakfastNumber);

                  int lunchNumber= random.nextInt(tempLunches.length);
                  batch.set(docRef.collection('meals').doc(), {'date': currentDate, 'mealId': tempLunches[lunchNumber].id});
                  tempLunches.removeAt(lunchNumber);

                  int dinnerNumber = random.nextInt(tempDinners.length);
                  batch.set(docRef.collection('meals').doc(), {'date': currentDate, 'mealId': tempDinners[dinnerNumber].id});
                  tempDinners.removeAt(dinnerNumber);

                  currentDate = currentDate.add(new Duration(days: 1));
                }

                batch.commit();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MealPlans(),
                  ),
                );
              },
            ),
          ),
          Container(
          ),
        ]),
      ),);
  }
}


