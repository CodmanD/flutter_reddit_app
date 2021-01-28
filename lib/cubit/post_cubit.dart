import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reddit_app/cubit/post_state.dart';
import 'package:flutter_reddit_app/data/repository.dart';
import 'package:flutter_reddit_app/models/post.dart';

class PostCubit extends Cubit<PostState> {
  PostsRepository postsRepository = PostsRepository();

  PostCubit(this.postsRepository) : super(PostEmptyState());

  Future<void> fetchPost() async {
    try {
      emit(PostLoadingState());

      final List<Post> _loadedPostList = await postsRepository.getAllPosts();
      if(_loadedPostList !=null){
          createWidgets(_loadedPostList);
      }

      emit(PostLoadedState(loadedPost: _loadedPostList));
    } catch (_) {
      emit(PostErrorState());
    }
  }

  List<Widget> createWidgets(List<Post> list) {
    List<Widget> lw=List<Widget>();
    for (Post p in list) {
      lw.add(Column(children: [
        Text(p.data.author),
        SizedBox(
          height: 5,
        ),
        Image(
          image: NetworkImage(p.data.thumbnail),
        )
      ]));
    }
    return lw;
  }

  Future<void> clearPost() async {
    emit(PostEmptyState());
  }
}
