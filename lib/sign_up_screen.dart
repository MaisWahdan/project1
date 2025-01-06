import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  SignUpScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      List<String> accounts = prefs.getStringList('accounts') ?? [];
      Map<String, String> newAccount = {
        'username': usernameController.text,
        'password': passwordController.text,
      };
      accounts.add(jsonEncode(newAccount));
      await prefs.setStringList('accounts', accounts);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: widget.isDarkMode ? Colors.grey[800] : Colors.blueAccent,
                  child: Icon(
                    Icons.person_add,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode ? Colors.white : Colors.blueGrey[800],
                  ),
                ),
                SizedBox(height: 20),
                buildTextField(
                  controller: usernameController,
                  labelText: 'Username',
                  icon: Icons.person,
                  isDarkMode: widget.isDarkMode,
                ),
                SizedBox(height: 20),
                buildTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isDarkMode: widget.isDarkMode,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                buildTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isDarkMode: widget.isDarkMode,
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.isDarkMode ? Colors.blueGrey : Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  onPressed: signUp,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required bool isDarkMode,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: isDarkMode ? Colors.white : Colors.black54),
      ),
    );
  }
}