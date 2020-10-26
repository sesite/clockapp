import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color colorInDay = data['isDayTime'] ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/$bgImage'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              FlatButton.icon(
                onPressed: () async {
                  //* Пушим поверх роут location
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  if (result != null) {
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  }
                },
                icon: Icon(
                  Icons.edit_location,
                  color: colorInDay,
                ),
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: colorInDay,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2.0,
                      color: colorInDay,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 60,
                  letterSpacing: 1.0,
                  color: colorInDay,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
