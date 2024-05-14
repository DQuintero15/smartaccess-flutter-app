import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smartaccess_app/src/dtos/business.dart';
import 'package:smartaccess_app/src/services/business_service.dart';
import 'package:smartaccess_app/src/services/firebase_auth_service.dart';
import 'package:smartaccess_app/src/utils/app_color.dart';
import 'package:smartaccess_app/src/utils/app_constants.dart';
import 'package:smartaccess_app/src/utils/validators.dart';
import 'package:smartaccess_app/src/widgets/button_widget.dart';
import 'package:smartaccess_app/src/widgets/password_widget.dart';
import 'package:smartaccess_app/src/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  final nameController = TextEditingController();
  final businessNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final coastPerMinuteController = TextEditingController();

  final businessService = BusinessService();
  final firebaseAuthService = FirebaseAuthService();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.caribbeanCurrent,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Image.asset(AppConstants.smallWhiteLogo, width: 40, height: 40),
                const SizedBox(height: 80),
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
                  controller: widget.nameController,
                  hintText: 'Ingresa tu nombre completo',
                  type: TextInputType.text,
                  errorText: _formKey.currentState?.validate() == true
                      ? 'Por favor ingresa tu nombre completo'
                      : null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu nombre completo';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: widget.emailController,
                  hintText: 'Ingresa tu correo electrónico',
                  type: TextInputType.emailAddress,
                  errorText: _formKey.currentState?.validate() == true
                      ? 'Por favor ingresa un correo electrónico válido'
                      : null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa un correo electrónico válido';
                    }
                    if (Validators.isEmail(value) == false) {
                      return 'Por favor ingresa un correo electrónico válido';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                PasswordWidget(
                    controller: widget.passwordController,
                    hintText: 'Ingresa tu contraseña',
                    errorText: _formKey.currentState?.validate() == true
                        ? 'Por favor ingresa una contraseña'
                        : null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa una contraseña';
                      }
                      if (Validators.passwordLength(value) == false) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }

                      return null;
                    }),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: widget.businessNameController,
                  hintText: 'Ingresa el nombre de tu negocio',
                  type: TextInputType.text,
                  errorText: _formKey.currentState?.validate() == true
                      ? 'Por favor ingresa el nombre de tu negocio'
                      : null,
                  validator: (value) => value!.isEmpty
                      ? 'Por favor ingresa el nombre de tu negocio'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: widget.coastPerMinuteController,
                  hintText: 'Ingresa el costo por minuto',
                  type: TextInputType.number,
                  errorText: _formKey.currentState?.validate() == true
                      ? 'Por favor ingresa el costo por minuto'
                      : null,
                  validator: (value) =>
                      value!.isEmpty || Validators.isNumeric(value) == false
                          ? 'Por favor ingresa el costo por minuto'
                          : null,
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = widget.emailController.text;
                      final password = widget.passwordController.text;

                      final registeredUser = await widget.firebaseAuthService
                          .createUserWithEmailAndPassword(email, password);

                      if (registeredUser != null) {
                        final name = widget.nameController.text;
                        final businessName = widget.businessNameController.text;
                        final coastPerMinute =
                            widget.coastPerMinuteController.text;

                        final token = await registeredUser.getIdToken();

                        if (token == null) {
                          Fluttertoast.showToast(
                            msg: 'Ocurrió un error al registrar tu negocio',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        final businessDto = BusinessDto.fromJson({
                          'name': businessName,
                          'email': email,
                          'owner': name,
                          'coastPerMinute': coastPerMinute,
                        });

                        final response = await widget.businessService
                            .registerBusiness(businessDto, token);

                        if (response != null) {
                          Fluttertoast.showToast(
                            msg: 'Tu negocio ha sido registrado exitosamente',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );

                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/navigation');
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Ocurrió un error al registrar tu negocio',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      }
                    }
                  },
                  formKey: _formKey,
                  text: 'Crear cuenta',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
