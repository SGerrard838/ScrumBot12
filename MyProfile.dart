import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String username = "SGerrard";
  String name = "Steven Gerrard";
  String email = "stevgerrard@hotmail.com";
  String dob = "15/06/2003";
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: name,
                      username: username,
                      email: email,
                      dob: dob,
                      image: image,
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    if (value != null) {
                      name = value["name"];
                      username = value["username"];
                      email = value["email"];
                      dob = value["dob"];
                      image = value["image"];
                    }
                  });
                });
              },
              icon: Icon(Icons.edit)
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(20.0),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            name: name,
                            username: username,
                            email: email,
                            dob: dob,
                            image: image,
                          ),
                        ),
                      ).then((value) {
                        setState(() {
                          if (value != null) {
                            name = value["name"];
                            username = value["username"];
                            email = value["email"];
                            dob = value["dob"];
                            image = value["image"];
                          }
                        });
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: image != null
                          ? FileImage(image!)
                          : null,
                      child: image == null
                          ? Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("$name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  SizedBox(height: 10),
                  Text("$username", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("$email", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text("$dob",style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String name;
  final String username;
  final String email;
  final String dob;
  final File? image;

  EditProfilePage({
    required this.name,
    required this.email,
    required this.dob,
    required this.image, 
    required this.username,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late File? _image;
  String _name = "";
  String _username = "";
  String _email = "";
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    _name = widget.name;
    _username = widget.username;
    _email = widget.email;
    _dobController = TextEditingController(text: widget.dob);
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profil berhasil diubah.'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<File?> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('Tidak ada foto yang dipilih.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [
          TextButton(
            onPressed: (){
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.pop(
                  context,
                    {
                      "name": _name,
                      "email": _email,
                      "username": _username,
                      "dob": _dobController.text,
                      "image": _image,
                  },
                );
                showSuccessSnackbar(context);
              }
            },
            child: Text("Simpan", style: TextStyle(color: Colors.white))
          )
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Tooltip(
                    message: 'Ubah Foto Profil',
                    child: GestureDetector(
                    onTap: () {
                      getImage().then((value) {
                        setState(() {
                          _image = value;
                        });
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : null,
                      child: _image == null
                          ? Icon(Icons.person, size: 50)
                          : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan nama';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _username,
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'masukkan email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: "Tanggal lahir",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan Tanggal Lahir';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        String formattedDate =
                            "${date.day}/${date.month}/${date.year}";
                        setState(() {
                          _dobController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
      ),
    );
  }
}