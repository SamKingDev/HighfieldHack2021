import 'package:flutter/material.dart';

class dailyMealPlan extends StatefulWidget {
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
            child: mealTile(() {}, "Breakfast"),
          ),
          Container(
            child: mealTile(() {}, "Lunch"),
          ),
          Container(
            child: mealTile(() {}, "Dinner"),
          ),
        ]),
      ),
    );
  }
}

class mealTile extends StatefulWidget {
  Function onTap;
  String mealType;

  mealTile(this.onTap, String mealType) {
    this.mealType = mealType;
  }

  @override
  _mealTile createState() => _mealTile();
}

class _mealTile extends State<mealTile> {
  String selectedValue = 'A';
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            style: TextStyle(
              color: Colors.deepPurple
            ),
            underline: Container(
              height: 2,
              color: Colors.deepPurple
            ),
            onChanged: (String newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
            items: <String>['A', 'B', 'C', 'D']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value)
                );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
