import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Colors.lightBlueAccent,
                    Colors.blue
                  ])
                ),
                child: Text('This is a drawer header')),
            ListTile(
              title: Text('This is a tile'),
              onTap: (){

              },
            ),
            CustomListTile(

            ),
            ListTile(
              title: Text('This is a tile'),
            ),
            ListTile(
              title: Text('This is a tile'),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomListTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Row(
        children: <Widget>[
          Icon(Icons.person),
          Text('Profile'),
          Icon(Icons.arrow_right),
        ],
      ),
    );
  }

}
