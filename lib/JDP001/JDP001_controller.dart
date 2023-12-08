import 'dart:convert';
import 'package:bigdata_frontend_test/JDP001/JDP001_provider.dart';
import 'package:bigdata_frontend_test/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class JDP001Controller extends GetxController with StateMixin<dynamic> {
  final box = GetStorage();

  late TextEditingController sampleform1 = TextEditingController();
  late TextEditingController sampleform2 = TextEditingController();
  Map<String, String> aplayerlist = Map<String, String>();
  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;
  List<River> rivers = [];

  DateTime today = DateTime.now();
  RxString today2 = ''.obs;
  RxString rtime = ''.obs;

  RxString printToday = ''.obs;
  RxString rivername = ''.obs;

  DateTime timezone = DateTime.now().add(const Duration(hours: -1));

  RxDouble clon = 0.0.obs; //현재 경도
  RxDouble clat = 0.0.obs; //현재 위도

  RxList<dynamic> chartData = RxList<dynamic>([]);

  @override
  void onInit() async {
    print(box.read('rivername'));
    print(box.read('id'));
    print(box.read('name'));


    super.onInit();
    await getJDP001();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getJDP001() async {
    rivers.clear();

    DateFormat formatter2 = DateFormat('HH00');

    var strtime = formatter2.format(timezone);
    rtime.value = strtime;

    DateFormat formatter = DateFormat('yyyyMMdd');
    if (rtime.value == '2300') {
      DateTime today = DateTime.now().add(const Duration(days: -1));
      var strday2 = formatter.format(today);
      today2.value = strday2;
      DateFormat formatter3 = DateFormat('yy년MM월dd일HH시');
      var strprint = formatter3.format(today);
      printToday.value = strprint;
    } else {
      DateTime today = DateTime.now();
      var strday2 = formatter.format(today);
      today2.value = strday2;
      DateFormat formatter3 = DateFormat('yy년MM월dd일HH시');
      var strprint = formatter3.format(today);
      printToday.value = strprint;
    }

    Position position = await LocationRepository().getCurrentLocation();
    clon.value = position.longitude;
    clat.value = position.latitude;

    JDP001Provider().getJDP001(box.read('rivername')).then((value) {
      try {
        List<dynamic> parsedJson = json.decode(value);

        parsedJson.forEach((e) {
          final river = River.fromJson(e);
          final km = const Distance().as(LengthUnit.Kilometer,
              LatLng(river.lon!, river.lat!), LatLng(clat.value, clon.value));
          river.km = km;
          rivers.add(river);
        });
        rivers.sort((a, b) => a.km!.compareTo(b.km!));
      } catch (e) {
        print('JSON 파싱 오류: $e');
      }
      // 날씨 가져오기
      JDP001Provider()
          .fetchData(today2, rtime, rivers[0].x, rivers[0].y)
          .then((value2) {
        dataList.value = [rivers, value2];
        print(dataList[0]);
        print(dataList[1]);
        chartData.value = [
          ChartData([
            ChartDataPoint('X', dataList[0][0].waterTemp?.toDouble()),
            ChartDataPoint('Y', dataList[0][0].waterTemp?.toDouble())
          ], '수온'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].hydrogen / 10.toDouble()),
            ChartDataPoint('Y', (1.5 - dataList[0][0].hydrogen / 10).toDouble())
          ], '수소이온농도'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].oxygen / 10.toDouble()),
            ChartDataPoint('Y', (2.5 - dataList[0][0].oxygen / 10).toDouble())
          ], '용존산소'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].matter / 10.toDouble()),
            ChartDataPoint('Y', (20 - dataList[0][0].matter / 10).toDouble())
          ], '부유물질'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].bioOxygen / 10.toDouble()),
            ChartDataPoint(
                'Y', (5.5 - dataList[0][0].bioOxygen / 10).toDouble())
          ], '생화학적 산소요구량'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].chemicalOxygen / 10.toDouble()),
            ChartDataPoint(
                'Y', (5.5 - dataList[0][0].chemicalOxygen / 10).toDouble())
          ], '화학적 산소요구량'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].nitrogen / 10.toDouble()),
            ChartDataPoint('Y', (2.5 - dataList[0][0].nitrogen / 10).toDouble())
          ], '총질소'),
          ChartData([
            ChartDataPoint('X', dataList[0][0].phosphorus.toDouble()),
            ChartDataPoint('Y', (1.5 - dataList[0][0].phosphorus).toDouble())
          ], '총인'),
        ];
        change(dataList, status: RxStatus.success());
      });

      print(today2);
      print(rtime);
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  void launchURL() async {
    final url = Uri.parse(
        'https://google.co.kr/maps/place/${rivers[0].lat.toString()},${rivers[0].lon.toString()}/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onTapGraph(String rivername) {
    final result = Get.toNamed("/JDP005", arguments: {
      "rivername": rivername,
    });
    if (result != null) {
      // reload();
    }
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
      return '측정오류'; // 등급을 결정할 수 없는 경우
    }
  }

  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.getJDP001();
  }
}
//   void fetchData() {
//     JDPmainProvider().fetchData().then((value) {
//       if (value.length > 0) {
//         aplayerlist.clear();
//         List<dynamic> items = value['response']['body']['items']['item'];

//         for (var item in items) {
//           String category = item['category'];
//           String obsrValue = item['obsrValue'];

//           aplayerlist.addAll(<String, String>{category: obsrValue});
//         }
//       }
//       JDPmainProvider().getJDPmain().then((value2) {
//         dataList.value = [aplayerlist, value2];
//         print(dataList[0]);
//       });
//     }, onError: (erorr) {
//       change(null, status: RxStatus.error(erorr.toString()));
//     });
//   }

class ChartDataPoint {
  ChartDataPoint(this.category, this.value);

  final String category;
  final double? value;
}

class ChartData {
  ChartData(this.data, this.description);

  final List<ChartDataPoint> data;
  final String description;
}
