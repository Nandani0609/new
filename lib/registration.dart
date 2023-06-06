import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'main.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
  }

  String? _validateDob(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
  }

  void _register() {
    if (_formKey.currentState!.saveAndValidate()) {
      // Perform registration logic here
      Map<String, dynamic> formData = _formKey.currentState!.value;
      String name = formData['name'];
      String email = formData['email'];
      String dob = formData['dob'];
      String password = formData['password'];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: _validateName,
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'dob',
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                  ),
                  validator: _validateDob,
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
