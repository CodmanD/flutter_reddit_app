
import 'dart:convert';

import 'package:flutter_reddit_app/models/post.dart';
import 'package:http/http.dart' as http;

class PostsRepository {
  RedditTop _postProvider = RedditTop();

  Future<List<Post>> getAllPosts() {
    return _postProvider.getPost();
  }
}

class RedditTop {
  Future<List<Post>> getPost() async {
    final response = await http.get('https://www.reddit.com/top.json');

    if (response.statusCode == 200) {
      var ps = json.decode(response.body);
      int i = 0;

      List<dynamic> postJson =
          ps['data']['children'];

      return postJson.map((json) => Post.fromJson(json)).toList();
    } else {}
  }
}
