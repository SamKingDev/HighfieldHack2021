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
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        elevation: 10,
                        child: Padding(padding: EdgeInsets.all(8.0),
                        child: Image.asset('assets/logo.png', width: 80, height: 80),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Famealy Planner',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),),
                      ),
                    ],
                  ),
                ),
            ),
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
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/logo.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                CustomRow('First Name', '...'),
                CustomRow('Last Name', '...'),
                CustomRow('Family Group', '...'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {

  String text;
  String content;

  CustomRow(this.text, this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(height: 30.0),
      ],
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
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[400]))
        ),
        child: InkWell(
          splashColor: Colors.lightBlueAccent,
          onTap: onTap,
          child: Container(
            height: 50,
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
      ),
    );
  }

}
