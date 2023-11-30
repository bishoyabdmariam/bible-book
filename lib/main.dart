import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';

import 'Screens/BiblesListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguagePreferences.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        // Add your desired background color here
        scaffoldBackgroundColor: Colors.grey[200],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Versions'),
      ),
      body: const BibleListScreen(),
    );
  }
}
