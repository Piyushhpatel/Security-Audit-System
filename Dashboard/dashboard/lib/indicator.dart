import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wave_loading_indicator/wave_progress.dart';

class Indicator extends StatefulWidget {
  const Indicator({super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  bool scanning = false;
  int touchedIndex = -1;
  late Map<dynamic, dynamic> scanStatus = {};
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> getScanStatus() async {
    DatabaseReference ref = database.ref('scan_status');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        scanStatus = data as Map<dynamic, dynamic>;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getScanStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(20),
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
      child: scanning
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WaveProgress(
                  borderSize: 3.0,
                  size: 180,
                  borderColor: Colors.blue,
                  foregroundWaveColor: Colors.blue,
                  backgroundWaveColor: Colors.blue[100],
                  progress: 100, // [0-100]
                  innerPadding: 5, // padding between border and waves
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Scanning...",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(scanStatus),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.indigo,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Healthy Files",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.blueAccent[100],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Malicious Files",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

List<PieChartSectionData> showingSections(scanStatus) {
  return List.generate(2, (i) {
    final isTouched = i == -1;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 61.0 : 61.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    double healthy = scanStatus['healthy_files'] != null
        ? scanStatus['healthy_files'] as double
        : 0.0;
    double total = scanStatus['total_files'] != null
        ? scanStatus['total_files'] as double
        : 0.0;
    double mal = scanStatus['suspicious_files'] != null
        ? scanStatus['suspicious_files'] as double
        : 0.0;

    double hval = healthy / total * 100;
    double mval = mal / total * 100;

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue[100],
          value: mal,
          title: '$mval%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.indigoAccent,
          value: hval,
          title: '$hval%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.blue[50],
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
