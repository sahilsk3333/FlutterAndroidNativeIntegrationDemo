import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "hello"),
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

  static const platform = MethodChannel('com.example/my_channel');

  @override
  void initState() {
    super.initState();

    // Set up the MethodChannel handler
    platform.setMethodCallHandler((call) async {
      if (call.method == 'canHandleBackPress') {
        // Check if Navigator can pop
        bool canPop = Navigator.canPop(context);
        return canPop;
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ScreenA());
  }
}
