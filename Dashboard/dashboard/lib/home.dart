import 'package:dashboard/indicator.dart';
import 'package:dashboard/log_box.dart';
import 'package:dashboard/system_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<dynamic, dynamic> usb = {};
  bool isPluggedIn = false;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning !!'),
          content: const Text("Please Plug in the key and press continue"),
          icon: const Icon(
            Icons.warning_rounded,
            size: 60,
          ),
          backgroundColor: Colors.white,
          iconColor: Colors.amber,
          actionsAlignment: MainAxisAlignment.center,
          buttonPadding: const EdgeInsets.all(20),
          elevation: 5,
          titleTextStyle: const TextStyle(fontSize: 28, color: Colors.black45),
          contentTextStyle:
              const TextStyle(color: Colors.black45, fontSize: 21),
          shadowColor: Colors.black,
          surfaceTintColor: Colors.black,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (usb['status'] == 'true') {
                  Navigator.of(context).pop();
                }
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(10))),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    DatabaseReference ref = FirebaseDatabase.instance.ref('usb_status');
    ref.onValue.listen((event) {
      final data = event.snapshot.value ?? {};
      setState(() {
        usb = data as Map<dynamic, dynamic>;

        if (usb['status'] == 'false' || usb.isEmpty == true) {
          _showMyDialog();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SystemInfo(),
            FlipCard(
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              front: Indicator(),
              back: LogBox(),
            ),
          ],
        ),
      ),
    );
  }
}
