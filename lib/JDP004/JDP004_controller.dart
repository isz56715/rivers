import 'package:bigdata_frontend_test/JDP004/JDP004_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class JDP004Controller extends GetxController with StateMixin<dynamic> {
  final box = GetStorage();

  late TextEditingController sampleform1 = TextEditingController();
  late TextEditingController sampleform2 = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getJDP004e01();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onupdate() {
    update();
  }

  // select
  void getJDP004e01() {
    JDP004Provider().getJDP004(box.read('id')).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }


  Future<void> logoutUser() async {
    await Get.deleteAll(force: true); //deleting all controllers
    Get.reset(); // resetting getx
    box.remove('rivername');
    box.remove('id');
    Get.offNamed('/JDP_log');
  }

  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDP004e01();
  }

  void onTapPlayerList(int regisnum, String name, int age) {
    final result = Get.toNamed("/IP001e02",
        arguments: {"REGISNUM": regisnum, "PLAYERNAME": name, "AGE": age});
    if (result != null) {
      // reload();
    }
  }
}
