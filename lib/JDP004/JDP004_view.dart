import 'package:bigdata_frontend_test/common/star.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/common.dart';

import 'JDP004_controller.dart';

class JDP004view extends GetView<JDP004Controller> {
  JDP004view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JDP004Controller());
    return Scaffold(
      body: DefaultLayout(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                child: Column(
                  children: [mypage(context), buttonpage(context)],
                ),
              ))),
    );
  }

  Widget mypage(BuildContext context) {
    return controller.obx((data) => Card(
          color: SECONDARY_COLOR,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('asset/img/noprofile.jpg'),
                            radius: 50.0,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data[0]['name'],
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                '성별 : ${data[0]['gender']}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '    전화번호 : ${data[0]['phone']}',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '    생년월일 : ${data[0]['birth']}',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  () {
                    if (controller.box.read('rivername') == 'normal') {
                      return Expanded(
                        child: Container(
                          width: 50,
                          height: 160,
                          child: Column(
                            children: [
                              Text(
                                '총 별점!',
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 25),
                              ),
                              CustomPaint(
                                painter: StarShapePainter(),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                    data[0]['total_star'].toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(
                          width: 50,
                          height: 160,
                          child: Column(
                            children: [
                              Text(
                                '담당 하천!',
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                data[0]['m_rnum'],
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buttonpage(BuildContext context) {
    return controller.obx((data) => Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => {},
              style: TextButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
              child: const Text(
                "수정",
                style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // controller.logoutUser();
              },
              style: TextButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
              child: const Text(
                "로그아웃",
                style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ));
  }
}
