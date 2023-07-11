import 'package:flutter/material.dart';
import 'package:flutter_application_3/MyNewPass.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  final TextEditingController _textField3Controller = TextEditingController();
  final TextEditingController _textField4Controller = TextEditingController();
  bool _isButtonEnabled = false;

  void _checkTextFields() {
    setState(() {
      _isButtonEnabled = _textField1Controller.text.isNotEmpty &&
          _textField2Controller.text.isNotEmpty &&
          _textField3Controller.text.isNotEmpty &&
          _textField4Controller.text.isNotEmpty;
    });
  }

  void _submitForm() {
    if (_isButtonEnabled) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyNewPass()));
    }
  }

  @override
  void initState() {
    super.initState();
    _textField1Controller.addListener(_checkTextFields);
    _textField2Controller.addListener(_checkTextFields);
    _textField3Controller.addListener(_checkTextFields);
    _textField4Controller.addListener(_checkTextFields);
  }

  @override
  void dispose() {
    _textField1Controller.dispose();
    _textField2Controller.dispose();
    _textField3Controller.dispose();
    _textField4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: 310,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Verifikasi OTP", style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w500)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTextField(_textField1Controller),
                  _buildTextField(_textField2Controller),
                  _buildTextField(_textField3Controller),
                  _buildTextField(_textField4Controller),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: _isButtonEnabled ? _submitForm : null,
                  child: const Text("Done")
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField(TextEditingController controller) {
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
            _checkTextFields();
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            filled: true,
            fillColor: Colors.green.shade100,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

