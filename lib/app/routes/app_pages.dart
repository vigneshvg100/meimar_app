import 'package:get/get.dart';
import 'package:meimar_app/app/shared_modules/others/generating_loader.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/plan_trip_form/plantrip_form_binding.dart';
import '../modules/plan_trip_form/plantrip_form_view.dart';
import '../modules/itinerary/itinerary_binding.dart';
import '../modules/itinerary/itinerary_view.dart';
import '../modules/spot/spot_binding.dart';
import '../modules/spot/spot_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.PLAN_TRIP_FORM,
      page: () => PlanTripForm(),
      binding: PlanTripFormBinding(),
    ),
    GetPage(
      name: _Paths.GENERATING_LOADER,
      page: () => GeneratingItineraryPage(),
    ),
    GetPage(
      name: _Paths.ITINERARY,
      page: () => ItineraryView(),
      binding: ItineraryBinding(),
    ),
    GetPage(name: _Paths.SPOT, page: () => SpotView(), binding: SpotBinding()),
  ];
}
