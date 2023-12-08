import 'package:get/get.dart';

import 'JDP_main_controller.dart';

class JDPmainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JDPmainController());
  }
}
