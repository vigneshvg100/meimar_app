import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SpotController extends GetxController {
  late final RxMap<String, dynamic> spotData;
  final selectedTabIndex = 0.obs;

  // Notes state
  final notes = <Map<String, String>>[
    {
      'text':
          'Wear slip-resistant footwear and protect your gadgets from the mist.',
      'time': 'Added Today , 7:00 PM',
    },
  ].obs;

  final noteController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      spotData = Map<String, dynamic>.from(args).obs;
    } else {
      spotData = <String, dynamic>{
        'spot_name': 'Abbi Waterfall',
        'spot_id': 'abbi_waterfall',
        'address': 'Madikeri, Coorg, Karnataka',
        'rating': 4.5,
        'estimated_duration': '2-3 hours',
        'opening_hours': '9:00 AM - 5:00 PM',
      }.obs;
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void addNote() {
    if (noteController.text.trim().isNotEmpty) {
      final now = DateTime.now();
      notes.insert(0, {
        'text': noteController.text.trim(),
        'time':
            'Added Today , ${DateFormat('h:mm a').format(now)}', // Matching screenshot format loosely
      });
      noteController.clear();
    }
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }
}
