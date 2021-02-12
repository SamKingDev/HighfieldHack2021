import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(child: Text('This is a drawer header')),
            ListTile(
              title: Text('This is a tile'),
            ),
            ListTile(
              title: Text('This is a tile'),
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
      backgroundColor: new Color.fromRGBO(61,210,204,1),
      appBar: AppBar(
        title: Text(
            'Your Profile'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
        child: Column(
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                radius: 70.0,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text (
                  'First Name:',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text ('...',
                style: TextStyle(
                  fontSize: 25,
                ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text (
                  'Last Name:',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text (
                    '...',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text (
                  'Family Group:',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text (
                  '...',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
