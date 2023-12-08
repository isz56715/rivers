import 'package:bigdata_frontend_test/JDP001/JDP001_view.dart';
import 'package:bigdata_frontend_test/JDP005/JDP005_binding.dart';
import 'package:bigdata_frontend_test/JDP005/JDP005_view.dart';
import 'package:bigdata_frontend_test/JDP006/JDP006_binding.dart';
import 'package:bigdata_frontend_test/JDP006/JDP006_view.dart';
import 'package:bigdata_frontend_test/JDP007/JDP007_binding.dart';
import 'package:bigdata_frontend_test/JDP007/JDP007_view.dart';
import 'package:bigdata_frontend_test/JDP_log/JDP_log_binding.dart';
import 'package:bigdata_frontend_test/JDP_log/JDP_log_view.dart';
import 'package:get/get.dart';

import '../JDPmain/JDP_main_binding.dart';
import '../JDPmain/JDP_main_view.dart';

class Routes {
  static final routes = [
    //메인화면
    GetPage(
      name: '/JDPmain',
      page: () => JdpmainView(),
      binding: JDPmainBinding(),
    ),
    GetPage(
      name: '/JDP001',
      page: () => JDP001View(),
    ),
    GetPage(
      name: '/JDP_log',
      page: () => JdplogView(),
      binding: JDPlogBinding(),
    ),
    GetPage(
      name: '/JDP005',
      page: () => JDP005view(),
      binding: JDP005Binding(),
    ),
    GetPage(
      name: '/JDP006',
      page: () => JDP006view(),
      binding: JDP006Binding(),
    ),
    GetPage(
      name: '/JDP007',
      page: () => JDP007view(),
      binding: JDP007Binding(),
    ),
  ];
}
