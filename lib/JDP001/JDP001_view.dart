import 'package:bigdata_frontend_test/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../common/defalt_layout.dart';
import 'JDP001_controller.dart';

class JDP001View extends GetView<JDP001Controller> {
  const JDP001View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JDP001Controller());
    return Scaffold(
      body: DefaultLayout(
          child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [mainTitle(context), mainchart(context)],
          ),
        ),
      )),
    );
  }

  Widget mainTitle(BuildContext context) {
    return controller.obx((data) => Card(
          color: SECONDARY_COLOR,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'asset/img/rivers.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      Container(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          () {
                            if (controller.box.read('rivername') == 'normal') {
                              return Text(
                                "가까운 하천 등급 : ${controller.calgrade(controller.dataList[0][0].hydrogen, controller.dataList[0][0].bioOxygen, controller.dataList[0][0].chemicalOxygen, controller.dataList[0][0].matter, controller.dataList[0][0].oxygen, controller.dataList[0][0].phosphorus)}",
                                style: TextStyle(fontSize: 30),
                              );
                            } else {
                              return Text(
                                "관리중인 하천 등급 : ${controller.calgrade(controller.dataList[0][0].hydrogen, controller.dataList[0][0].bioOxygen, controller.dataList[0][0].chemicalOxygen, controller.dataList[0][0].matter, controller.dataList[0][0].oxygen, controller.dataList[0][0].phosphorus)}",
                                style: TextStyle(fontSize: 30),
                              );
                            }
                          }(),
                          Container(height: 5),
                          Text(
                            "하천 이름 : ${controller.rivers[0].rivername}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(height: 10),
                          Text(
                            '주소 : ${controller.rivers[0].city!} ${controller.rivers[0].county!} ${controller.rivers[0].town!} ${controller.rivers[0].dong ?? ''}',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Container(height: 5),
                          Text(
                            "거리 : ${controller.rivers[0].km!.toInt()}km",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget mainchart(BuildContext context) {
    const ko = 'ko';
    return controller.obx(
      (data) => Card(
        color: SECONDARY_COLOR,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: [
                                  Text(
                                    '${controller.printToday.toString()} 날씨',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Image.asset(
                                    'asset/img/${controller.dataList[1]['response']['body']['items']['item'][0]['obsrValue']}.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Container(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "습도 : ${controller.dataList[1]['response']['body']['items']['item'][1]['obsrValue']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Container(height: 10),
                                  Text(
                                    '강수량 : ${controller.dataList[1]['response']['body']['items']['item'][2]['obsrValue']}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Container(height: 5),
                                  Text(
                                    "기온 : ${controller.dataList[1]['response']['body']['items']['item'][3]['obsrValue']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (() {
                  if (ko == 'ko') {
                    return Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            const Text(
                              '하천 정보',
                              style: TextStyle(fontSize: 25),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.onTapGraph(
                                    controller.rivers[0].rivername!);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              child: const Text(
                                "자세히",
                                style: TextStyle(
                                    color: PRIMARY_TEXT_COLOR, fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.launchURL(
                                    // controller.rivers[0].lat.toString(),
                                    // controller.rivers[0].lon.toString()
                                    );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              child: const Text(
                                "지도",
                                style: TextStyle(
                                    color: PRIMARY_TEXT_COLOR, fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Text('');
                  }
                })(),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Expanded(
                  child: Center(
                child: Text(
                  '${controller.rivers[0].year}년 ${controller.rivers[0].month}월 기준 수질데이터 | 수온 ${controller.rivers[0].waterTemp} ℃',
                  style: TextStyle(fontSize: 30),
                ),
              )),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Expanded(
                  child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.circle,
                            size: 25,
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(
                          text: " 3단계 통과 ",
                        ),
                      ], style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    RichText(
                      text: const TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.circle,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: " 수치 이상 ",
                        ),
                      ], style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ],
                ),
              )),
            ),
            SizedBox(
                height: 610,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(), // 스크롤 방지
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[1].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].hydrogen.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: (controller.dataList[0][0].oxygen >=
                                              6.5 &&
                                          controller.dataList[0][0].oxygen <=
                                              8.5)
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[1].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[2].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].oxygen.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: controller.dataList[0][0].matter >= 5
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[2].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[3].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].matter.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: controller.dataList[0][0].matter <= 25
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[3].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[4].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].bioOxygen.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      controller.dataList[0][0].bioOxygen <= 3
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[4].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[5].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].chemicalOxygen
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      controller.dataList[0][0].bioOxygen <= 5
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[5].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDataPoint, String>(
                                  dataSource: controller.chartData[7].data,
                                  xValueMapper: (ChartDataPoint data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDataPoint data, _) =>
                                      data.value,
                                  pointColorMapper: (ChartDataPoint data, _) {
                                    if (data.category == 'X') {
                                      return PRIMARY_COLOR; // 첫 번째 값의 색상
                                    } else if (data.category == 'Y') {
                                      return Colors.blueGrey[200]; // 두 번째 값의 색상
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                controller.dataList[0][0].phosphorus.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      controller.dataList[0][0].bioOxygen <= 0.1
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                              Text(
                                controller.chartData[7].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget mainTitl2e(BuildContext context) {
    const ko = 'ko';
    return Container(
      child: (() {
        if (ko == 'ko') {
          return const Text('안녕하세요');
        } else {
          return const Text('Hello');
        }
      })(),
    );
  }
}
