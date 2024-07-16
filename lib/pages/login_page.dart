import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/components/my_button.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/register_page.dart';
import 'package:news_app/services/auth/auth_services.dart';

class LoginPage extends StatelessWidget {

    
    final void Function()? onTap;


  const LoginPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void login() async{

      final _authService = AuthServices();

      try{
        await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
      }catch(e){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
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
                height: MediaQuery.of(context).viewPadding.top + 25,
              ),
              Lottie.asset('assets/Animation - News App.json'),
              const SizedBox(height: 50),
              customTextField(hintText: 'Email', controller: emailController, obstxt:false),
              const SizedBox(height: 25),
              customTextField(hintText: 'Password', controller: passwordController, obstxt:true),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: login,
                  child: Text('Login'),
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text('Not a member?'),
                  const SizedBox(width: 2),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'Register Now',
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

  Widget customTextField({required String hintText, required TextEditingController controller, required bool obstxt}) {
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
