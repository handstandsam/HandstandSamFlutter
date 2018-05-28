import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class Photo {
  String title;
  String url;

  Photo(String title, String url) {
    this.title = title;
    this.url = url;
  }
}

Future<String> loadLocalPhotosDb() async {
  var futureString = await rootBundle.loadString('assets/handstandsam.json');
  return futureString;
}

class PhotosRepo {
  List<Photo> photos = new List();

  Future<List<Photo>> getPhotos() async {
    photos.clear();
    await loadLocalPhotosDb().then((str) {
      Map<String, dynamic> jsonObj = json.decode(str);
      Map<String, dynamic> photosMap = jsonObj['photosMap'];
      for (String key in photosMap.keys) {
        dynamic photo = photosMap[key];
        String title = photo['title'];
        String url = photo['url_m'];
        Photo p = new Photo(title, url);
        photos.add(p);
      }

      print("Total Num Photos ${photos.length}");
    });

    return photos;
  }
}
