import 'package:famealy/screens/Meal/MealPlans.dart';
import 'package:flutter/material.dart';

import 'DailyMealPlan.dart';

class selectDay extends StatefulWidget {
  @override
  _selectDayState createState() => _selectDayState();
}

class _selectDayState extends State<selectDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Choose Day'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 50,
            ),
          ),
          ),
          Container(
              child: DateListTile('Monday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Tuesday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Wednesday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Thursday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Friday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Saturday', (){redirectDay(context);})
          ),
          Container(
              child: DateListTile('Sunday', (){redirectDay(context);})
          ),
        ]),
      ),
    );
  }
}

Function redirectDay(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => dailyMealPlan()),
  );
}