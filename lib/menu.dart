import 'package:flutter/material.dart';
import 'countdown.dart';
import 'progressmenu.dart';
//Class: Menu
//Purpose: Goes to MenuState
class Menu extends StatefulWidget {
  @override
  MenuState createState() => new MenuState();
}

//Class: MenuState
//Purpose: displays main menu
class MenuState extends State<Menu> {
  void _enterBlitzCountdownState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Countdown(1)),      
    );
  }

  void _enterSurvivalCountdownState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Countdown(2)),      
    );
  }

  void _enterPerfectionistCountdownState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Countdown(3)),      
    );
  }

  void _enterProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Progress()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Text Racer"),
      ),
      body: Center (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Welcome to Text Racer ",
              style: TextStyle(fontSize: 40.0)
            ),
            new FlatButton(
              onPressed: _enterBlitzCountdownState,
              child: Text("Play Blitz", style: TextStyle(fontSize: 20.0)),
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
            new FlatButton(
              onPressed: _enterSurvivalCountdownState,
              child: Text("Play Survival", style: TextStyle(fontSize: 20.0)),
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
            new FlatButton(
              onPressed: _enterPerfectionistCountdownState,
              child: Text("Play Perfectionist", style: TextStyle(fontSize: 20.0)),
              color: Colors.indigo,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
            new FlatButton(
              onPressed: _enterProgressState,
              child: Text("Progress", style: TextStyle(fontSize: 20.0)),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
          ],
        )
      )
    );
  }
}
