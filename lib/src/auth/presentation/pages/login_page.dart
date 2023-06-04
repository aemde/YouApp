import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/core/routes/app_routes.dart';
import 'package:youapp_test/core/styles/colors.dart';

import '../../../../core/components/back_navigation.dart';
import '../../../../core/components/text/footer_login_register.dart';
import '../../../../core/components/error_dialog.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: YouAppColors.greenGradient,
            center: Alignment.topRight,
            radius: 2.5,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackNavigation(),
              const SizedBox(height: 60),
              const _LoginForm(),
              const SizedBox(height: 52),
              FooterLoginRegister(
                firstText: 'No account? ',
                secondText: 'Register here',
                onTap: () {
                  Get.to(() => const RegisterPage(),
                      duration: const Duration(milliseconds: 0));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();

class _LoginFormState extends State<_LoginForm> {
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    emailController.removeListener(updateButtonState);
    passwordController.removeListener(updateButtonState);
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _LoginTitle(),
          const SizedBox(height: 15),
          EmailTextField(controller: emailController),
          const SizedBox(height: 15),
          PasswordTextField(controller: passwordController),
          const SizedBox(height: 25),
          BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
            if (state is SuccessLoginState) {
              if (state.msg == 'success') {
                // Get.offAllNamed(AppRoutes.profile);
                Get.offAllNamed(AppRoutes.profile,
                    arguments: [emailController.text]);
              }
            }
            if (state is FailureLoginState) {
              buildErrorDialog(context, state.msg);
            }
          }, builder: (context, state) {
            bool isLoading = false;
            if (state is LoadingLoginState) {
              isLoading = true;
            }
            return GestureDetector(
              key: const Key('login_button'),
              onTap: emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty
                  ? () {
                      FocusScope.of(context).unfocus();
                      context.read<LoginCubit>().loginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  : null, // Nonaktifkan onTap jika email atau password kosong
              child: Opacity(
                opacity: emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty
                    ? 1.0 // Opasitas saat aktif
                    : 0.3, // Opasitas saat dinonaktifkan
                child: Container(
                  height: 48,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(98, 205, 203, 1),
                        Color.fromRGBO(69, 153, 219, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(98, 205, 203, 0.5),
                        blurRadius: 15,
                        offset: Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Center(
                    child: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 3.0,
                                ),
                              ),
                              SizedBox(width: 14),
                              Text(
                                'Loading . . .',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            state is SuccessLoginState ? 'Login' : 'Login',
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: 0.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class _LoginTitle extends StatelessWidget {
  const _LoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "Login",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('email_text_field'),
      onChanged: (text) {},
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        hintText: ("Enter Username/Email"),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        bool obscureText = true;

        if (state is ObscureTextState) {
          obscureText = state.obscureText;
        }

        return TextFormField(
          key: const Key('password_text_field'),
          onChanged: (text) {},
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              key: const Key('toggle_button'),
              onTap: () {
                context.read<LoginCubit>().toggleObscureText();
              },
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.06),
            hintText: ("Enter Password"),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 13,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        );
      },
    );
  }
}
