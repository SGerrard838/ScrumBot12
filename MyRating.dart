import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRating extends StatefulWidget {
  const MyRating({super.key});

  @override
  State<MyRating> createState() => _MyRatingState();
}

class _MyRatingState extends State<MyRating> {
  double _rating = 0.0;
  final TextEditingController _commentController = TextEditingController();
  bool _isButtonEnabled = false;

  void _updateButtonEnabledStatus() {
    setState(() {
      _isButtonEnabled = _rating > 0 && _commentController.text.isNotEmpty;
    });
  }

  void _submitRating() {
    if (_rating == 0.0 || _commentController.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Rating dan komentar harus diisi!'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else if (_commentController.text.isEmpty){
      const snackBar = SnackBar(
        content: Text('Rating berhasil dikirim!'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text('Rating berhasil dikirim!'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    _commentController.addListener(_updateButtonEnabledStatus);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rating"),
        actions: [
          IconButton(
            onPressed: _submitRating, 
            icon: const Icon(Icons.send)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                  _updateButtonEnabledStatus();
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              maxLines: null,
              controller: _commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Komentar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}