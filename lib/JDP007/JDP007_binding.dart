import 'package:get/get.dart';

import 'JDP007_controller.dart';

class JDP007Binding extends Bindings {
  @override
  void dependencies() {
        Get.lazyPut(() => JDP007Controller());

  }
}
