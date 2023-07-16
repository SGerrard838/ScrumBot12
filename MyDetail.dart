import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyBloggerData.dart';
import 'package:flutter_application_3/MyComment.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MyDetail extends StatefulWidget {
  final BlogPost blogPosts;
  const MyDetail({super.key, required this.blogPosts});

  @override
  State<MyDetail> createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  void _toggleFavorite(FavoriteProvider favoriteProvider) {
    favoriteProvider.toggleFavoritePost(widget.blogPosts);
  }

  void _showFavoriteSnackbar(bool isFavorite) {
    final snackBar = SnackBar(
      content: Text(isFavorite ? 'Berhasil Ditambahkan Ke Favorite' : 'Berhasil Dihapus dari Favorites'),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, _) {
              bool isFavorite = favoriteProvider.favoritePosts.contains(widget.blogPosts);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  _toggleFavorite(favoriteProvider);
                  _showFavoriteSnackbar(!isFavorite);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.blogPosts.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: widget.blogPosts.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // Image.network(
            //   widget.blogPosts.imageUrl,
            //   fit: BoxFit.cover,
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.blogPosts.description,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
              MaterialPageRoute(
                builder: (context) => CommentPage(blogPostTitle: widget.blogPosts.title),
              ),
            );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.comment),
      ),
    );
  }
}