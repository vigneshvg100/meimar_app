import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/itinerary_controller.dart';

class ItineraryView extends GetView<ItineraryController> {
  const ItineraryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ItineraryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                'ItineraryView is working',
                style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text('WAITING FOR DESIGN SCREENSHOT'),
            ],
        ),
      ),
    );
  }
}
