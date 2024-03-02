import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            )),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.teal),
            child: Column(
              children: [
                Text("System Info"),
              ],
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.yellow),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
