import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_3/MyBloggerData.dart';

class MyEditBlogger extends StatefulWidget {
  final Blogger blogger;

  MyEditBlogger({required this.blogger});

  @override
  _MyEditBloggerState createState() => _MyEditBloggerState();
}

class _MyEditBloggerState extends State<MyEditBlogger> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.blogger.title;
    _descriptionController.text = widget.blogger.description;
    _imageFiles = List.from(widget.blogger.imageFiles);
  }

  Future<void> _uploadImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _imageFiles.addAll(result.files.map((file) => File(file.path!)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  void _editBlogger() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;

      if (_imageFiles.isNotEmpty &&
          title.isNotEmpty &&
          description.isNotEmpty) {
        final editedBlogger = Blogger(_imageFiles, title, description);
        Navigator.pop(context, editedBlogger);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tolong upload gambar minimal 1 foto'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Blogger'),
        actions: [
          TextButton(
            onPressed: _editBlogger,
            child: Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan judul';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Deskripsi',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Deskripsi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildUploadedImages(),
              SizedBox(height: 16),
              TextButton(
                onPressed: _uploadImages,
                child: Text('Unggah Gambar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadedImages() {
    if (_imageFiles.isEmpty) {
      return Text('Tidak ada gambar');
    }

    return Column(
      children: List.generate(_imageFiles.length, (index) {
        final file = _imageFiles[index];
        return ListTile(
          leading: Image.file(file),
          title: Text(file.path),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _removeImage(index);
            },
          ),
        );
      }),
    );
  }
}
