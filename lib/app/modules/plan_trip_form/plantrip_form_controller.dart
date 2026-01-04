import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meimar_app/app/data/api/services/itinerary_service.dart';
import 'package:meimar_app/app/data/api/services/location_service.dart';
import 'package:meimar_app/app/routes/app_pages.dart';

class PlantripFormController extends GetxController {
  final cityController = TextEditingController();
  final distanceController = TextEditingController();
  final itineraryService = ItineraryService();
  final locationService = LocationService();

  // Location State
  final latitude = Rx<double?>(null);
  final longitude = Rx<double?>(null);
  final selectedCityName = "".obs;

  // Search suggestions state
  final suggestions = <Map<String, dynamic>>[].obs;
  final isLoadingSuggestions = false.obs;

  // Options State
  final selectedCompanion = 0.obs;
  final selectedDistanceOption = 0.obs;
  final radiusMap = [
    {
      "title": "Nearby(0-5 km)",
      "description": "Places close by with minimal travel",
      "radius": 5000,
    },
    {
      "title": "City Highlight(5-15 km)",
      "description": "Main attractions across the city ",
      "radius": 15000,
    },
    {
      "title": "City Highlight(15-25 km)",
      "description": "Main attractions across the city ",
      "radius": 25000,
    },
  ];

  final companions = [
    {"title": "Solo", "icon": Icons.person_outline},
    {"title": "Couple", "icon": Icons.favorite_border},
    {"title": "Friends", "icon": Icons.celebration_outlined},
    {"title": "Family", "icon": Icons.family_restroom},
  ];

  @override
  void onInit() {
    super.onInit();
    debounce(currentField, (_) {
      if (currentField.value == "place" && cityController.text.length > 3) {
        _searchPlaces(cityController.text);
      }
    }, time: const Duration(milliseconds: 500));

    cityController.addListener(() {
      if (currentField.value == "place") {
        if (cityController.text.length > 3) {
          _searchPlaces(cityController.text);
        } else {
          suggestions.clear();
        }
      }
    });
  }

  Future<void> _searchPlaces(String query) async {
    isLoadingSuggestions.value = true;
    final results = await locationService.getSuggestions(query);
    suggestions.assignAll(results);
    isLoadingSuggestions.value = false;
  }

  void selectSuggestion(Map<String, dynamic> suggestion) {
    print(suggestion);
    final displayName = suggestion['display_name'];
    final lat = double.tryParse(suggestion['lat'] ?? '');
    final lon = double.tryParse(suggestion['lon'] ?? '');

    cityController.text = displayName ?? "";
    selectedCityName.value = displayName ?? "";
    latitude.value = lat;
    longitude.value = lon;

    suggestions.clear();
    currentField.value = "";
    FocusManager.instance.primaryFocus?.unfocus();
  }

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var dateController = TextEditingController();
  final isDatePickerOpen = false.obs;

  final currentField = "".obs;

  void toggleDatePicker() {
    isDatePickerOpen.value = !isDatePickerOpen.value;
    currentField.value = "date";
    suggestions.clear();
  }

  void selectPlace() {
    currentField.value = "place";
  }

  void selectCompanion(int index) {
    selectedCompanion.value = index;
  }

  void selectRadiusOption(int index) {
    selectedDistanceOption.value = index;
  }

  void updateDateRange(DateTime start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
    final startStr = "${start.day} ${_getMonthData(start.month)}";
    final endStr = end != null
        ? "${end.day} ${_getMonthData(end.month)}"
        : "...";
    dateController.text = end != null ? "$startStr - $endStr" : startStr;
  }

  String _getMonthData(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void generateItinerary() async {
    // Show loading page
    Get.toNamed(Routes.GENERATING_LOADER);

    final radius = radiusMap[selectedDistanceOption.value]['radius'] as int;
    int totalDays =
        (endDate.value?.difference(startDate.value ?? DateTime.now()).inDays ??
            0) +
        1;

    final requestBody = {
      "city": cityController.text,
      "centreLatitude": latitude.value,
      "centreLongitude": longitude.value,
      "startDate": startDate.value?.toIso8601String(),
      "endDate": endDate.value?.toIso8601String(),
      "companion": companions[selectedCompanion.value]['title'],
      "radius": radius,
      "maxSpotsPerDay": 3,
      "noOfDays": totalDays,
    };

    print(requestBody);

    try {
      // Call service
      final response = await itineraryService.generateItinerary(requestBody);

      // Add a small delay so the user can see the "Generating" state
      await Future.delayed(const Duration(seconds: 2));
      // Navigate to the new itinerary page and pass the response as arguments
      Get.offNamed(Routes.ITINERARY, arguments: response);
    } catch (e) {
      print("Error generating itinerary: $e");
      Get.back(); // Close loader
      Get.snackbar("Error", "Something went wrong while generating your trip.");
    }
  }

  @override
  void onClose() {
    cityController.dispose();
    dateController.dispose();
    distanceController.dispose();
    super.onClose();
  }
}
