import 'package:get/get.dart';
import 'spot_controller.dart';

class SpotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotController>(() => SpotController());
  }
}
