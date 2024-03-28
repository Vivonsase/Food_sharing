import 'package:flutter/material.dart';
import 'package:food/join.dart';
import 'package:food/persistdb.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Sharing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Food Sharing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // All users
  List<Map<String, dynamic>> users = [];

  //bool _isLoading = true;
  //this function is used to fetch all data from database
  void _refreshusers() async {
    final data = await SQLHelper.getusers();
    setState(() {
      users = data;
      //_isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshusers(); //Loading users when the app stops
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: JoinForm());
  }
}
