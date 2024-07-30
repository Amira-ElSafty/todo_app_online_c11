import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_online_c11/auth/login/login_screen.dart';
import 'package:flutter_app_todo_online_c11/auth/register/register_screen.dart';
import 'package:flutter_app_todo_online_c11/home/home_screen.dart';
import 'package:flutter_app_todo_online_c11/my_theme_data.dart';
import 'package:flutter_app_todo_online_c11/provider/list_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyBUIW_4Px8-8aoE-RwxuXFN813hd2nRb_E',
              appId: 'com.example.flutter_app_todo_online_c11',
              messagingSenderId: '421076690765',
              projectId: 'todo-app-online-c11'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => ListProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      theme: MyThemeData.lightTheme,
    );
  }
}
