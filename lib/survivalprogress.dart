import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'menu.dart';
import 'blitzprogress.dart';
import 'perfectionistprogress.dart';
import 'progressmenu.dart';
class SurvivalProgress extends StatefulWidget {
  var sData = List<charts.Series<DataTemplate, int>>();
  var bData = List<charts.Series<DataTemplate, int>>();
  var pData = List<charts.Series<DataTemplate, int>>();
  var highScores = [];

  SurvivalProgress(List<charts.Series<DataTemplate, int>> s, List<charts.Series<DataTemplate, int>> b, List<charts.Series<DataTemplate, int>> p, hs) {
    sData = s;
    bData = b;
    pData = p;
    highScores = hs;
  }
  @override
  SurvivalProgressState createState() => new SurvivalProgressState(sData, bData, pData, highScores);
}

class SurvivalProgressState extends State<SurvivalProgress> {
  var survivalLineData = List<charts.Series<DataTemplate, int>>();
  var blitzLineData = List<charts.Series<DataTemplate, int>>();
  var perfectionistLineData = List<charts.Series<DataTemplate, int>>();
  var highScores = [];
  var highScore;

  SurvivalProgressState(List<charts.Series<DataTemplate, int>> data, List<charts.Series<DataTemplate, int>> otherData, List<charts.Series<DataTemplate, int>> otherData2, hs) {
    survivalLineData = data;
    blitzLineData = otherData;
    perfectionistLineData = otherData2;
    highScores = hs;
    highScore = highScores[1];
  }

  void _enterMenuState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>Menu()),
    );
  }

  void _enterBlitzProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>BlitzProgress(blitzLineData, survivalLineData, perfectionistLineData, highScores)),
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
        title: Text("Survival Mode Progress"),
        backgroundColor: Colors.green,
      ),
      body: Center (
        child: Column(
          children: <Widget>[
            new Text("High Score: $highScore", style: TextStyle(fontSize: 20.0)),
            Expanded (
              child: charts.LineChart(
                survivalLineData,
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
                _enterBlitzProgressState();
              },
              child: Text('Blitz Progress', style: TextStyle(fontSize: 15.0)),
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