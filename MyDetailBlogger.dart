import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyBloggerData.dart';
import 'package:flutter_application_3/MyCommentBlogger.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';

class MyDetailBlogger extends StatefulWidget {
  final Blogger blogger;

  MyDetailBlogger(this.blogger);

  @override
  _MyDetailBloggerState createState() => _MyDetailBloggerState();
}

class _MyDetailBloggerState extends State<MyDetailBlogger> {
  int _currentImageIndex = 0;
  PageController _pageController = PageController();

  void _toggleFavorite(FavoriteProvider favoriteProvider) {
    favoriteProvider.toggleFavoriteBlogger(widget.blogger);
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
        title: Text('Blogger Detail'),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, _) {
              bool isFavorite = favoriteProvider.favoriteBloggers.contains(widget.blogger);
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
            Text(
              widget.blogger.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  if (_currentImageIndex > 0) {
                    setState(() {
                      _currentImageIndex--;
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  }
                } else if (details.primaryVelocity! < 0) {
                  if (_currentImageIndex < widget.blogger.imageFiles.length - 1) {
                    setState(() {
                      _currentImageIndex++;
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  }
                }
              },
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.blogger.imageFiles.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: Image.file(
                          widget.blogger.imageFiles[index],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.blogger.imageFiles.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentImageIndex = index;
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: _currentImageIndex == index
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.blogger.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCommentBlogger(blogPostTitle: widget.blogger.title),
      ),
    );
        },
        child: Icon(Icons.comment),
      ),
    );
  }
}