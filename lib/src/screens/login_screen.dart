import 'package:flutter/material.dart';
import 'package:smartaccess_app/src/services/supabase.service.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:smartaccess_app/src/widgets/button_widget.dart';
import 'package:smartaccess_app/src/widgets/password_widget.dart';
import 'package:smartaccess_app/src/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.caribbeanCurrent,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset(AppConstants.smallWhiteLogo, width: 40, height: 40),
                const SizedBox(height: 100),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
                const SizedBox(height: 50),
                TextFieldWidget(
                    controller: widget.emailController,
                    hintText: 'Ingresa tu correo electrónico',
                    type: TextInputType.emailAddress),
                const SizedBox(height: 20),
                PasswordWidget(
                    controller: widget.passwordController,
                    hintText: '**********'),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: AppColor.white,
                          fontFamily: AppConstants.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () async {
                    final email = widget.emailController.text;
                    final password = widget.passwordController.text;

                    final response = await SupabaseService()
                        .signInWithEmailAndPassword(email, password);

                    if (response != null) {
                    } else {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo o contraseña incorrectos'),
                        ),
                      );
                      
                    }

                  },
                  text: 'Iniciar sesión',
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () {},
                  text: 'Registrarse',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
