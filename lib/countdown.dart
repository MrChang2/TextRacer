import 'dart:async';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'blitz.dart';
import 'survival.dart';
import 'perfectionist.dart';
//Class: Countdown
//Purpose: Goes to CountdownState
class Countdown extends StatefulWidget {
  int _input = 0;
  Countdown(int n) {
    _input = n;
  }
  @override
  CountdownState createState() => new CountdownState(_input);
}

//Class: CountdownState
//Purpose: Serve as transition between menu and game
class CountdownState extends State<Countdown> {
  int _gameChoice;
  Timer _timer;
  int _time = 3;
  String _tutorial;
  final oneSec = const Duration(seconds: 1);

  CountdownState(int n) {
    _gameChoice = n;
    if (_gameChoice==1) {
      _tutorial = "Text as many of the words as you \ncan within the time limit!";
    }
    else if (_gameChoice==2) {
      _tutorial = "Survive as long as you can! \nSuccessful texts grant you time, \nbut mistakes will cost you!";
    }
    else if (_gameChoice==3) {
      _tutorial = "Text quickly, but also perfectly! \nText as many words as possible, \nbut make a mistake and it all ends!";
    }
  }

  //Method: _enterGameState
  //Purpose: Enters blitz mode
  void _enterBlitzState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Blitz()),
    );
  }

  //Method: _enterSurvivalState
  //Purpose: Enters the survival mode
  void _enterSurvivalState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Survival()),
    );
  }

  //Method: _enterPerfectionistState
  //Purpose: Enters the perfectionist mode
  void _enterPerfectionistState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Perfectionist()),
    );
  }

  //Method: _enterMenuState
  //Purpose: 
  void _enterMenuState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Menu()),
    );
  }

  //Method: _countdown
  //Purpose: Display the initial 3 second countdown before game start
  void _countdown() {    
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_time<1) {
            timer.cancel();
            if (_gameChoice==1) {
              _enterBlitzState();
            }
            else if (_gameChoice==2) {
              _enterSurvivalState();
            }
            else if (_gameChoice==3) {
              _enterPerfectionistState();
            }
          }
          else {
            _time = _time - 1;
          }
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countdown Mode"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("$_time", style: TextStyle(fontSize: 40.0)),
            new FlatButton(
              onPressed: _countdown,
              child: Text('Ready?', style: TextStyle(fontSize: 20.0)),
              color: Colors.yellow,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
            new Text("$_tutorial", style: TextStyle(fontSize: 20.0)),            
          ]  
        )          
      ),  
      floatingActionButton: FloatingActionButton(
        onPressed: _enterMenuState,
        child: Text('Back'),
        backgroundColor: Colors.yellow,        
      ),   
    );
  }
}