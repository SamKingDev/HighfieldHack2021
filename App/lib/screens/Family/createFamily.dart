import 'package:flutter/material.dart';

class createFamily extends StatefulWidget {
  @override
  _createFamilyState createState() => _createFamilyState();
}

class _createFamilyState extends State<createFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Create Family'),
        centerTitle: true,
      ),
    body: Column(
      children: <Widget>[
        Image(image: AssetImage(
            'assets/logo.png'),
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text ('Enter Family Name Below:',
              style: TextStyle(
                fontSize: 30.0,
              )),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
              hintText: 'Family Name'),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        RaisedButton.icon(
          color: Colors.white,
          onPressed: (){}, icon: Icon (Icons.add) , label: Text ('Create new family'),)
      ],
    ),
    );
  }
}
