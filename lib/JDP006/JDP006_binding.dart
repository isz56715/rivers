import 'package:get/get.dart';

import 'JDP006_controller.dart';

class JDP006Binding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut(() => JDP006Controller());

  }
}
