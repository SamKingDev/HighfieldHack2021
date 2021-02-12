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
      backgroundColor: new Color.fromRGBO(61,210,204,1),
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
            CustomListTile(Icons.person, 'Profile', ()=>{}),
            CustomListTile(Icons.notifications, 'Notifications', ()=>{}),
            CustomListTile(Icons.settings, 'Settings', ()=>{}),
            CustomListTile(Icons.logout, 'Logout', ()=>{}),
          ],
        ),
      ),
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


class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        splashColor: Colors.lightBlueAccent,
        onTap: onTap,
        child: Container(
          height: 40,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //x axis
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
      ),
    );
  }

}
