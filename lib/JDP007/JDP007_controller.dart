import 'dart:convert';
import 'package:bigdata_frontend_test/JDP007/JDP007_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JDP007Controller extends GetxController with StateMixin<dynamic> {
  final box = GetStorage();

  late TextEditingController titleform = TextEditingController();
  late TextEditingController contentform = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;
  RxInt board_id = 0.obs;
  RxString writer = ''.obs;
  RxString title = ''.obs;
  RxString content = ''.obs;
  RxString type = ''.obs;
  RxInt river_type = 0.obs;
  RxString rivername = ''.obs;
  RxInt starpoint = 0.obs;

  @override
  void onInit() {
    super.onInit();
    board_id.value = Get.arguments["board_id"];
    writer.value = Get.arguments["writer"];
    title.value = Get.arguments["title"];
    content.value = Get.arguments["content"];
    type.value = Get.arguments["type"];
    river_type.value = Get.arguments["river_type"];
    starpoint.value = Get.arguments["starpoint"];
    rivername = Get.arguments["rivername"];
    print(rivername);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onupdate() {
    update();
  }

  // select
  void getJDP006() {
    JDP007Provider().getJDP006().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  //delete
  Future<void> clickButtonDelete(int board_id, int river_type) async {
    JDP007Provider().boardDelete(board_id, river_type).then((value) {
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

  // update
  Future<void> starUpdate(int board_id, int river_type, int starpoint) async {
    Map sample = {
      'Utype': 0,
      'board_id': board_id,
      'river_type': river_type,
      'starpoint': starpoint
    };
    String parms = json.encode(sample);

    print(parms);

    JDP007Provider().starUpdate(parms).then((value) {
      print(value);
    }, onError: (erorr) {
      print(erorr);
    }).then((value) => update());
    ;

    reload();
  }

  Future<void> boardUpdate(
      int board_id, int river_type, String title, String content) async {
    Map sample = {
      'Utype': 1,
      'title': title,
      'content': content,
      'board_id': board_id,
      'river_type': river_type,
    };
    String parms = json.encode(sample);

    print(parms);

    JDP007Provider().starUpdate(parms).then((value) {
      print(value);
      Get.snackbar('데이터 수정', '성공');
    }, onError: (erorr) {
      print(erorr);
      Get.defaultDialog(
          title: '오류',
          middleText: '잘못된 접근',
          textConfirm: '확인',
          onConfirm: () {
            Get.back();
          });
    }).then((value) => update());

    reload();
  }

  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDP006();
  }
}
