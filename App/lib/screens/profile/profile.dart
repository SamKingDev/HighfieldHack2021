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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Material(
                        elevation: 20,
                        child: Padding(padding: EdgeInsets.all(5.0),
                        child: Image.asset('assets/logo.png'),
                      ),
                      ),
                    ],
                  ),
                ),
            ),
            CustomListTile(Icons.person, 'Profile', ()=>{}),
            CustomListTile(Icons.group, 'Family Group', ()=>{}),
            CustomListTile(Icons.fastfood, 'Meal Plan', ()=>{}),
            CustomListTile(Icons.list, 'Shopping List', ()=>{}),
            CustomListTile(Icons.help, 'Tutorial', ()=>{}),
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image(image: AssetImage(
              'assets/logo.png'),
              height: 60,
            ),
            CustomRow('First Name:', '...'),
            CustomRow('Last Name:', '...'),
            CustomRow('Family Group:', '...'),
            CustomRow('Dietry Preferences:', '...'),
            CustomRow('Allergies:', '...'),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: labelBoxDecoration(),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Container(
          decoration: contentBoxDecoration(),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
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


BoxDecoration labelBoxDecoration() {
  return BoxDecoration(
    color: Colors.grey[400],
    border: Border.all(
        width: 3.0,
      color: Colors.grey[800]
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(15.0) //                 <--- border radius here
    ),
  );
}

BoxDecoration contentBoxDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide( //                   <--- left side
        color: Colors.grey[500],
        width: 3.0,
      ),
    ),
  );
}