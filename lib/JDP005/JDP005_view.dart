import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/common.dart';
import 'JDP005_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class JDP005view extends GetView<JDP005Controller> {
  JDP005view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultLayout2(
          title: '하천 관리',
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                child: Column(
                  children: [
                    noticepage(context),
                    gradepage(context),
                    mychart(context),
                    mychart2(context),
                    mychart3(context),
                    mychart4(context)
                  ],
                ),
              ))),
    );
  }

  Widget noticepage(BuildContext context) {
    return Card(
      color: SECONDARY_COLOR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${controller.rivername} 커뮤니티',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                InkWell(
                    onTap: () {
                      controller.onTapMoreBoard();
                    },
                    child: const Text(
                      '더보기',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.right,
                    )),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(), // 스크롤 방지
            shrinkWrap: true,
            itemCount: 1,

            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text(
                    '공지',
                    style: TextStyle(
                      fontSize: 25,
                      color: '공지' == '공지' ? Colors.red : Colors.black,
                    ),
                  ),
                  title: Text('테스트데이터',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  trailing: Text('작성자',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget gradepage(BuildContext context) {
    return controller.obx((data) => Card(
        color: SECONDARY_COLOR,
        child: Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text('1등급 하천수 기준'),
                              content: riverContainer());
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            const Text(
                              '하천수 등급',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  controller.rivergrade.toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text('농업용수 사용 기준'),
                              content: agriculturalWaterContainer());
                        });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            const Text(
                              '농업용수',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
                                child: Text(
                                  controller.watergrade.value.toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  Widget mychart(BuildContext context) {
    return controller.obx((data) => ListView.builder(
          physics: NeverScrollableScrollPhysics(), // 스크롤 방지
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: _bottomTitles(),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.waterTempList,
                              isCurved: true,
                              barWidth: 3,
                              color: Colors.red,
                            ),
                            LineChartBarData(
                              spots: controller.dummyData3,
                              isCurved: false,
                              barWidth: 3,
                              color: Colors.indigo,
                            ),
                            LineChartBarData(
                              spots: controller.dummyData4,
                              isCurved: true,
                              barWidth: 3,
                              color: Colors.green,
                            ),
                            LineChartBarData(
                              spots: controller.dummyData5,
                              isCurved: true,
                              barWidth: 3,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.red,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " 수온 ",
                                    ),
                                  ],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " 용존산소 ",
                                    ),
                                  ],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.green,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " 생화학적 산소요구량 ",
                                    ),
                                  ],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                            ),
                            RichText(
                              text: const TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " 화학적 산소요구량 ",
                                    ),
                                  ],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget mychart2(BuildContext context) {
    return controller.obx((data) => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: _bottomTitles(),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.dummyData6,
                              isCurved: false,
                              barWidth: 3,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      '부유물질',
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget mychart3(BuildContext context) {
    return controller.obx((data) => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: _bottomTitles(),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.dummyData8,
                              isCurved: false,
                              barWidth: 3,
                              color: Colors.indigo,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      '총인',
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget mychart4(BuildContext context) {
    return controller.obx((data) => ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: _bottomTitles(),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: controller.dummyData2,
                              isCurved: false,
                              barWidth: 3,
                              color: Colors.orange,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      '수소이온농도',
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        if (value >= 0 && value < controller.yearmonthList.length) {
          return Text(
            controller.yearmonthList[value.toInt()],
            style: TextStyle(fontSize: 20),
          );
        }
        return const Text('');
      },
    );
  }

  Widget riverContainer() {
    final double pH =
        controller.dataList[controller.dataList.length - 1]['수소이온농도'];
    final double BOD =
        controller.dataList[controller.dataList.length - 1]['생화학적 산소요구량'];
    final double SS =
        controller.dataList[controller.dataList.length - 1]['부유물질'];
    final double DO =
        controller.dataList[controller.dataList.length - 1]['용존산소'];
    final double TP = controller.dataList[controller.dataList.length - 1]['총인'];

    const double pHStandardMin = 6.5;
    const double pHStandardMax = 8.5;
    const double BODStandardMax = 1.0;
    const double SSStandardMax = 25.0;
    const double DOStandardMin = 7.5;
    const double TPStandardMax = 0.02;

    return SingleChildScrollView(
      child: Container(
        height: 470.0,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              '수소이온농도 (pH):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '${pHStandardMin}~${pHStandardMax} 대비 ${pH} (${pH >= pHStandardMin && pH <= pHStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '생물화학적 산소요구량 (BOD, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '1 이하 대비 ${BOD} (${BOD <= BODStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '화학적 산소요구량 (TOC, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '2 이하 대비 ${controller.dataList[controller.dataList.length - 1]['화학적 산소요구량']} (${controller.dataList[controller.dataList.length - 1]['화학적 산소요구량'] <= 2.0 ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '부유물질량 (SS, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '25 이하 대비 ${SS} (${SS <= SSStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '용존산소량 (DO, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '7.5 이상 대비 ${DO} (${DO >= DOStandardMin ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '총인 (T-P, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '0.02 이하 대비 ${TP} (${TP <= TPStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  child: const Text(
                    '닫기',
                    style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget agriculturalWaterContainer() {
    final double pH =
        controller.dataList[controller.dataList.length - 1]['수소이온농도'];
    final double BOD =
        controller.dataList[controller.dataList.length - 1]['생화학적 산소요구량'];
    final double SS =
        controller.dataList[controller.dataList.length - 1]['부유물질'];
    final double DO =
        controller.dataList[controller.dataList.length - 1]['용존산소'];
    final double TP = controller.dataList[controller.dataList.length - 1]['총인'];

    const double pHStandardMin = 6.0;
    const double pHStandardMax = 8.5;
    const double BODStandardMax = 8.0;
    const double SSStandardMax = 100.0;
    const double DOStandardMin = 2.0;
    const double TPStandardMax = 0.3;

    return SingleChildScrollView(
      child: Container(
        height: 470.0,
        width: 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            const Text(
              '수소이온농도 (pH):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '${pHStandardMin}~${pHStandardMax} 대비 ${pH} (${pH >= pHStandardMin && pH <= pHStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '생물화학적 산소요구량 (BOD, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '1 이하 대비 ${BOD} (${BOD <= BODStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '부유물질량 (SS, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '${SSStandardMax} 이하 대비 ${SS} (${SS <= SSStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '용존산소량 (DO, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '${DOStandardMin} 이상 대비 ${DO} (${DO >= DOStandardMin ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              '총인 (T-P, ㎎/L):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              '${TPStandardMax} 이하 대비 ${TP} (${TP <= TPStandardMax ? "적합" : "부적합"})',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: TextButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                  child: const Text(
                    '닫기',
                    style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
