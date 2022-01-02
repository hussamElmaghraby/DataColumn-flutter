import 'package:flutter/material.dart';
import 'package:intro_docs_run/service.dart';

void main() {
  runApp(
    HardWorkers(),
  );
}

class HardWorkers extends StatelessWidget {
  const HardWorkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Table',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Table Test"),
      ),
      body: Service(),
    );
  }
}
