import 'dart:async';

class Time{
  int seconds;
  int minutes;
  Time(int s, int m){
    this.seconds = s;
    this.minutes = m;
  }
  void setSeconds(int s){
    this.seconds = s;
  }
  void setMinutes(int m){
    this.minutes = m;
  }
  int getSeconds(){
    return this.seconds;
  }
  int getMinutes(){
    return this.minutes;
  }
}

class TimerHelper{
  Time _workInterval;
  Time _restInterval;
  int _sets;

  TimerHelper(Time work, Time rest, int sets){
    this._workInterval =work;
    this._restInterval = rest;
    this._sets = sets;
  }

  void setSets(int s){
    this._sets = s;
  }
  void setWorkInterval(Time t){
    this._workInterval = t;
  }
  void setRestInterval(Time t){
    this._restInterval  = t;
  }

  Time getWorkInterval(){return this._workInterval;}
  Time getRestInterval(){ return this._restInterval;}
  int getSets(){return this._sets;}
}

class MyTimer{
  Timer _timer;
  int seconds;
  int minutes;
  bool isRunning;
  Time time;
}