import 'package:flutter/material.dart';
import 'package:minimal_snackbar/minimal_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Snackbar Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              MinimalSnackbar.showSuccess(context, "Success!");
            },
            child: const Text("Show Snackbar"),
          ),
        ),
      ),
    );
  }
}
