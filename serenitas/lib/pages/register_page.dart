import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
import '../widgets/password_fields.dart';
import '../widgets/text_field.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureText = true;
  bool obscureConfirmText = true;

  String? _selectedGender;

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      obscureConfirmText = !obscureConfirmText;
    });
  }

  void _register(BuildContext context) {
    final controller = Provider.of<AccountData>(context, listen: false);

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak sama.')),
      );
      return;
    }

    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon pilih jenis kelamin anda.')),
      );
      return;
    }

    final success = controller.register(
      usernameController.text,
      passwordController.text,
      _selectedGender!,
    );

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registrasi berhasil!')));
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Username sudah ada')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back default
        backgroundColor: const Color.fromARGB(255, 157, 54, 175),
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            MyTextField(
              controller: usernameController,
              hint: 'Masukkan username',
              label: 'Username',
            ),
            const SizedBox(height: 20),
            MyPassWordField(
              controller: passwordController,
              obsecure: obscureText,
              label: 'Password',
              onvisibility: _togglePasswordVisibility,
            ),
            const SizedBox(height: 20),
            MyPassWordField(
              controller: confirmPasswordController,
              obsecure: obscureConfirmText,
              label: 'Confirm Password',
              onvisibility: _toggleConfirmPasswordVisibility,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (value) => setState(() => _selectedGender = value),
              decoration: const InputDecoration(labelText: 'Gender'),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _register(context),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
