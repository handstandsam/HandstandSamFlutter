import 'package:flutter/material.dart';
import 'package:flutter_app/photos_repo.dart';

class NavigatorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SecondScreen(),
    );
  }
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
        title: new Text("HandstandSam"),
      ),
      body: new Center(child: MyStatefulListWidget()),
    );
  }
}

class MyStatefulListWidget extends StatefulWidget {
  @override
  _MyState2 createState() => new _MyState2();
}

class PhotoListItemWidget extends StatelessWidget {
  Photo photo;
  PhotoListItemWidget(Photo photo) {
    this.photo = photo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [Image.network(photo.url), Text(photo.title)]);
  }
}

class _MyState2 extends State<MyStatefulListWidget> {
  bool _loading = true;

  List<Photo> _photos = <Photo>[
    Photo("hi", "https://flutter.io/images/flutter-mark-square-100.png")
  ];

  @override
  void initState() {
    super.initState();
    PhotosRepo().getPhotos().then((photos) {
      _photos = photos;
      print("Got _photos: " + _photos.length.toString());
      _loading = false;
    });
  }

  List<Widget> createWigetArray() {
    print("createWigetArray");
    List<Widget> widgetList = List();
    for (var i = 0; i < _photos.length; i++) {
      Photo photo = _photos[i];
      if (i < 5) {
        widgetList.add(PhotoListItemWidget(photo));
      } else {
        widgetList.add(new Text('${photo.title}'));
      }
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    print("build loading: $_loading");

    return new ListView(
        children: _loading
            ? []
            : createWigetArray() // when the state of loading changes from true to false, it'll force this widget to reload
        );
  }
}
