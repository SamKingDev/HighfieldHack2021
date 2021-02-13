import 'package:flutter/material.dart';

class joinFamily extends StatefulWidget {
  @override
  _joinFamilyState createState() => _joinFamilyState();
}

class _joinFamilyState extends State<joinFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color.fromRGBO(61, 210, 204, 1),
      appBar: AppBar(
        title: Text('Join A Family'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Image(image: AssetImage(
              'assets/logo.png'),
            height: 60,
          ),
          SizedBox(height: 30),
          Text ('Enter Family Code Below:',
          style: TextStyle(
            fontSize: 30.0,

          )),
          SizedBox(height: 50),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Code Here'),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 50),
          RaisedButton.icon(
            color: Colors.white,
            onPressed: (){}, icon: Icon (Icons.send) , label: Text ('Join Family'),)
        ],
      ),
   );
  }
}
