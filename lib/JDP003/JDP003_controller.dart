import 'package:bigdata_frontend_test/JDP003/JDP003_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JDP003Controller extends GetxController with StateMixin<dynamic> {
  final box = GetStorage();

  late TextEditingController sampleform1 = TextEditingController();
  late TextEditingController sampleform2 = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;

  @override
  void onInit() async {
    super.onInit();
    await getJDP003();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void onupdate() {
    update();
  }

  // select
  Future<void> getJDP003() async {
    JDP003Provider().getJDP003(box.read('id')).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

   void onTapGraph(String rivername) {
    final result = Get.toNamed("/JDP005", arguments: {
      "rivername": rivername,
    });
    if (result != null) {
      // reload();
    }
  }

  //delete
  Future<void> clickButtonDelete(bdr_id, rivername) async {
    JDP003Provider().bookMarkDelete(bdr_id, rivername).then((value) {
      print(value);
      Get.snackbar('데이터 삭제', '성공');
    }, onError: (erorr) {
      print(erorr);
      Get.defaultDialog(
          title: '오류',
          middleText: '잘못된 접근',
          textConfirm: '확인',
          onConfirm: () {
            Get.back();
          });
    });
    reload();
  }


  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDP003();
  }

  void onTapBookMarkList(int regisnum, String name, int age) {
    final result = Get.toNamed("/IP001e02",
        arguments: {"REGISNUM": regisnum, "PLAYERNAME": name, "AGE": age});
    if (result != null) {
      // reload();
    }
  }
}
