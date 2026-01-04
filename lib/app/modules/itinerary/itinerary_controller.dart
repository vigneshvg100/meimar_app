import 'package:get/get.dart';

class ItineraryController extends GetxController {
  final selectedDay = 0.obs;
  late final Map<String, dynamic> itineraryDataFromApi;
  late final Map<String, dynamic> itineraryData;

  @override
  void onInit() {
    super.onInit();
    // Retrieve data passed from the previous screen via Get.toNamed(..., arguments: data)
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      itineraryDataFromApi = args;
      itineraryData = _getSampleData();
    } else {
      itineraryData = _getSampleData();
    }
  }

  void changeDay(int index) {
    selectedDay.value = index;
  }

  Map<String, dynamic> _getSampleData() {
    return {
      "title": "Trip to Coorg",
      "subtitle": "Personalized Itinerary",
      "dates": "12-13 Oct",
      "spots": 18,
      "image": "https://picsum.photos/seed/coorg/400/300",
      "mapImage": "https://picsum.photos/seed/map/200/200",
      "days": [
        {
          "day": 1,
          "date": "12",
          "planTitle": "Plan for Day 1",
          "activities": [
            {
              "name": "Abbi Waterfall",
              "description":
                  "Iconic vermilion torii gates leading up the wooded mountain.",
              "duration": "2h",
              "time": "09:00 AM - 6:00 PM",
              "image": "https://picsum.photos/seed/waterfall/100/100",
              "type": "sightseeing",
            },
            {
              "name": "Vermillion Cafe",
              "description":
                  "Great espresso and matcha latte with a view of the forest.",
              "duration": "45m",
              "time": "11:15 AM - 5:00 PM",
              "image": "https://picsum.photos/seed/cafe/100/100",
              "type": "food",
            },
          ],
        },
        {
          "day": 2,
          "date": "13",
          "planTitle": "Plan for Day 2",
          "activities": [
            {
              "name": "Dubare Elephant Camp",
              "description": "Riverside camp offering elephant interactions.",
              "duration": "3h",
              "time": "09:00 AM - 12:00 PM",
              "image": "https://picsum.photos/seed/elephant/100/100",
              "type": "adventure",
            },
          ],
        },
        {
          "day": 3,
          "date": "14",
          "planTitle": "Plan for Day 3",
          "activities": [],
        },
        {
          "day": 4,
          "date": "15",
          "planTitle": "Plan for Day 4",
          "activities": [],
        },
      ],
    };
  }
}
