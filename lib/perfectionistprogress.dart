import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'menu.dart';
import 'survivalprogress.dart';
import 'blitzprogress.dart';
import 'progressmenu.dart';

class PerfectionistProgress extends StatefulWidget {
  var pData = List<charts.Series<DataTemplate, int>>();
  var bData = List<charts.Series<DataTemplate, int>>();
  var sData = List<charts.Series<DataTemplate, int>>();
  var highScores = [];

  PerfectionistProgress(List<charts.Series<DataTemplate, int>> p, List<charts.Series<DataTemplate, int>> b, List<charts.Series<DataTemplate, int>> s, hs) {
    pData = p;
    bData = b;
    sData = s;
    highScores = hs;
  }
  @override
  PerfectionistProgressState createState() => new PerfectionistProgressState(pData, bData, sData, highScores);
}

class PerfectionistProgressState extends State<PerfectionistProgress> {
  var perfectionistLineData = List<charts.Series<DataTemplate, int>>();
  var blitzLineData = List<charts.Series<DataTemplate, int>>();
  var survivalLineData = List<charts.Series<DataTemplate, int>>();
  var highScores;
  var highScore;

  PerfectionistProgressState(List<charts.Series<DataTemplate, int>> data, List<charts.Series<DataTemplate, int>> otherData, List<charts.Series<DataTemplate, int>> otherData2, hs) {
    perfectionistLineData = data;
    blitzLineData = otherData;
    survivalLineData = otherData2;
    highScores = hs;
    highScore = highScores[2];
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

  void _enterSurvivalProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>SurvivalProgress(survivalLineData, blitzLineData, perfectionistLineData, highScores)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfectionist Mode Progress"),
        backgroundColor: Colors.green,
      ),
      body: Center (
        child: Column(
          children: <Widget>[
            new Text("High Score: $highScore", style: TextStyle(fontSize: 20.0)),
            Expanded (              
              child: charts.LineChart(
                perfectionistLineData,
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
                _enterSurvivalProgressState();
              },
              child: Text('Survival Progress', style: TextStyle(fontSize: 15.0)),
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