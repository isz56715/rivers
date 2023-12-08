import 'package:bigdata_frontend_test/common/defalt_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'JDP_main_controller.dart';

// ignore: must_be_immutable
class JdpmainView extends GetView<JDPmainController> {
  JdpmainView({Key? key}) : super(key: key);

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '하천',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: DefaultLayout(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                child: Column(
                  children: [mainTitle(context)],
                ),
              ))),
    );
  }

  Widget mainTitle(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Text(
        '___님 \n근처에 산책하기 좋은 하천을 추천드릴게요.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget mainChart(BuildContext context) {
    return controller.obx((data) => Container(
          child: Text(data),
        ));
  }
}
