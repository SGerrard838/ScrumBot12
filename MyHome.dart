import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyBlogger.dart';
import 'package:flutter_application_3/MyContact.dart';
import 'package:flutter_application_3/MyDetail.dart';
import 'package:flutter_application_3/MyDetailBlogger.dart';
import 'package:flutter_application_3/MyFavorite.dart';
import 'package:flutter_application_3/MyLogin.dart';
import 'package:flutter_application_3/MyProfile.dart';
import 'package:flutter_application_3/MyGoals.dart';
import 'package:flutter_application_3/MyBloggerData.dart';
import 'package:flutter_application_3/MySetting.dart';
import 'package:flutter_application_3/Provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyHome1(),
    MyFavorite(),
    MyGoals(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getAppBar() {
    if (_selectedIndex == 0) {
      return "Home";
    } else if (_selectedIndex == 1) {
      return "Favorite";
    } else {
      return "Goals";
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProviderRegister>(context);
    var prov1 = Provider.of<MyProviderLogin>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBar()),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[200]),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyProfile()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green[300],
                      child: const Icon(Icons.person, color: Colors.green),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      prov.tfname.text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      prov.tfusername.text,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      prov.tfemail1.text + prov1.tfemail.text,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_square),
              title: const Text("Blogger Saya"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBlogger()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Pengaturan"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MySetting()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text("Kontak dan FAQ"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyContactandFAQ()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Keluar"),
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Keluar"),
                      content: const Text("Apakah anda ingin keluar akun?"),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: const Text("Batal")
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyLogin()));
                          }, 
                          child: const Text("Oke")
                        )
                      ],
                    );
                  }
                );
              },
            )
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_sharp),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
}

class MyHome1 extends StatefulWidget {
  const MyHome1({super.key});

  @override
  State<MyHome1> createState() => _MyHome1State();
}

class _MyHome1State extends State<MyHome1> {
  RefreshController _refreshController = RefreshController();
  Future<void> _refreshData() async {
    // Simulate a delay to show the refresh indicator
    await Future.delayed(const Duration(seconds: 2));

    // Update the data here
    setState(() {
      DataStorage.bloggers;
      DataStorage.blogPosts;
    });
    _refreshController.refreshCompleted();
  }
  void _navigateToDetailPage(BlogPost blogPost) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetail(blogPosts: blogPost),
      ),
    );
  }

  void _navigateToDetailBloggerPage(Blogger blogger) {
    final result = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetailBlogger(blogger),
      ),
    );

    if (result != null) {
      if (result is Blogger) {
        setState(() {
          final index = DataStorage.bloggers.indexOf(blogger);
          DataStorage.bloggers[index] = result as Blogger;
        });
      } else if (result is int) {
        setState(() {
          DataStorage.bloggers.removeAt(result as int);
        });
      }
    }
    // operasi edit
    // if (result != null && result is Blogger) {
    //   setState(() {
    //     final index = DataStorage.bloggers.indexOf(blogger);
    //     DataStorage.bloggers[index] = result as Blogger;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: DataStorage.bloggers.length + DataStorage.blogPosts.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < DataStorage.bloggers.length) {
              final blogger = DataStorage.bloggers[index];
              return GestureDetector(
                onTap: () {
                  _navigateToDetailBloggerPage(blogger);
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
              );
            } else {
              final blogPostIndex = index - DataStorage.bloggers.length;
              final blogPost = DataStorage.blogPosts[blogPostIndex];
              return GestureDetector(
                onTap: () {
                  _navigateToDetailPage(blogPost);
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
              );
            }
          },
        ),
      ),
    );
  }
}