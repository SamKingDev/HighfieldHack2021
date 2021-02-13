import 'package:flutter/material.dart';

class generateMealPlan extends StatefulWidget {
  @override
  _generateMealPlanState createState() => _generateMealPlanState();
}

class _generateMealPlanState extends State<generateMealPlan> {
  @override
  DateTime selectedDate = DateTime.now();

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
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('New Meal Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 50,),),),
          Container(
            child:Column(
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
                    'Select date',
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.greenAccent,
                ),
              ],
            )
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: RaisedButton.icon(
              color: Colors.white,
              onPressed: () {},
              icon: Icon(Icons.list),
              label: Text('Create New List'),
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
        ]),
      ),);
  }
}


