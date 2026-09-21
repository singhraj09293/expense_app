import 'package:expense_app/screen/register.dart';
import 'package:expense_app/service/api_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(Icons.wallet, size: 50, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Expense",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Track your spending effortlessly",
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade300),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email/Username",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: 'example123@gmail.com / user123',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Email required!";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Password required!";
                      return null;
                    },
                  ),
                  SizedBox(height: 60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: Size(double.infinity, 55),
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        try {
                          await ApiService().login(
                            email.text.trim(),
                            password.text.trim(),
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User not found $e")),
                          );
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, color: Colors.black),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Register()),
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
