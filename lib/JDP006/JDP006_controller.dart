import 'dart:convert';
import 'package:bigdata_frontend_test/JDP006/JDP006_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class JDP006Controller extends GetxController with StateMixin<dynamic> {
  final box = GetStorage();

  late TextEditingController titleform = TextEditingController();
  late TextEditingController contentform = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;
  RxString rivername = ''.obs;

  @override
  void onInit() {
    super.onInit();
    rivername = Get.arguments["rivername"];
    getJDP006();
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
    JDP006Provider().getJDP006(rivername).then((value) {
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  void onTapList(int board_id, String writer, String title, String content,
      String type, int river_type, int starpoint) {
    final result = Get.toNamed("/JDP007", arguments: {
      "board_id": board_id,
      "writer": writer,
      "title": title,
      "content": content,
      "type": type,
      "river_type": river_type,
      "starpoint": starpoint,
      "rivername": rivername,
    })?.then((value) => update());
    if (result != null) {
      // reload();
    }
  }

  // insert
  Future<void> clickButtonInsert(String name, int type,
      String title, String content, String rivername) async {
    Map sample = {
      'name': name,
      'type': type,
      'title': title,
      'content': content,
      'rivername': rivername
    };
    String parms = json.encode(sample);
    print(parms);
    JDP006Provider().boardInsert(parms).then((value) {
      print(value);
      Get.snackbar('성공적으로 작성되었습니다.', '작성완료');
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
    this.getJDP006();
  }
}
