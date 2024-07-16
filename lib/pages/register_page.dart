import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/login_page.dart';
import 'package:news_app/services/auth/auth_services.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    void register() async {
      final _authService = AuthServices();

      if (passwordController.text == confirmPasswordController.text) {
        try {
          await _authService.signUpWithEmailPassword(
            emailController.text,
            passwordController.text,
          );
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
              ),
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text(
              "Passwords doesn't match!",
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top + 50,
              ),
              const SizedBox(height: 50),
              customTextField(
                  hintText: 'Email', controller: emailController, obstxt: false),
              const SizedBox(height: 25),
              customTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  obstxt: true),
              const SizedBox(height: 25),
              customTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  obstxt: true),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: register,
                  child: Text('Register'),
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text('Already have an account?'),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      {required String hintText,
      required TextEditingController controller,
      required bool obstxt}) {
    return TextField(
      controller: controller,
      obscureText: obstxt,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
      ),
    );
  }
}
