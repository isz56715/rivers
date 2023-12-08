import 'package:bigdata_frontend_test/JDP_log/JDP_log_controller.dart';
import 'package:get/get.dart';


class JDPlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JDPlogController());
  }
}
