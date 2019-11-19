import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainerApp();
  }
}

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8.0);
  
  @override
  Widget build(BuildContext context) {
   
    return new MaterialApp(
      title: 'Flutter animation',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter animation'),
        ),
        body: Center(
                  child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            // Define how long the animation. 
            duration: Duration(seconds: 2),
            // Provide an optional curve to make the animation feel smoother. 
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
      child: Icon(Icons.play_arrow),
      // When the user taps the button
      onPressed: () {
        // Use setState to rebuild the widget with new values.
        setState(() {
          // Create a random number generator.
          final random = Random();

          // Generate a random width and height.
          _width = random.nextInt(300).toDouble();
          _height = random.nextInt(300).toDouble();

          // Generate a random color.
          _color = Color.fromRGBO(
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
            1.0,
          );

          // Generate a random border radius.
          _borderRadius =
              BorderRadius.circular(random.nextInt(100).toDouble());
        });
      },
    ),        
        
      ),
    );
  }
}

