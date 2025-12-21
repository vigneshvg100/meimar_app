import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/plan_trip_form/plantrip_form_binding.dart';
import '../modules/plan_trip_form/plantrip_form_view.dart';

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
  ];
}
