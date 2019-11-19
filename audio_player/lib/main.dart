import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  AudioCache player = new AudioCache();

  @override
  Widget build(BuildContext context) {
    player.loadAll(['sounds/beep-01.wav', 'sounds/beep-07.wav']);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              onPressed: (){
                print('1 was pressed');
                player.play('sounds/beep-01.wav');
              },
                child: new Icon(Icons.looks_one),
            ),
            FloatingActionButton(
              onPressed: (){
                print('2 was pressed');
                player.play('sounds/beep-07.wav');
              },
              child: new Icon(Icons.looks_two),
            ),
          ],
        ),
      ),
    );
  }
}
