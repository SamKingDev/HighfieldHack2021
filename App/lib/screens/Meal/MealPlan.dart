import 'package:flutter/material.dart';

class mealPlan extends StatefulWidget {
  @override
  _mealPlanState createState() => _mealPlanState();
}

class _mealPlanState extends State<mealPlan> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          child: Material(
            elevation: 20,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset('assets/logo.png'),
            ),
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
        Container(

        ),
      ]),
    );
  }
}