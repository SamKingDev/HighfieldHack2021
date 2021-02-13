import 'package:famealy/screens/Family/createFamily.dart';
import 'package:famealy/screens/Family/joinFamily.dart';
import 'package:flutter/material.dart';

class aboutFamily extends StatefulWidget {
  @override
  _aboutFamilyState createState() => _aboutFamilyState();
}

class _aboutFamilyState extends State<aboutFamily> {

  List<String> options = [
    'Join A Family',
    'Create A Family',
  ];

  void redirect(index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => joinFamily(),
        ),
      );
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => createFamily(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text('Information about families'),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        redirect(index);
                      },
                      title: Center(child: Text(options[index])),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}