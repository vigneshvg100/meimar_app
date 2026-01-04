import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meimar_app/app/data/api/services/itinerary_service.dart';

class PlantripFormController extends GetxController {
  // Form Controllers
  final cityController = TextEditingController();
  // final dateController = TextEditingController();
  final distanceController = TextEditingController();
  final itineraryService =
      ItineraryService(); // Keep for custom input if needed later? Or remove? logic: User didn't ask to remove, but design replaced it with cards. I'll keep it but not use it for now, or just ignore it.

  // Location State
  final latitude = Rx<double?>(null);
  final longitude = Rx<double?>(null);
  final selectedCityName = "".obs;

  // State
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
    {
      "title": "Friends",
      "icon": Icons.celebration_outlined,
    }, // Using outlined icons for unselected state usually, but let's stick to standard
    {"title": "Family", "icon": Icons.family_restroom},
  ];
  @override
  void onInit() {
    super.onInit();
  }

  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var dateController = TextEditingController();
  final isDatePickerOpen = false.obs;

  final currentField = "".obs;

  void toggleDatePicker() {
    isDatePickerOpen.value = !isDatePickerOpen.value;
    currentField.value = "date";
  }

  void selectPlace() {
    currentField.value = "place";
  }

  void pickDateRange() async {
    final picked = await showDateRangePicker(
      context: Get.context!, // required for showing modal
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      initialDateRange: startDate.value != null && endDate.value != null
          ? DateTimeRange(start: startDate.value!, end: endDate.value!)
          : null,
    );

    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;

      // Update TextField
      dateController.text =
          "${picked.start.day}/${picked.start.month}/${picked.start.year} - ${picked.end.day}/${picked.end.month}/${picked.end.year}";
    }
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
    // Format: "09 Sep - 13 Sep"
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

  void setLocation(String name, double lat, double lng) {
    cityController.text = name;
    selectedCityName.value = name;
    latitude.value = lat;
    longitude.value = lng;
    print("Selected: $name ($lat, $lng)");
  }

  void generateItinerary() {
    print("Generating Itinerary for: ${cityController.text}");
    print("Coordinates: ${latitude.value}, ${longitude.value}");
    print("Dates: ${dateController.text}");
    print("Companion: ${companions[selectedCompanion.value]['title']}");
    print(
      "Distance Option: ${selectedDistanceOption.value == 0 ? "Nearby" : "City Highlight"}",
    );
    final radius = radiusMap[selectedDistanceOption.value]['radius'];
    final requestBody = {
      "city": cityController.text,
      "centreLatitude": latitude.value,
      "centreLongitude": longitude.value,
      "startDate": startDate.value,
      "endDate": endDate.value,
      "companion": companions[selectedCompanion.value]['title'],
      "radius": radius,
      "maxSpotsPerDay": 3,
      "noOfDays": 2,
    };
    itineraryService.generateItinerary(requestBody);
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
