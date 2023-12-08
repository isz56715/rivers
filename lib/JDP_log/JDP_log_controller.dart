import 'package:bigdata_frontend_test/JDP_log/JDP_log_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JDPlogController extends GetxController with StateMixin<dynamic> {

  final box = GetStorage();

  late TextEditingController idform = TextEditingController();
  late TextEditingController passwordform = TextEditingController();
  late TextEditingController birthdayform = TextEditingController();
  late TextEditingController phoneform = TextEditingController();

  List<String> genderList = ['남', '여'];
  String selectedgender = '남';
  String get gendertype => selectedgender;

  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;

  RxString dropdownid = ''.obs;

  RxString rivername = ''.obs;

  @override
  void onInit() async {
    GetStorage.init();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateSelectedOption(String option) {
    selectedgender = option;
    update();
  }

  Future<void> getJDPlog() async {
    await JDPlogProvider().getJDPlog(idform.text, passwordform.text).then(
        (value) {
      dataList.assignAll(value);
      box.write('rivername', dataList[0]['rivername']);
      box.write('id', idform.text);
      box.write('name', dataList[0]['name']);
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  void onLogin() {
    final result = Get.toNamed("/JDP001", arguments: {
    });
    if (result != null) {
    }
  }


  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDPlog();
  }
}