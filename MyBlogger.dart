import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyAddBlogger.dart';
import 'package:flutter_application_3/MyBloggerData.dart';
import 'package:flutter_application_3/MyDetailBlogger.dart';
import 'package:flutter_application_3/MyEditBlogger.dart';

class MyBlogger extends StatefulWidget {
  const MyBlogger({super.key});

  @override
  State<MyBlogger> createState() => _MyBloggerState();
}

class _MyBloggerState extends State<MyBlogger> {
  bool isContextualMode = false;
  List<int> selectedBloggerIndexes = [];

  void _editBlogger(Blogger blogger) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEditBlogger(blogger: blogger)),
    );

    if (result != null && result is Blogger) {
      setState(() {
        final index = DataStorage.bloggers.indexOf(blogger);
        DataStorage.bloggers[index] = result;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Blogger berhasil diubah!'),
          ),
        );
      });
    }
  }

  void _deleteBlogger(Blogger blogger) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus blogger ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  DataStorage.bloggers.remove(blogger);
                  selectedBloggerIndexes.remove(DataStorage.bloggers.indexOf(blogger));
                  isContextualMode = selectedBloggerIndexes.isNotEmpty;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Blogger berhasil dihapus!'),
                  ),
                );
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isContextualMode) {
          setState(() {
            isContextualMode = false;
            selectedBloggerIndexes.clear();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: isContextualMode
            ? AppBar(
                title: Text('${selectedBloggerIndexes.length} dipilih'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      final selectedBloggers = selectedBloggerIndexes
                          .map((index) => DataStorage.bloggers[index])
                          .toList();
                      _editBlogger(selectedBloggers.first);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      if (selectedBloggerIndexes.isNotEmpty) {
                        final selectedBloggers = selectedBloggerIndexes
                            .map((index) => DataStorage.bloggers[index])
                            .toList();
                        _deleteBlogger(selectedBloggers.first);
                      }
                      // setState(() {
                      //   selectedBloggerIndexes.sort((a, b) => b.compareTo(a));
                      //   selectedBloggerIndexes.forEach((index) {
                      //     DataStorage.bloggers.removeAt(index);
                      //   });
                      //   selectedBloggerIndexes.clear();
                      //   isContextualMode = false;
                      // });
                    },
                  ),
                ],
              )
            : AppBar(
                title: Text('Blogger Saya'),
              ),
        body: ListView.builder(
          itemCount: DataStorage.bloggers.length,
          itemBuilder: (context, index) {
            final blogger = DataStorage.bloggers[index];
            final isSelected = selectedBloggerIndexes.contains(index);
            return GestureDetector(
              onTap: () {
                if (isContextualMode) {
                  setState(() {
                    if (isSelected) {
                      selectedBloggerIndexes.remove(index);
                    } else {
                      selectedBloggerIndexes.add(index);
                    }
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDetailBlogger(blogger),
                    ),
                  );
                }
              },
              onLongPress: () {
                setState(() {
                  isContextualMode = true;
                  selectedBloggerIndexes = [index];
                });
              },
              child: Card(
                color: isSelected ? Colors.grey[300] : null,
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAddBlogger()),
            );

            if (result != null && result is Blogger) {
              setState(() {
                DataStorage.bloggers.add(result);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Blogger berhasil ditambahkan!'),
                  ),
                );
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
