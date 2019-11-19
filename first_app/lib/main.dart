import 'dart:async';

import 'timer_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
Timer _timer;
int seconds = 0;
int minutes = 0;
bool isRunning = false;
Time time = new Time(5, 0);
int sets = 3;

void startTimer(Time t) {
  seconds = t.getSeconds();
  minutes = t.getMinutes();
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {        
            if (seconds < 1 && minutes < 1) {
              if(sets > 0){
                timer.cancel();
                rseconds = 10;
                restTime.setSeconds(10);
                startTimer2(restTime);
              }else{
                timer.cancel();
              }
            } else {
              if(seconds < 1 && minutes > 0){
                t.setMinutes(--minutes);
                seconds = 59;
                t.setSeconds(59);
              }else{
                t.setSeconds(--seconds);
              }
            }
        })
  );
}

Timer _rtimer;
Time restTime = new Time(4,0);
int rseconds = 0;
int rminutes = 0;
void startTimer2(Time t) {
  rseconds = t.getSeconds();
  rminutes = t.getMinutes();
  const oneSec = const Duration(seconds: 1);
  _rtimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {        
            if (rseconds < 1 && rminutes < 1) {
              if(sets > 0){
                sets--;
                seconds = 15;
                time.setSeconds(15);
                _rtimer.cancel();
                startTimer(time);
              }else{
                timer.cancel();
              }
            } else {
              if(rseconds < 1 && rminutes > 0){
                t.setMinutes(--rminutes);
                rseconds = 59;
                t.setSeconds(59);
              }else{
                t.setSeconds(--rseconds);
              }
            }
        })
  );
}

@override
void dispose() {
  _timer.cancel();
  super.dispose();
}

Widget build(BuildContext context) {
  return new Scaffold(
      appBar: AppBar(title: Text("Timer test")),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              if(! isRunning){
                isRunning = true;
                startTimer(time);
              }
            },
            child: Text("start"),
          ),
          Text("sets : $sets"),
          Text("work : $minutes:$seconds"),
          Text("rest : $rminutes:$rseconds"),
          RaisedButton(
            onPressed: () {
              if(isRunning){
                isRunning = false;
                _timer.cancel();
              }
            },
            child: Text("pause"),
          ),
        ],
      ));
}
}



