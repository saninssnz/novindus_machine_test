import 'package:flutter/material.dart';
import 'package:novindus_machine_test/Ui/HomeScreen.dart';
import 'package:novindus_machine_test/Ui/MainScreen.dart';
import 'package:provider/provider.dart';

import 'Provider/Provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen()
    );
  }
}
