import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantripFormController extends GetxController {
  // Form Controllers
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final distanceController = TextEditingController();

  // State
  final selectedCompanion = 0.obs;

  // Options
  final companions = [
    {"title": "Solo", "desc": "Time to recharge and wander", "icon": Icons.person},
    {"title": "Couple", "desc": "Moments made just for two", "icon": Icons.favorite_border},
    {"title": "Family", "desc": "Easy days for every age", "icon": Icons.family_restroom},
    {"title": "Friends", "desc": "Shared stories and late night", "icon": Icons.celebration},
  ];

  void selectCompanion(int index) {
    selectedCompanion.value = index;
  }

  void generateItinerary() {
    print("Generating Itinerary for: ${cityController.text}");
    // TODO: Navigate or call API
  }

  @override
  void onClose() {
    cityController.dispose();
    dateController.dispose();
    distanceController.dispose();
    super.onClose();
  }
}
