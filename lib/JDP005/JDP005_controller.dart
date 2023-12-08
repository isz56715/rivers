import 'dart:convert';
import 'package:bigdata_frontend_test/JDP005/JDP005_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class JDP005Controller extends GetxController with StateMixin<dynamic> {
  RxList<dynamic> dataList = RxList<dynamic>([]);
  RxString rivername = ''.obs;

  RxList<dynamic> yearmonthList = RxList<dynamic>([]);

  RxList<FlSpot> waterTempList = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData2 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData3 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData4 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData5 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData6 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData7 = RxList<FlSpot>([]);
  RxList<FlSpot> dummyData8 = RxList<FlSpot>([]);

  RxString rivergrade = ''.obs;
  Rx<String> watergrade = Rx<String>('');

  @override
  void onInit() async {
    super.onInit();
    rivername.value = Get.arguments["rivername"];
    await getJDP005();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onupdate() {
    update();
  }

  // select
  Future<void> getJDP005() async {
    dataList.clear();
    await JDP005Provider().getJDP005(rivername).then((value) {
      List<dynamic> parsedJson = json.decode(value);

      // print(parsedJson[0]['연도월']);
      dataList.value = parsedJson;
      if (dataList.isNotEmpty) {
        for (var i = 0; i < dataList.length; i++) {
          yearmonthList.addAll(<String>{dataList[i]['연도월']});
        }
        waterTempList.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['수온']);
        });
        dummyData2.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['수소이온농도']);
        });

        dummyData3.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['용존산소']);
        });
        dummyData4.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['생화학적 산소요구량']);
        });

        dummyData5.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['화학적 산소요구량']);
        });
        dummyData6.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['부유물질']);
        });

        dummyData7.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['총질소']);
        });
        dummyData8.value = List.generate(dataList.length, (index) {
          return FlSpot(index.toDouble(), dataList[index]['총인']);
        });
      }

      rivergrade.value = calgrade(
          dataList[dataList.length - 1]['수소이온농도'],
          dataList[dataList.length - 1]['생화학적 산소요구량'],
          dataList[dataList.length - 1]['화학적 산소요구량'],
          dataList[dataList.length - 1]['부유물질'],
          dataList[dataList.length - 1]['용존산소'],
          dataList[dataList.length - 1]['총인']);

      watergrade(calAgriculturalWater(
          dataList[dataList.length - 1]['수소이온농도'],
          dataList[dataList.length - 1]['생화학적 산소요구량'],
          dataList[dataList.length - 1]['부유물질'],
          dataList[dataList.length - 1]['용존산소'],
          dataList[dataList.length - 1]['총인']));
      change(value, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  String calgrade(
      double pH, double BOD, double COD, double SS, double DO, double TP) {
    if ((pH >= 6.5 || pH <= 8.5) &&
        BOD <= 1 &&
        COD <= 2 &&
        SS <= 25 &&
        DO >= 7.5 &&
        TP <= 0.02) {
      return '매우좋음';
    } else if ((pH >= 6.5 || pH <= 8.5) &&
        BOD <= 2 &&
        COD <= 4 &&
        SS <= 25 &&
        DO >= 5.0 &&
        TP <= 0.04) {
      return '좋음';
    } else if ((pH >= 6.5 || pH <= 8.5) &&
        BOD <= 3 &&
        COD <= 5 &&
        SS <= 25 &&
        DO >= 5.0 &&
        TP <= 0.1) {
      return '약간좋음';
    } else if ((pH >= 6.5 || pH <= 8.5) &&
        BOD <= 5 &&
        COD <= 7 &&
        SS <= 25 &&
        DO >= 5.0 &&
        TP <= 0.2) {
      return '보통';
    } else if ((pH >= 6.0 || pH <= 8.5) &&
        BOD <= 8 &&
        COD <= 9 &&
        SS <= 100 &&
        DO >= 2.0 &&
        TP <= 0.3) {
      return '약간나쁨';
    } else if ((pH >= 6.0 || pH <= 8.5) &&
        BOD <= 10 &&
        COD <= 11 &&
        DO >= 2.0 &&
        TP <= 0.5) {
      return '나쁨';
    } else if (pH < 6.0 ||
        pH > 8.5 ||
        BOD > 10 ||
        COD > 11 ||
        DO < 2.0 ||
        TP > 0.5) {
      return '매우나쁨';
    } else {
      return '측정오류'; 
    }
  }

  String calAgriculturalWater(
      double pH, double BOD, double SS, double DO, double TP) {
    if (pH >= 6.0 &&
        pH <= 8.5 &&
        BOD <= 8 &&
        SS <= 100 &&
        DO >= 2.0 &&
        TP <= 0.3) {
      return "사용 가능";
    } else {
      return "사용 불가능";
    }
  }

  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDP005();
  }

  void onTapMoreBoard() {
    final result = Get.toNamed("/JDP006", arguments: {"rivername": rivername});
    if (result != null) {
      // reload();
    }
  }
}
