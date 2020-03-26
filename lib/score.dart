import 'package:flutter/material.dart';
import 'menu.dart';
import 'progressmenu.dart';

//Class: Score
//Purpose: goes to ScoreState
class Score extends StatefulWidget {
  int _score;
  int _highScore;
  int _choice;
  Score(int s, int hs, int c) {
    _score = s;
    _highScore = hs;
    _choice = c;
  }
  @override
  ScoreState createState() => new ScoreState(_score, _highScore, _choice);
}

//Class: ScoreState
//Purpose: Display score from attempt, notifies user of high scores
class ScoreState extends State<Score> {
  int _score;
  int _highScore;
  
  ScoreState(int s, int hs, int c) {
    _score = s;
    _highScore = hs;
  }  

  void _enterMenuState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Menu()),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Scores"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[        
            new Text("Your Score: $_score", style: TextStyle(fontSize: 40.0)),
            new Text("High Score: $_highScore", style: TextStyle(fontSize: 30.0)),
            new FlatButton(
              onPressed: _enterProgressState,
              child: Text("View Progress", style: TextStyle(fontSize: 20.0)),
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _enterMenuState,
        child: Text('Back'),        
      ),
    );
  }
}