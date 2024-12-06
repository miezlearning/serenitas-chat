import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
import '../widgets/text_field.dart';
import '../widgets/password_fields.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _login(BuildContext context) {
    final controller = Provider.of<AccountData>(context, listen: false);
    final success = controller.login(username.text, password.text);
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 157, 54, 175),
        title: const Text('Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: true, // Ensure the back button is displayed
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            MyTextField(
                controller: username,
                hint: 'Masukkan username',
                label: 'Username'),
            const SizedBox(height: 20),
            MyPassWordField(
              controller: password,
              obsecure: obscureText,
              label: 'Password',
              onvisibility: _togglePasswordVisibility,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _login(context),
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Tidak punya akun? Sign up!",
                  style: TextStyle(color: Colors.purple)),
            ),
          ],
        ),
      ),
    );
  }
}
