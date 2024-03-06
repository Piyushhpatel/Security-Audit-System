import 'dart:async';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wave_loading_indicator/wave_progress.dart';

class Indicator extends StatefulWidget {
  const Indicator({super.key});

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  bool scanning = true;
  int touchedIndex = -1;
  late Map<dynamic, dynamic> scanStatus = {};
  late Map<dynamic, dynamic> totalFile = {};
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<String> log = [];
  double _progress = 0.0;
  int fileCount = 0;

  Future<void> getScanStatus() async {
    DatabaseReference ref = database.ref('scan_status');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        scanStatus = data as Map<dynamic, dynamic>;
      });
    });
  }

  Future<void> getTotalFiles() async {
    DatabaseReference ref = database.ref('totalFile');
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        totalFile = data as Map<dynamic, dynamic>;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTotalFiles();
    getScanStatus();

    DatabaseReference logRef = FirebaseDatabase.instance.ref('log_file_status');
    logRef.onChildAdded.listen((event) {
      final fileName = event.snapshot.value.toString();
      setState(() {
        log.add(fileName);
        fileCount = totalFile['totalfiles'] ?? 0;
        int logLength = log.length;
        // Check if fileCount is greater than zero before calculating progress
        if (fileCount > 0) {
          _progress = (log.length / fileCount) * 100;
        } else {
          // Handle the case where fileCount is zero (to avoid division by zero)
          _progress = 0.0;
        }
        print(
            'Progrss : $_progress, Filecout : $fileCount, Log Length : $logLength');
        if (_progress >= 100) {
          scanning = false;
        }
      });
    });
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
          ),
        ],
      ),
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
                  progress: _progress, // [0-100]
                  innerPadding: 5,
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
                      centerSpaceRadius: 30,
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
    final radius = isTouched ? 65.0 : 65.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    int healthy = scanStatus['healthy_files'] ?? 0;
    int total = scanStatus['total_files'] ?? 0;
    int mal = scanStatus['suspicious_files'] ?? 0;

    double hval = total != 0 ? (healthy / total * 100) : 0;
    double mval = total != 0 ? (mal / total * 100) : 0;

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue[100],
          value: mval,
          title: mval.toStringAsFixed(1) + '%',
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
          title: hval.toStringAsFixed(1) + '%',
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
