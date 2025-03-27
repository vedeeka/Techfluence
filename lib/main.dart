import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'component/dashboard components/homepage.dart';

void main() async {
  Gemini.init(
      apiKey: "AIzaSyD-5p-hGCOVtgH2WnLWgQBDNuwUl2QZn3g", enableDebugging: true);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBjani-88rouvTvZGGWcJnlZgDED85F-iU",
      appId: "1:617792526078:android:cc737ca9b7ec975260b7af",
      messagingSenderId: "617792526078",
      projectId: "student-app-8fa25",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
