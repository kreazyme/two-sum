import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testt/const.dart';
import 'package:testt/string_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two sum app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculate two sum'),
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
  final TextEditingController _firstNumController = TextEditingController();
  final TextEditingController _secondNumController = TextEditingController();

  int _result = 0;
  static const platform = MethodChannel(AppConstant.channelName);

  Future<void> _add() async {
    try {
      final int firstNum = _firstNumController.text.parseToInt;
      final int secondNum = _secondNumController.text.parseToInt;
      _result = await platform.invokeMethod(AppConstant.addTwoSum, {
        AppConstant.firstNum: '$firstNum',
        AppConstant.secondNum: '$secondNum'
      });
    } catch (_) {
      _result = 0;
      log('An error has occurs');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _firstNumController.addListener(_add);
    _secondNumController.addListener(_add);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.all(12),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _firstNumController,
                    decoration: const InputDecoration(
                      hintText: 'First num',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                    child: TextField(
                  controller: _secondNumController,
                  decoration: const InputDecoration(
                    hintText: 'Second num',
                    border: OutlineInputBorder(),
                  ),
                ))
              ],
            ),
          ),
          const SizedBox(height: 50),
          Text(
            'Result: $_result',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
