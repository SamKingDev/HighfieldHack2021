import 'package:famealy/screens/Meal/MealPlans.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DailyMealPlan.dart';

class selectDay extends StatefulWidget {
  String mealPlanId;
  DateTime startDate;
  DateTime endDate;

  selectDay(String mealPlanId, DateTime startDate, DateTime endDate) {
    this.mealPlanId = mealPlanId;
    this.startDate = startDate;
    this.endDate = endDate;
  }

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
              child: DateShower(
                  widget.mealPlanId, widget.startDate, widget.endDate)),
        ]),
      ),
    );
  }
}

class DateShower extends StatefulWidget {
  String mealPlanId;
  DateTime startDate;
  DateTime endDate;

  DateShower(String mealPlanId, DateTime startDate, DateTime endDate) {
    this.mealPlanId = mealPlanId;
    this.startDate = startDate;
    this.endDate = endDate;
  }

  @override
  _DateShowerState createState() => _DateShowerState();
}

class _DateShowerState extends State<DateShower> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (int i = 0;
        i < widget.endDate.difference(widget.startDate).inDays;
        i++) {
      DateTime tempDate = widget.startDate;
      tempDate = tempDate.add(new Duration(days: i));
      list.add(Row(
        children: [
          DateListTile(new DateFormat.MMMMEEEEd('en_US').format(tempDate), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => dailyMealPlan(widget.mealPlanId, tempDate)),
            );
          })
        ],
      ));
    }
    return Column(children: list);
  }
}
