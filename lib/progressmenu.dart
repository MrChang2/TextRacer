import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'menu.dart';
import 'blitzprogress.dart';
import 'survivalprogress.dart';
import 'perfectionistprogress.dart';
//Class: Progress
//Purpose: goes to ProgressMenuState
class Progress extends StatefulWidget {
  @override
  ProgressMenuState createState() => new ProgressMenuState();
}

//Class: ProgressState
//Purpose: Display user progress
class ProgressMenuState extends State<Progress> {
  var blitzLineData = List<charts.Series<DataTemplate, int>>();
  var  survivalLineData = List<charts.Series<DataTemplate, int>>();
  var perfectionistLineData = List<charts.Series<DataTemplate, int>>();
  List<String> blitzData;
  var blitzLine = new List<DataTemplate>();
  List<String> survivalData;
  var survivalLine = new List<DataTemplate>();
  List<String> perfectionistData;
  var perfectionistLine = new List<DataTemplate>();

  var highScores = [0,0,0];
  
  void _gatherData() async{
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('blitzList')!=null) {
      blitzData = prefs.getStringList('blitzList');    
      for (int x=0;x<blitzData.length;x++) {
        blitzLine.add(new DataTemplate(x, int.parse(blitzData[x])));
      }
      blitzLineData.add(
        charts.Series(
          colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault,
          id: 'Blitz Progress',
          data: blitzLine,
          domainFn: (DataTemplate dt, _) => dt._trialNum,
          measureFn: (DataTemplate dt, _) => dt._scoreNum
        )
      );
      highScores[0] = prefs.getInt('blitzScore');
    }

    if (prefs.getStringList('survivalList')!=null) {
      survivalData = prefs.getStringList('survivalList');
      for (int x=0;x<survivalData.length;x++) {
        survivalLine.add(new DataTemplate(x, int.parse(survivalData[x])));
      }
      survivalLineData.add(
        charts.Series(
          colorFn: (_,__) => charts.MaterialPalette.blue.shadeDefault,
          id: 'Survival Progress',
          data: survivalLine,
          domainFn: (DataTemplate dt, _) => dt._trialNum,
          measureFn: (DataTemplate dt, _) => dt._scoreNum
        )
      );
      highScores[1] = prefs.getInt('survivalScore');
    }

    if (prefs.getStringList('perfectionList')!=null) {
      perfectionistData = prefs.getStringList('perfectionistList');
      for (int x=0;x<perfectionistData.length;x++) {
        perfectionistLine.add(new DataTemplate(x, int.parse(perfectionistData[x])));
      }
      perfectionistLineData.add(
        charts.Series(
          colorFn: (_,__) => charts.MaterialPalette.indigo.shadeDefault,
          id: 'Survival Progress',
          data: perfectionistLine,
          domainFn: (DataTemplate dt, _) => dt._trialNum,
          measureFn: (DataTemplate dt, _) => dt._scoreNum
        )
      );
      highScores[2] = prefs.getInt('perfectionistScore');
    }
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

  void _enterPerfectionistProgressState() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context)=>PerfectionistProgress(perfectionistLineData, blitzLineData, survivalLineData, highScores)),
     );
  }

  @override
  void initState() {
    _gatherData();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Progress Menu"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              new FlatButton(
                onPressed: _enterBlitzProgressState,
                child: Text("Blitz Progress", style: TextStyle(fontSize: 20.0)),
                color: Colors.red,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
              ),
              new FlatButton(
                onPressed: _enterSurvivalProgressState,
                child: Text("Survival Progress", style: TextStyle(fontSize: 20.0)),
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
              ),
              new FlatButton(
                onPressed: _enterPerfectionistProgressState,
                child: Text("Perfectionist Progress", style: TextStyle(fontSize: 20.0)),
                color: Colors.indigo,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
              ),
            ],
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

class DataTemplate {
  int _trialNum;
  int _scoreNum;

  DataTemplate(this._trialNum, this._scoreNum);
}