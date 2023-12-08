import 'dart:convert';
import 'package:bigdata_frontend_test/JDP002/JDP002_provider.dart';
import 'package:bigdata_frontend_test/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';

class JDP002Controller extends GetxController with StateMixin<dynamic> {
  late TextEditingController searchform = TextEditingController();
  late TextEditingController sampleform2 = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;
  List<River> rivers = [];
  List<River> rivers2 = [];
  final box = GetStorage();

  RxDouble clon = 0.0.obs; //현재 경도
  RxDouble clat = 0.0.obs; //현재 위도

  @override
  void onInit() {
    super.onInit();
    getJDP002e01();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onupdate() {
    update();
  }

  // select
  void getJDP002e01() async { 
    rivers.clear();
    Position position = await LocationRepository().getCurrentLocation();
    clon.value = position.longitude;
    clat.value = position.latitude;

    JDP002Provider().getJDP002().then((value) {
      try {
        List<dynamic> parsedJson = json.decode(value);

        parsedJson.forEach((e) {
          final river = River.fromJson(e);
          final km = const Distance().as(LengthUnit.Kilometer,
              LatLng(river.lon!, river.lat!), LatLng(clat.value, clon.value));
          river.km = km;
          rivers.add(river);
          rivers2.add(river);
        });
        rivers.sort((a, b) => a.km!.compareTo(b.km!));
      } catch (e) {
        print('JSON 파싱 오류: $e');
      }
      change(rivers, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  void filterRivers() {
    List<River> filteredRivers = [];
    rivers = rivers2;
    if (searchform.text.isNotEmpty) {
      for (var river in rivers) {
        if (river.city?.contains(searchform.text) == true ||
            river.county?.contains(searchform.text) == true ||
            river.town?.contains(searchform.text) == true ||
            river.dong?.contains(searchform.text) == true ||
            river.rivername?.contains(searchform.text) == true) {
          filteredRivers.add(river);
        }
      }
    } else {
      reload();
    }

    rivers = filteredRivers;
    update();
  }

  //delete
  Future<void> clickButtonDelete(regisnum) async {
    JDP002Provider().setIP001e01Delete(regisnum).then((value) {
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

  // insert
  Future<void> clickButtonInsert(
    String id, String rivernum, String riveradd) async {
    Map sample = {'id': id, 'rivernum': rivernum, 'riveradd': riveradd};
    String parms = json.encode(sample);
    print(parms);
    JDP002Provider().bookmarkInsert(parms).then((value) {
      print(value);
      Get.snackbar('북마크가 등록되었습니다.', '성공');
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
    this.getJDP002e01();
  }

  void onTapGraph(String rivername) {
    final result = Get.toNamed("/JDP005", arguments: {
      "rivername": rivername,
    });
    if (result != null) {
      // reload();
    }
  }
}
