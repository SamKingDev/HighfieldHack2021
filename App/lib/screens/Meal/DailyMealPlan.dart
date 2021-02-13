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
          Container(child: mealTile((){}),),
          Container(child: mealTile((){}),),
          Container(child: mealTile((){}),),
          Container(),
          Container(),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}

class mealTile extends StatefulWidget {
  Function onTap;

  mealTile(this.onTap);

  @override
  _mealTile createState() => _mealTile();
}

class _mealTile extends State<mealTile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[400]))),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: widget.onTap,
          child: Container(child: Text('Drop Down Box'),),
        ),
      ),
    );
  }
}
