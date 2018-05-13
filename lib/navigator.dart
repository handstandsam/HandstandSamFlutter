import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

//void main() => runApp(new NavigatorApp());

// void main() {  runApp(new AnimatedListSample());}

class NavigatorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new FirstScreen(),
    );
  }
}

Future<String> loadAsset() async {
  var futureString = await rootBundle.loadString('assets/handstandsam.json');
  return futureString;
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("First Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new SecondScreen()),
            );
          },
          child: new Text('Go to 2nd Screen!'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            loadAsset().then((str) {
              Map<String, dynamic> jsonObj = JSON.decode(str);
              print(jsonObj.keys);

              Map<String, dynamic> photosMap = jsonObj['photosMap'];
              for (String key in photosMap.keys) {
                dynamic photo = photosMap[key];
                print(photo['url_s']);
              }
            });
            Navigator.pop(context);
          },
          child: new Text('Go back!'),
        ),
      ),
    );
  }
}
