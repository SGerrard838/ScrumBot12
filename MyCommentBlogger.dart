import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCommentBlogger extends StatefulWidget {
  final String blogPostTitle;
  const MyCommentBlogger({Key? key, required this.blogPostTitle}) : super(key: key);

  @override
  _MyCommentBloggerState createState() => _MyCommentBloggerState();
}

class _MyCommentBloggerState extends State<MyCommentBlogger> {
  List<String> comments = [];

  TextEditingController _commentController = TextEditingController();
  int _selectedCommentIndex = -1;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment(String comment) {
    setState(() {
      comments.add(comment);
      _commentController.clear();
    });
  }

  void _editComment(int index, String newComment) {
    setState(() {
      comments[index] = newComment;
      _selectedCommentIndex = -1;
    });

    Fluttertoast.showToast(
      msg: 'Komentar berhasil diedit',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
    );
  }

  void _deleteComment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus komentar ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                setState(() {
                  comments.removeAt(index);
                  _selectedCommentIndex = -1;
                });
                Fluttertoast.showToast(
                  msg: 'Komentar berhasil dihapus',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey[600],
                  textColor: Colors.white,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Komentar "${widget.blogPostTitle}"',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (comments.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.person),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(comment),
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: _buildDropdownMenu(index, comment),
                  );
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Text('Belum ada komentar.'),
              ),
            ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: null,
                    controller: _commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan Komentar....',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final comment = _commentController.text.trim();
                    if (comment.isNotEmpty) {
                      _addComment(comment);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownMenu(int index, String comment) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: 'Hapus',
            child: Text('Hapus'),
          ),
        ];
      },
      onSelected: (String value) {
        if (value == 'Edit') {
          _showEditDialog(index, comment);
        } else if (value == 'Hapus') {
          _deleteComment(index);
        }
      },
      child: Tooltip(
        message: 'Menu',
        child: Icon(Icons.more_vert),
      ),
    );
  }

  void _showEditDialog(int index, String comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedComment = comment;

        return AlertDialog(
          title: Text('Edit Komentar'),
          content: TextField(
            controller: TextEditingController(text: comment),
            onChanged: (value) {
              updatedComment = value;
            },
          ),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                _editComment(index, updatedComment);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}