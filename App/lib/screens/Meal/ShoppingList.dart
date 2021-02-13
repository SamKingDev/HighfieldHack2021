import 'package:flutter/material.dart';


class collapsiblemenu extends StatefulWidget {

  @override
  _collapsiblemenu createState() => _collapsiblemenu();
}
class _collapsiblemenu extends State<collapsiblemenu> {
  @override
  Widget build(BuildContext context) {
    return Text("HELLO");
//    return Scaffold(
//      body: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 30.0),
//        child: Column(
//          children: <Widget>[
//            SizedBox(height:20.0),
//            ExpansionTile(
//              title: Text(
//                "Week 1",
//                style: TextStyle(
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.bold
//                ),
//              ),
//              children: <Widget>[
//                ExpansionTile(
//                  title: Text(
//                    'Category 1',
//                  ),
//                  children: <Widget>[
//                    ListTile(
//                      title: Text('Food 1'),
//                    )
//                  ],
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
  }
}

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Shopping List'),
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
              child: collapsiblemenu()
          ),
          Container(
              child: collapsiblemenu()
          ),
          Container(
              child: collapsiblemenu()
          ),
          Container(
              child: collapsiblemenu()
          ),
          Container(
              child: collapsiblemenu()
          ),
        ]),
      ),
    );
  }
}