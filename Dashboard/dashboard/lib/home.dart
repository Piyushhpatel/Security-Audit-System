// import 'package:firebase_core/firebase_core.dart';
import 'package:dashboard/indicator.dart';
import 'package:dashboard/log_box.dart';
import 'package:dashboard/system_info.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

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
        title: const Text(
          "Dashboard",
          style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
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
              fill: Fill
                  .fillBack, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.HORIZONTAL, // default
              side: CardSide.FRONT, // The side to initially display.
              front: Indicator(),
              back: LogBox(),
            )
          ],
        ),
      ),
    );
  }
}
