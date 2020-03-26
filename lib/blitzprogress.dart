import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'menu.dart';
import 'survivalprogress.dart';
import 'perfectionistprogress.dart';
import 'progressmenu.dart';
class BlitzProgress extends StatefulWidget {
  var bData = List<charts.Series<DataTemplate, int>>();
  var sData = List<charts.Series<DataTemplate, int>>();
  var pData = List<charts.Series<DataTemplate, int>>();
  var highScores = [];

  BlitzProgress(List<charts.Series<DataTemplate, int>> b, List<charts.Series<DataTemplate, int>> s, List<charts.Series<DataTemplate, int>> p, hs) {
    bData = b;
    sData = s;
    pData = p;
    highScores = hs;
  }
  @override
  BlitzProgressState createState() => new BlitzProgressState(bData, sData, pData, highScores);
}

class BlitzProgressState extends State<BlitzProgress> {
  var blitzLineData = List<charts.Series<DataTemplate, int>>();
  var survivalLineData = List<charts.Series<DataTemplate, int>>();
  var perfectionistLineData = List<charts.Series<DataTemplate, int>>();
  var highScores = [];
  var highScore;

  BlitzProgressState(List<charts.Series<DataTemplate, int>> data, List<charts.Series<DataTemplate, int>> otherData, List<charts.Series<DataTemplate, int>> otherData2, hs) {
    blitzLineData = data;
    survivalLineData = otherData;
    perfectionistLineData = otherData2;
    highScores = hs;
    highScore = highScores[0];
  }

  void _enterMenuState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Menu()),
    );
  }

  void _enterSurvivalProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>SurvivalProgress(survivalLineData, blitzLineData, perfectionistLineData, highScores)),
    );
  }

  void _enterPerfectionistProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>PerfectionistProgress(perfectionistLineData, blitzLineData, survivalLineData, highScores)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blitz Mode Progress"),
        backgroundColor: Colors.green,
      ),
      body: Center (
        child: Column(
          children: <Widget>[
            new Text("High Score: $highScore", style: TextStyle(fontSize: 20.0)),
            Expanded (
              child: charts.LineChart(
                blitzLineData,
                defaultRenderer: new charts.LineRendererConfig(
                  includeArea: true,
                  stacked: true,
                ),
                animate: false,
                behaviors: [
                  new charts.ChartTitle(
                    'Trials',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleOutsideJustification: charts.OutsideJustification.middle
                  ),
                  new charts.ChartTitle(
                    'Score',
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification: charts.OutsideJustification.middle
                  ),
                ]
              )
            ),
            new FlatButton(
              onPressed: () {
                _enterSurvivalProgressState();
              },
              child: Text('Survival Progress', style: TextStyle(fontSize: 15.0)),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),
            new FlatButton(
              onPressed: () {
                _enterPerfectionistProgressState();
              },
              child: Text('Perfectionist Progress', style: TextStyle(fontSize: 15.0)),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
            ),  
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _enterMenuState,
        child: Text('Menu'),
        backgroundColor: Colors.green,
      )
    );
  }
}