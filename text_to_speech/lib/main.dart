import 'package:flutter/material.dart';
import 'package:tts/tts.dart';

void main() => runApp(MyTts());

class MyTts extends StatefulWidget {
  @override
  _MyTtsState createState() => _MyTtsState();
}

class _MyTtsState extends State<MyTts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "text to speech",
      home: Scaffold(
      body: new Center(
        child: new RaisedButton(
          onPressed: speak,
          child: new Text('Say Hello'),
        ),
      ),
    ),
    );
  }

  speak() async {
    var languages = Tts.getAvailableLanguages();
    await Tts.setLanguage("de-DE");
    Tts.speak('ich bin 10 jahre alt, die frau');
  }
}
