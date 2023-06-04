import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/components/back_navigation.dart';
import '../../../../core/components/error_dialog.dart';
import '../../../../core/components/text/footer_login_register.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/styles/colors.dart';
import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
              const _RegisterForm(),
              const SizedBox(height: 52),
              FooterLoginRegister(
                firstText: 'Have an account?',
                secondText: 'Login here',
                onTap: () {
                  Get.to(() => const LoginPage(),
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonState);
    nameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    passwordConfirmController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = validateFields();
    });
  }

  bool validateFields() {
    return emailController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty &&
        passwordController.text == passwordConfirmController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _RegisterTitle(),
          const SizedBox(height: 15),
          _EmailTextField(controller: emailController),
          const SizedBox(height: 15),
          _NameTextField(controller: nameController),
          const SizedBox(height: 15),
          _PasswordTextField(controller: passwordController),
          const SizedBox(height: 15),
          _ConfirmPasswordTextField(controller: passwordConfirmController),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: isButtonEnabled
                ? () {
                    FocusScope.of(context).unfocus();
                    // Lakukan tindakan pendaftaran
                    performRegistration();
                  }
                : null,
            child: Center(
                child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is FailureRegisterState) {
                  buildErrorDialog(context, state.msg);
                }
                if (state is SuccesRegisterState) {
                  if (state.msg == 'success') {
                    Get.offAllNamed(AppRoutes.profile,
                        arguments: [emailController.text]);
                  }
                }
              },
              builder: (context, state) {
                bool isLoading = state is LoadingRegisterState;
                bool isButtonEnabled = emailController.text.isNotEmpty &&
                    nameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    passwordConfirmController.text.isNotEmpty;

                return GestureDetector(
                  onTap: isButtonEnabled ? () => performRegistration() : null,
                  child: Opacity(
                    opacity: isButtonEnabled ? 1.0 : 0.3,
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
                                        Colors.white,
                                      ),
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
                            : const Text(
                                'Register',
                                style: TextStyle(
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
              },
            )),
          ),
        ],
      ),
    );
  }

  void showPasswordMismatchDialog(BuildContext context) {
    buildErrorDialog(context, 'Password and Confirm Password do not match.');
  }

  void performRegistration() {
    final email = emailController.text;
    final name = nameController.text;
    final password = passwordController.text;
    final confirmPassword = passwordConfirmController.text;

    if (password != confirmPassword) {
      showPasswordMismatchDialog(context);
      return;
    }

    context.read<RegisterCubit>().registerEvent(
          email: email,
          name: name,
          password: password,
        );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: ("Create Username"),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
        hintText: ("Enter Email"),
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.4),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        bool obscureText = true;

        if (state is ObscureTextState) {
          obscureText = state.obscureText;
        }

        return TextFormField(
          onChanged: (text) {},
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<RegisterCubit>().toggleObscureText();
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
            hintText: ("Create Password"),
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

class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        bool obscureText = true;

        if (state is ObscureTextState) {
          obscureText = state.obscureText;
        }

        return TextFormField(
          onChanged: (text) {},
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                context.read<RegisterCubit>().toggleObscureText();
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
            hintText: ("Confirm Password"),
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

class _RegisterTitle extends StatelessWidget {
  const _RegisterTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "Register",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}
