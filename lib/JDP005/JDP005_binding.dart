import 'package:get/get.dart';

import 'JDP005_controller.dart';

class JDP005Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JDP005Controller());
  }
}
