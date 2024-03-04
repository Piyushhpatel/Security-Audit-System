import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LogBox extends StatefulWidget {
  const LogBox({super.key});

  @override
  State<LogBox> createState() => _LogBoxState();
}

class _LogBoxState extends State<LogBox> with TickerProviderStateMixin {
  List<String> logData = [];
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    DatabaseReference logRef = FirebaseDatabase.instance.ref('log_file_status');
    logRef.onChildAdded.listen((event) {
      final fileName = event.snapshot.value.toString();
      setState(() {
        logData.add(fileName);
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use addPostFrameCallback to ensure the widget is fully laid out
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(20),
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
      child: Column(
        children: [
          const Text(
            "Logs",
            style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: logData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("${index + 1}: ${logData[index]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
