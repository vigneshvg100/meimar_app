import 'package:get/get.dart';
import 'package:meimar_app/app/modules/plan_trip_form/plantrip_form_controller.dart';

class PlanTripFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlantripFormController());
  }
}
