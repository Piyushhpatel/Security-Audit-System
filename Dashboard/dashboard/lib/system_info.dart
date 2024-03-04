import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SystemInfo extends StatefulWidget {
  const SystemInfo({super.key});

  @override
  State<SystemInfo> createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> {
  late Map<dynamic, dynamic> systemInfo = {};
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> getSystemInfo() async {
    DatabaseReference ref = database.ref('system_info');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        systemInfo = data as Map<dynamic, dynamic>;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSystemInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                2.0,
                2.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxS
          ]),
      child: Column(
        children: [
          const Text("System Info",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "Host Name : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['Hostname']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "Machine : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['Machine']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "IP Address : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['IP Address']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "OS : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['System']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "Version : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['Version'] != null ? systemInfo['Version'] + systemInfo['Release'] + systemInfo['OS'] : systemInfo['Version']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "Processor : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['Processor'] != null ? systemInfo['Processor'].substring(0, 18) : systemInfo['Processor']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                "CPU Cores : ",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "${systemInfo['CPU Cores']}",
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ],
      ),
    );
  }
}
