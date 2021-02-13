import 'package:flutter/material.dart';

class joinFamily extends StatefulWidget {
  @override
  _joinFamilyState createState() => _joinFamilyState();
}

class _joinFamilyState extends State<joinFamily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join A Family'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text ('Enter Family Code Below:',
          style: TextStyle(

          )),
          TextFormField(
            decoration: InputDecoration(
                labelText : 'Family Code'),
          ),
        ],
      ),
   );
  }
}
