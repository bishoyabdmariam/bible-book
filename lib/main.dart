import 'package:bible/service/apiService.dart';
import 'package:flutter/material.dart';

import 'Screens/BiblesListScreen.dart';

Future<void> main() async {
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
      home: const Scaffold(
        body: BibleListScreen(),
      ),
      theme: ThemeData(
        // Add your desired background color here
        scaffoldBackgroundColor: Colors.grey[200],
      ),
    );
  }
}
