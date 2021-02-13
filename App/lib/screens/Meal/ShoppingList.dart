import 'package:flutter/material.dart';

class menu extends StatefulWidget {
  @override

  String category;
  menu(this.category);

  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {

  List<String> items = ['Carrot', 'Brocoli', 'Pear', 'Mash'];

  @override
  Widget build(BuildContext context) {
    return Container(child:
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(height:20.0),
          ExpansionTile(
            title: Text(widget.category,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            children: <Widget>[
              for ( var i in items ) Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(i),
                  Text('10')
                ],
              ),
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

            ],
          ),
        ],
      ),
    ),
    );
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
          Container(
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 50,
            ),
          ),
          Container(child: menu('Fresh Food')),
          Container(child: menu('Bakery')),
          Container(child: menu('Frozen Food')),
          Container(child: menu('Food Cupboard')),
          Container(),
          Container(),
        ]),
      ),
    );
  }
}
