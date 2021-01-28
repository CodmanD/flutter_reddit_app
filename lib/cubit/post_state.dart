import 'package:flutter/foundation.dart';

abstract class PostState {
  get loadedPost => null;
}

class PostEmptyState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  List<dynamic> loadedPost;

  PostLoadedState({@required this.loadedPost}) : assert(loadedPost != null);
}

class PostErrorState extends PostState {}
