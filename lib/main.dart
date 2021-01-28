import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reddit_app/pages/post_page.dart';
import 'cubit/post_cubit.dart';
import 'data/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PostsRepository postsRepository = PostsRepository();

  @override
  Widget build(BuildContext context) {
    postsRepository.getAllPosts();

    return BlocProvider<PostCubit>(
      create: (context) => PostCubit(postsRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Reddit Top"),
              centerTitle: true,
            ),
            body: PostPage()),
      ),
    );
  }
}
