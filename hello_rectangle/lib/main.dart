import 'package:flutter/material.dart';

class HelloRectangle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
       return Center(
        child: Container(
          color: Colors.greenAccent,
          height: 400.0,
          width: 300.0,
          child: Center(
            child: Text(
              'Samaykoum !',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      );
  }
   
}

void main() {
  runApp(new MaterialApp(
    title: 'Hello',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: new AppBar(
        title: Text('Hello Recrangle'),
      ),
      body: HelloRectangle(),
    ),
  ));
}
