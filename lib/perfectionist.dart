import 'dart:async';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menu.dart';
import 'score.dart';

class Perfectionist extends StatefulWidget {
  @override
  PerfectionistState createState() => new PerfectionistState();
}

class PerfectionistState extends State<Perfectionist> {
  //Timer variables 
  Timer _timer;
  int _time = 5;
  String _gameOver = "";
  final oneSec = const Duration(seconds: 1);
  bool started = false;
  //Keyboard variables
  String _word = "";
  String _tryAgain = " ";
  int _wordCount = 0;
  int _highScore;
  TextEditingController _controller = TextEditingController();
  var random = new Random();
  var responses = ["Oops!", "Try again!", "Incorrect!", "A little off!"];

  void _perfectionistTimer() {    
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_time<1) {
            timer.cancel();
            _gameOver = "Time's up!"; 
            _updateScores(_wordCount, 'perfectionistScore', 'perfectionistList');
          }
          else {
            _time = _time - 1;
          }
        }
      )
    );
  }

  void _updateScores(int score, String k, String l) async{
    final prefs = await SharedPreferences.getInstance();
    final hs = prefs.getInt(k) ?? 0;
    List<String> scores = prefs.getStringList(l) ?? List<String>();
    if (score>=hs.toInt()) {
      prefs.setInt(k,score);
    }
    scores.add(score.toString());
    prefs.setStringList(l, scores);
    _highScore = prefs.getInt(k).toInt();
    print(prefs.getStringList(l));
    _enterScoreState();
  }

  bool _checkInput(String input) {
    if (input==_word) {     
      return true;
    }
    else {
      return false;
    }
  }

  void _enterMenuState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Menu()),
    );
  }

  void _enterScoreState() {
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>Score(_wordCount, _highScore, 1)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //start timer
    if (!started) {
      started = true;
      _word = generateWordPairs().take(1).toString();
      _word = _word.substring(1,_word.length-1);
      _perfectionistTimer();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfectionist Mode'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("$_gameOver", style: TextStyle(fontSize: 50.0)),
            new Text("$_time", style: TextStyle(fontSize: 40.0)),
            Text("$_word", style: TextStyle(fontSize: 30.0)),
            new TextField (
              controller: _controller,
              onSubmitted: (String value) async {
                if (_checkInput(value)) {
                  _wordCount++;
                  _time = 5;
                  _word = generateWordPairs().take(1).toString();
                  _word = _word.substring(1,_word.length-1);
                  _controller.clear();
                }
                else {
                  _tryAgain = responses[random.nextInt(responses.length-1)];
                  _timer.cancel();
                  _gameOver = "Game Over!";
                  _updateScores(_wordCount, 'perfectionistScore', 'perfectionistList');
                }
                //_controller.clear();
              },
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Text Fast!'
              )
            ),
            new Text("$_tryAgain", style: TextStyle(fontSize: 30.0, color: Colors.red)),
            new Text("Score: $_wordCount", style: TextStyle(fontSize: 30.0)),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _enterMenuState,
        child: Text('Back'),
        backgroundColor: Colors.indigo,        
      ),
    );
  }
}