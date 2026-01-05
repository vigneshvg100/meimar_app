import 'package:get/get.dart';

class ItineraryController extends GetxController {
  final selectedDay = 0.obs;
  late final Map<String, dynamic> itineraryDataFromApi;
  late final Map<String, dynamic> itineraryData;
  late final Map<String, dynamic> inputMeta;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    print("ItineraryController.onInit triggered with args: $args");

    // Robustly handle different states of navigation arguments
    if (args is List && args.length >= 2) {
      inputMeta = args[0] is Map<String, dynamic> ? args[0] : _getDefaultMeta();
      itineraryDataFromApi = args[1] is Map<String, dynamic> ? args[1] : {};
      // Prioritize API data if available, otherwise use New Sample Data
      itineraryData = itineraryDataFromApi.isNotEmpty
          ? itineraryDataFromApi
          : _getSampleData1();
    } else if (args is List && args.length >= 1) {
      inputMeta = args[0] is Map<String, dynamic> ? args[0] : _getDefaultMeta();
      itineraryDataFromApi = {};
      itineraryData = _getSampleData1();
    } else {
      inputMeta = _getDefaultMeta();
      itineraryDataFromApi = {};
      itineraryData = _getSampleData1();
    }
  }

  Map<String, dynamic> _getDefaultMeta() {
    return {
      "city": "Unknown City",
      "dateText": "TBD",
      "noOfDays": 3,
      "companion": "Personal",
    };
  }

  void changeDay(int index) {
    selectedDay.value = index;
  }

  Map<String, dynamic> _getSampleData1() {
    return {
      "city": "Kanyakumari",
      "additionalPlaces": [
        {
          "S.No": 21,
          "address": "Chittar Dam – 2",
          "category": ["establishment", "natural_feature"],
          "distance_meters": 5704.24631316,
          "estimated_duration": 153,
          "latitude": 8.4430424,
          "longitude": 77.2534469,
          "opening_hours": null,
          "phone_number": null,
          "rating": 4.4,
          "resolved_name": "Chittar Dam – 2",
          "spot_id": "ChIJex0Idn5SBDsRZRbYAbtWckc",
          "spot_name": "chittar dam",
          "user_ratings_total": 505,
          "website": null,
        },
        {
          "S.No": 20,
          "address": "Pechiparai Reservoir, Tamil Nadu",
          "category": ["establishment", "natural_feature"],
          "distance_meters": 9589.31343991,
          "estimated_duration": 62,
          "latitude": 8.4545617,
          "longitude": 77.3180836,
          "opening_hours": null,
          "phone_number": null,
          "rating": 4.4,
          "resolved_name": "Pechiparai Reservoir",
          "spot_id": "ChIJQ4KUuzpOBDsRLmRav63BP5o",
          "spot_name": "pechiparai dam",
          "user_ratings_total": 795,
          "website": null,
        },
        {
          "S.No": 15,
          "address": "C97R+7QJ, Veerapuli R.F., Tamil Nadu 629851, India",
          "category": [
            "establishment",
            "point_of_interest",
            "tourist_attraction",
          ],
          "distance_meters": 14923.13010915,
          "estimated_duration": 120,
          "latitude": 8.4132072,
          "longitude": 77.39190099999999,
          "opening_hours":
              "Monday: 9:00 AM – 3:00 PM\nTuesday: 9:00 AM – 3:00 PM\nWednesday: 9:00 AM – 3:00 PM\nThursday: 9:00 AM – 3:00 PM\nFriday: 9:00 AM – 3:00 PM\nSaturday: 9:00 AM – 3:00 PM\nSunday: 9:00 AM – 3:00 PM",
          "phone_number": "1800 4253 1111",
          "rating": 4.5,
          "resolved_name": "Kaalikesam Waterfalls",
          "spot_id": "ChIJb9jvWYhaBDsRr24kn7muMxU",
          "spot_name": "kalikesam falls",
          "user_ratings_total": 1068,
          "website": null,
        },
        {
          "S.No": 17,
          "address":
              "Perunchani Dam, Ponmanai Perunchani Dam Rd, Veerapuli R.F., Tamil Nadu 629161, India",
          "category": ["premise", "street_address"],
          "distance_meters": 11413.87408156,
          "estimated_duration": 209,
          "latitude": 8.364160499999999,
          "longitude": 77.35801479999999,
          "opening_hours": null,
          "phone_number": null,
          "rating": null,
          "resolved_name": "Perunchani Dam",
          "spot_id": "ChIJhbHwVkpXBDsRlrNMqo4JyMs",
          "spot_name": "perunchunai dam",
          "user_ratings_total": null,
          "website": null,
        },
        {
          "S.No": 16,
          "address": "983J+QJ8, Ponmanai, Tamil Nadu 629161, India",
          "category": [
            "establishment",
            "hindu_temple",
            "place_of_worship",
            "point_of_interest",
          ],
          "distance_meters": 9079.61504288,
          "estimated_duration": 244,
          "latitude": 8.3544067,
          "longitude": 77.3315866,
          "opening_hours":
              "Monday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nTuesday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nWednesday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nThursday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nFriday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nSaturday: 5:30 – 9:30 AM, 5:00 – 7:30 PM\nSunday: 5:30 – 9:30 AM, 5:00 – 7:30 PM",
          "phone_number": "094878 49955",
          "rating": 4.8,
          "resolved_name":
              "Shivalayam 05 - Ponmanai Arulmigu Thimbileshwarar Mahadevar Temple",
          "spot_id": "ChIJre7jEthWBDsRqtfkvNfOTDI",
          "spot_name": "ponmani sri theembilesvarar temple",
          "user_ratings_total": 92,
          "website": null,
        },
        {
          "S.No": 24,
          "address": "Manalikarai, Tamil Nadu 629177, India",
          "category": [
            "establishment",
            "park",
            "point_of_interest",
            "tourist_attraction",
          ],
          "distance_meters": 7347.98589847,
          "estimated_duration": 167,
          "latitude": 8.3361202,
          "longitude": 77.2947202,
          "opening_hours":
              "Monday: 6:00 AM – 7:00 PM\nTuesday: 6:00 AM – 7:00 PM\nWednesday: 6:00 AM – 7:00 PM\nThursday: 6:00 AM – 7:00 PM\nFriday: 6:00 AM – 7:00 PM\nSaturday: 6:00 AM – 7:00 PM\nSunday: 6:00 AM – 7:00 PM",
          "phone_number": null,
          "rating": 4.5,
          "resolved_name": "Mathoor Aqueduct",
          "spot_id": "ChIJA2tbqZtWBDsRle5OJnv-sRM",
          "spot_name": "mathur aqueduct",
          "user_ratings_total": 10530,
          "website": null,
        },
        {
          "S.No": 28,
          "address":
              "75PF+CV5, Thirumala Temple Rd, Angavilai, Munchirai, Tamil Nadu 629171, India",
          "category": [
            "establishment",
            "hindu_temple",
            "place_of_worship",
            "point_of_interest",
          ],
          "distance_meters": 14865.96661747,
          "estimated_duration": 243,
          "latitude": 8.286000699999999,
          "longitude": 77.1747335,
          "opening_hours":
              "Monday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nTuesday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nWednesday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nThursday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nFriday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nSaturday: 5:00 – 11:30 AM, 5:00 – 8:00 PM\nSunday: 5:00 – 11:30 AM, 5:00 – 8:00 PM",
          "phone_number": null,
          "rating": 4.7,
          "resolved_name": "Shivalayam 01 - Thirumala Mahadevar Temple",
          "spot_id": "ChIJ9YBtLKOqBTsR7qXWAr58MtA",
          "spot_name": "thirumalai mahadevar temple",
          "user_ratings_total": 253,
          "website": null,
        },
      ],
      "suggestedPackage": {
        "day1": [
          {
            "S.No": 19,
            "address": "97XX+C3V, Thirunanthikarai, Tamil Nadu 629161, India",
            "category": [
              "establishment",
              "hindu_temple",
              "place_of_worship",
              "point_of_interest",
            ],
            "distance_meters": 4420.77837458,
            "estimated_duration": 62,
            "latitude": 8.398615,
            "longitude": 77.29766599999999,
            "opening_hours": null,
            "phone_number": "098408 15572",
            "rating": 4.7,
            "resolved_name": "Thirunanthikarai Kudaivarai Kovil",
            "spot_id": "ChIJf-Mj9ytRBDsRnrzGrcceW3M",
            "spot_name": "thirunandhikarai cave temple",
            "user_ratings_total": 31,
            "website": null,
          },
          {
            "S.No": 23,
            "address": "97R5+RW7, Thirparappu, Tamil Nadu 629161, India",
            "category": [
              "establishment",
              "hindu_temple",
              "place_of_worship",
              "point_of_interest",
              "tourist_attraction",
            ],
            "distance_meters": 187.92672907,
            "estimated_duration": 275,
            "latitude": 8.3920286,
            "longitude": 77.25980489999999,
            "opening_hours":
                "Monday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nTuesday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nWednesday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nThursday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nFriday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nSaturday: 5:00 – 11:30 AM, 5:59 – 7:30 PM\nSunday: 5:00 – 11:30 AM, 5:59 – 7:30 PM",
            "phone_number": "04652 241 270",
            "rating": 4.6,
            "resolved_name":
                "Shivalayam 03 - Thirparappu Arulmigu Mahadevar Temple (Sri Jadadharan)",
            "spot_id": "ChIJX-CaPLlTBDsRsNRPNyuSvZ4",
            "spot_name": "thirparappu mahadevar temple",
            "user_ratings_total": 281,
            "website": "https://490kdbtemples.org/",
          },
          {
            "S.No": 22,
            "address":
                "97W6+5WV Water Falls, Thirparappu, Tamil Nadu 629161, India",
            "category": [
              "establishment",
              "point_of_interest",
              "tourist_attraction",
            ],
            "distance_meters": 147.25630831,
            "estimated_duration": 145,
            "latitude": 8.3913417,
            "longitude": 77.25942909999999,
            "opening_hours":
                "Monday: 7:00 AM – 6:00 PM\nTuesday: 7:00 AM – 6:00 PM\nWednesday: 7:00 AM – 6:00 PM\nThursday: 7:00 AM – 6:00 PM\nFriday: 7:00 AM – 6:00 PM\nSaturday: 7:00 AM – 6:00 PM\nSunday: 7:00 AM – 6:00 PM",
            "phone_number": null,
            "rating": 4.5,
            "resolved_name": "Thirparappu Waterfalls",
            "spot_id": "ChIJUb6phCFTBDsRv-xVzCDkogU",
            "spot_name": "thirparappu waterfalls",
            "user_ratings_total": 14853,
            "website": null,
          },
        ],
        "day2": [
          {
            "S.No": 26,
            "address": "868V+5CG, Thickurichy, Tamil Nadu 629168, India",
            "category": [
              "establishment",
              "hindu_temple",
              "place_of_worship",
              "point_of_interest",
            ],
            "distance_meters": 8582.07074225,
            "estimated_duration": 96,
            "latitude": 8.3154498,
            "longitude": 77.2435631,
            "opening_hours":
                "Monday: 5:00 PM – 9:00 AM\nTuesday: 5:00 PM – 9:00 AM\nWednesday: 5:00 PM – 9:00 AM\nThursday: 5:00 PM – 9:00 AM\nFriday: 5:00 PM – 9:00 AM\nSaturday: 5:00 PM – 9:00 AM\nSunday: 5:00 PM – 9:00 AM",
            "phone_number": null,
            "rating": 4.7,
            "resolved_name": "Thickurishy Sri Mahadevar Temple",
            "spot_id": "ChIJc9-41atVBDsRF3nOxtva7iA",
            "spot_name": "thickurichy mahadevar temple",
            "user_ratings_total": 279,
            "website": null,
          },
          {
            "S.No": 27,
            "address": "86JQ+W9V, Vellamcode, Tamil Nadu 629151, India",
            "category": [
              "establishment",
              "place_of_worship",
              "point_of_interest",
            ],
            "distance_meters": 6910.66683904,
            "estimated_duration": 261,
            "latitude": 8.3323585,
            "longitude": 77.2384187,
            "opening_hours":
                "Monday: 8:00 AM – 4:00 PM\nTuesday: 8:00 AM – 4:00 PM\nWednesday: 8:00 AM – 4:00 PM\nThursday: 8:00 AM – 4:00 PM\nFriday: 8:00 AM – 4:00 PM\nSaturday: 8:00 AM – 4:00 PM\nSunday: 8:00 AM – 4:00 PM",
            "phone_number": null,
            "rating": 4.6,
            "resolved_name": "Chitharal Jain Temple ( Malaikovil)",
            "spot_id": "ChIJw_d1l_dUBDsRMs0uhy5atYY",
            "spot_name": "chitharal rock jain temple",
            "user_ratings_total": 3190,
            "website": null,
          },
          {
            "S.No": 25,
            "address":
                "Temple Road Kalkulam, Taluk, Kulasekharam, Thiruvattaru, Tamil Nadu 629171, India",
            "category": [
              "establishment",
              "hindu_temple",
              "place_of_worship",
              "point_of_interest",
              "tourist_attraction",
            ],
            "distance_meters": 6908.52149623,
            "estimated_duration": 102,
            "latitude": 8.3297154,
            "longitude": 77.2660786,
            "opening_hours":
                "Monday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nTuesday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nWednesday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nThursday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nFriday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nSaturday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM\nSunday: 5:00 AM – 12:00 PM, 5:00 – 8:00 PM",
            "phone_number": "094425 77047",
            "rating": 4.8,
            "resolved_name": "Sree Adi Kesava Perumal Temple",
            "spot_id": "ChIJrTn3qzdUBDsRA1xrByPkPyo",
            "spot_name": "thiruvattaru adikeshava temple",
            "user_ratings_total": 3910,
            "website": null,
          },
        ],
      },
    };
  }
}
