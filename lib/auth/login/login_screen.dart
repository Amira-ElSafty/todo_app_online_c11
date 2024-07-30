import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/app_colors.dart';
import 'package:flutter_app_todo_online_c11/auth/custom_text_form_field.dart';
import 'package:flutter_app_todo_online_c11/auth/register/register_screen.dart';
import 'package:flutter_app_todo_online_c11/dialog_utils.dart';
import 'package:flutter_app_todo_online_c11/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'amira@route.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundLightColor,
          child: Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome Back!',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Email.';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter valid email.';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      controller: passwordController,
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter Password.';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 chars.';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text('Login')),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RegisterScreen.routeName);
                        },
                        child: Text('OR Create Account'))
                  ],
                ),
              )),
        )
      ],
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      /// login
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushNamed(HomeScreen.routeName);
          },
          message: 'Login Successfully.',
          title: 'Success',
        );
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              title: 'Error',
              posActionName: 'Ok',
              message:
                  'The supplied auth credential is incorrect,malformed or has expired..');
          print('The supplied auth credential is incorrect,'
              ' malformed or has expired..');
        } else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show Message
          DialogUtils.showMessage(
              context: context,
              posActionName: 'Ok',
              message:
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
              title: 'Error');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            posActionName: 'Ok',
            message: e.toString(),
            title: 'Error');
        print(e.toString());
      }
    }
  }
}
