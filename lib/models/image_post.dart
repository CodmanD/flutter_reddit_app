class ImagePost {
  List<ImageSource> img;

  ImagePost({this.img});

  factory ImagePost.fromJson(List<dynamic> json) {
    List<ImageSource> img = json.map((i) => ImageSource.fromJson(i)).toList();
    return ImagePost(img: img);
  }
}

class ImageSource {
  UrlPost url;

  ImageSource({this.url});

  factory ImageSource.fromJson(Map<String, dynamic> json) {
    return ImageSource(url: UrlPost.fromJson(json['source']));
  }
}

class UrlPost {
  String url;

  UrlPost({this.url});

  factory UrlPost.fromJson(Map<String, dynamic> json) {
    return UrlPost(url: json['url'] == null ? null : json['url']);
  }
}
