import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/auth/login/login_navigator.dart';

class LoginScreenViewModel extends ChangeNotifier {
  // hold data - handle logic
  var emailController = TextEditingController(text: 'amira29@route.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  void login() async {
    if (formKey.currentState?.validate() == true) {
      navigator.showMyLoading('Waiting...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        // var user = await FirebaseUtils.readUserFromFireStore(
        //     credential.user?.uid ?? '');
        // if (user == null) {
        //   return;
        // }
        // var authProvider =
        // Provider.of<AuthUserProvider>(context, listen: false);
        // authProvider.updateUser(user);
        navigator.hideMyLoading();
        navigator.showMyMessage('Login Successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideMyLoading();
          navigator.showMyMessage(
              'The supplied auth credential is incorrect,malformed'
              ' or has expired..');
        } else if (e.code == 'network-request-failed') {
          //todo: hide loading
          navigator.hideMyLoading();
          //todo: show Message
          navigator.showMyMessage(
              'A network error (such as timeout, interrupted connection or'
              ' unreachable host) has occurred.');
        }
      } catch (e) {
        //todo: hide loading
        navigator.hideMyLoading();
        //todo: show Message
        navigator.showMyMessage(e.toString());
      }
    }
  }
}
