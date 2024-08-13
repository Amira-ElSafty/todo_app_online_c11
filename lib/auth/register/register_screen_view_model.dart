import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/auth/register/register_navigator.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  // hold data - handle logic
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    //todo: show loading
    navigator.showMyLoading('Loading...');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // var authProvider =
      // Provider.of<AuthUserProvider>(context, listen: false);
      // authProvider.updateUser(myUser);
      // await FirebaseUtils.addUserToFireStore(myUser);
      //todo: hide loading
      navigator.hideMyLoading();
      //todo: show Message
      navigator.showMyMessage('Register Successfully.');
      // DialogUtils.showMessage(
      //     context: context,
      //     message: 'Register Successfully.',
      //     title: 'Success',
      //     posActionName: 'Ok',
      //     posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
      print(credential.user?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //todo: hide loading
        navigator.hideMyLoading();
        //todo: show Message
        navigator.showMyMessage('The password provided is too weak.');
        // DialogUtils.showMessage(
        //     context: context,
        //     message: 'The password provided is too weak.',
        //     title: 'Error',
        //     posActionName: 'Ok');
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //todo: hide loading
        navigator.hideMyLoading();
        //todo: show Message
        navigator.showMyMessage('The account already exists for that email.');
        // //todo: hide loading
        // DialogUtils.hideLoading(context);
        // //todo: show Message
        // DialogUtils.showMessage(
        //     context: context,
        //     posActionName: 'Ok',
        //     message: 'The account already exists for that email.',
        //     title: 'Error');
        // print('The account already exists for that email.');
      } else if (e.code == 'network-request-failed') {
        //todo: hide loading
        navigator.hideMyLoading();
        //todo: show Message
        navigator.showMyMessage(
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
        //todo: hide loading
        // DialogUtils.hideLoading(context);
        // //todo: show Message
        // DialogUtils.showMessage(
        //     context: context,
        //     posActionName: 'Ok',
        //     message:
        //     'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        //     title: 'Error');
        // print('The account already exists for that email.');
      }
    } catch (e) {
      //todo: hide loading
      navigator.hideMyLoading();
      //todo: show Message
      navigator.showMyMessage(e.toString());
    }
  }
}
