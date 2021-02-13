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
        Container(height: 500, color: Colors.red),
        Container(height: 500, color: Colors.green),
        Container(height: 500, color: Colors.orange),
        Container(height: 500, color: Colors.blue),
        Container(height: 500, color: Colors.red),
        Container(height: 500, color: Colors.green),
        Container(height: 500, color: Colors.orange),
      ]),
    );
  }
}