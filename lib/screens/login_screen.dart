import 'package:flutter/material.dart';
import 'package:tracking_flutter/screens/dashboard_admin.dart';
import 'package:tracking_flutter/screens/dashboard_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  String? _errorMessage;

  // Daftar email dan password yang valid
  final Map<String, Map<String, String>> validUsers = {
    'admin@gmail.com': {'password': '1', 'role': 'admin'},
    'tiandhika@gmail.com': {'password': '1', 'role': 'client'},
  };

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (validUsers.containsKey(email)) {
      if (validUsers[email]!['password'] == password) {
        final role = validUsers[email]!['role'];
        setState(() {
          _errorMessage = null;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => role == 'admin' ? DashboardAdmin() : DashboardClient(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Password salah';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Email tidak ditemukan';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              obscureText: _isObscure,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_errorMessage != null)
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}