import 'dart:async';
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
  double _progress = 0.0;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        if (_progress < 100.0) {
          _progress += 10; // Increment progress by 10% every second
        } else {
          scanning = false; // Set to false to show the percent indicator
          timer.cancel(); // Stop the timer when progress reaches 100%
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
                  progress: _progress, // [0-100]
                  innerPadding: 5, // padding between border and waves
                ),
                SizedBox(height: 8.0),
                Text(
                  "Scanning...",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            )
          : Expanded(
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
                  sections: showingSections(),
                ),
              ),
            ),
    );
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(2, (i) {
    final isTouched = i == -1;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 90.0 : 90.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.red,
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.green,
          value: 60,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
