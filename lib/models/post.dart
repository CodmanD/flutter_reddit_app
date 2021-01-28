import 'package:flutter_reddit_app/models/image_post.dart';

class Post {
  Data data;

  Post({
    this.data,
  });

  String urlPicture() {
    return data.image.img[0].url.url;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String name;
  String subreddit;
  String description;
  String title;
  String author;
  String thumbnail;
  double created;
  String url_overridden_by_dest;
  int num_comments;

  ImagePost image;

  Data(
      {this.author,
      this.thumbnail,
      this.created,
      this.url_overridden_by_dest,
      this.image,
      this.title,
      this.subreddit,
      this.name,
      this.description,
      this.num_comments});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      num_comments: json['num_comments'] == null ? 0 : json['num_comments'],
      description: json['description'] == null ? '' : json['description'],
      name: json['name'] == null ? '' : json['name'],
      subreddit: json['subreddit'] == null ? '' : json['subreddit'],
      title: json['title'] == null ? '' : json['title'],
      author: json['author'] == null ? '' : json['author'],
      thumbnail: json['thumbnail'] == null ? null : json['thumbnail'],
      created: json['created'] == null ? null : json['created'],
      url_overridden_by_dest: json['url_overridden_by_dest'] == null
          ? null
          : json['url_overridden_by_dest'],
      image: json['preview'] == null
          ? null
          : ImagePost.fromJson(json['preview']['images']),
    );
  }
}
