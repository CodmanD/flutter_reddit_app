import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reddit_app/cubit/post_cubit.dart';
import 'package:flutter_reddit_app/cubit/post_state.dart';
import 'package:flutter_reddit_app/data/repository.dart';
import 'package:flutter_reddit_app/pages/posts_view.dart';
import 'package:toast/toast.dart';

class PostPage extends StatelessWidget {
  final PostsRepository postsRepository = PostsRepository();

  @override
  Widget build(BuildContext context) {
    //final PostCubit _postCubit = context.bloc<PostCubit>();
    final PostCubit _postCubit = BlocProvider.of<PostCubit>(context);
    _postCubit.fetchPost();

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        if (state is PostEmptyState) {
          return Center(
            child: Text('No DATA recieved.Press Button Load'),
          );
        }

        if (state is PostLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostLoadedState) {
          return Container(
              child: ListView.builder(
            itemCount: state.loadedPost.length,
            itemBuilder: (context, index) => Container(
                color: index % 2 == 0 ? Colors.green[350] : Colors.blue[50],
                child: ListTile(
                  onTap: () => state.loadedPost[index].data.image != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostView(
                                    url: state.loadedPost[index].data.image
                                        .img[0].url.url,
                                  )),
                        )
                      : Toast.show('No Image', context, duration: 2),
                  // onTap: () => _showImage(context,
                  //     state.loadedPost[index].data.image.img[0].url.url),
                  title: Column(
                    children: [
                      // Text(state.loadedPost[index].data.author),
                      Text(state.loadedPost[index].data.author),
                      SizedBox(
                        height: 3,
                      ),
                      Text(state.loadedPost[index].data.title),
                      SizedBox(
                        height: 3,
                      ),

                      Text(state.loadedPost[index].data.description),
                      SizedBox(
                        height: 3,
                      ),
                      Image(
                        image: NetworkImage(
                            state.loadedPost[index].data.thumbnail),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(timeAgo(state.loadedPost[index].data.created)),
                          Text(
                            state.loadedPost[index].data.num_comments
                                    .toString() +
                                " comments",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ));
        }
      },
    );
  }

  String timeAgo(double created) {
    var x = DateTime.now().millisecondsSinceEpoch - created.toInt() * 1000;

    DateTime.fromMillisecondsSinceEpoch(created.toInt() * 1000);

    return DateTime.fromMillisecondsSinceEpoch(x).hour.toString() +
        " hours ago";
  }
}
