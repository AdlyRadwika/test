import 'package:flutter/material.dart';
import 'package:practical_test/screens/route.dart' as route;

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  @override
  void initState() {
    super.initState();
    
    emailC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailC,
              label: 'Email',
              hint: 'Ex: aradwika@gmail.com',
              icon: Icons.person,
            ),
            CustomTextField(
              controller: passwordC,
              label: 'Password',
              icon: Icons.lock,
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: validate,
              child: Text('Login',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  validate() {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();

    if(email.isEmpty || password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Isi email atau password terlebih dahulu!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.pushReplacementNamed(context, route.homeScreen);
    }
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller, this.hint, required this.icon, required this.label,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        icon: Icon(icon),
      ),
    );
  }
}