import 'package:flutter/material.dart';
import 'dart:async';

class GeneratingItineraryPage extends StatefulWidget {
  const GeneratingItineraryPage({super.key});

  @override
  _GeneratingItineraryPageState createState() =>
      _GeneratingItineraryPageState();
}

class _GeneratingItineraryPageState extends State<GeneratingItineraryPage> {
  int _dotCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount + 1) % 4; // 0,1,2,3
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get dots => '.' * _dotCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Generating itinerary$dots',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
