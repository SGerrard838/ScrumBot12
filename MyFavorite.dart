import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyBloggerData.dart';
import 'package:flutter_application_3/MyDetail.dart';
import 'package:flutter_application_3/MyDetailBlogger.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({Key? key});

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, _) {
        final favoritePosts = favoriteProvider.favoritePosts;
        final favoriteBloggers = favoriteProvider.favoriteBloggers;

        return Scaffold(
          body: _buildFavoriteList(favoritePosts, favoriteBloggers, favoriteProvider),
        );
      },
    );
  }

  Widget _buildFavoriteList(
    List<BlogPost> favoritePosts,
    List<Blogger> favoriteBloggers,
    FavoriteProvider favoriteProvider,
  ) {
    if (favoritePosts.isEmpty && favoriteBloggers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 48.0,
            ),
            SizedBox(height: 16.0),
            Text(
              "Belum ada favorit yang tersimpan",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoritePosts.length + favoriteBloggers.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < favoritePosts.length) {
            final blogPost = favoritePosts[index];

            return Dismissible(
              key: Key(blogPost.title),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                favoriteProvider.removeFromFavoritePost(blogPost);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16.0),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  _navigateToDetailPage(context, blogPost);
                },
                child: Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          imageUrl: blogPost.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        // Image.network(
                        //   blogPost.imageUrl,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blogPost.title,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            final bloggerIndex = index - favoritePosts.length;
            final blogger = favoriteBloggers[bloggerIndex];

            return Dismissible(
              key: Key(blogger.title),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                favoriteProvider.removeFromFavoriteBlogger(blogger);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16.0),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  _navigateToDetailBloggerPage(context, blogger);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.file(
                          blogger.imageFiles[0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            blogger.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    }
  }

  void _navigateToDetailPage(BuildContext context, BlogPost blogPost) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetail(blogPosts: blogPost),
      ),
    );
  }

  void _navigateToDetailBloggerPage(BuildContext context, Blogger blogger) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetailBlogger(blogger),
      ),
    );
  }
}