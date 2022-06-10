import 'package:flutter/material.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mes voitures"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: '',
        child: Icon(Icons.add),
      ),
    );
  }
}
