import 'package:create_it/src/view_model/user_riverpod_initialization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/screens/auths/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrisisIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class WidgetToShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read(userProvider).userLoginState(context);
    return Scaffold(
      body: Container(
        child: Center(child: Text("Welcome to CrisisIT")),
      ),
    );
  }
}
