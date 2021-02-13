import 'package:famealy/screens/Meal/SelectDay.dart';
import 'package:flutter/material.dart';

class mealPlan extends StatefulWidget {
  @override
  _mealPlanState createState() => _mealPlanState();
}

class _mealPlanState extends State<mealPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Choose Week'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Image(
            image: AssetImage('assets/logo.png'),
            height: 50,
          ),
          ),
          Container(
              child: DateListTile('date1', (){redirect(context);})
          ),
          Container(
              child: DateListTile('date2', (){redirect(context);})
          ),
          Container(
              child: DateListTile('date3', (){redirect(context);})
          ),
          Container(
              child: DateListTile('date4', (){redirect(context);})
          ),
          Container(
              child: DateListTile('date5', (){redirect(context);})
          ),
        ]),
      ),
    );
  }
}

Function redirect(context){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => selectDay()),
  );
}

class DateListTile extends StatefulWidget {
  String date;
  Function onTap;

  DateListTile(this.date, this.onTap);

  @override
  _DateListTile createState() => _DateListTile();
}

class _DateListTile extends State<DateListTile> {
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
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.date,
                      style: TextStyle(
                        fontSize: 20.0,
                      )
                      ),
                      ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}