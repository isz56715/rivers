import 'package:get/get.dart';
import 'JDP_main_provider.dart';

class JDPmainController extends GetxController with StateMixin<dynamic> {

  RxList<dynamic> dataList = RxList<dynamic>([]);
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    super.onClose();
  }
    // select
  void fetchData() {
    JDPmainProvider().fetchData().then((value) {
      JDPmainProvider().getJDPmain().then((value2) {
      dataList.value = [value, value2];
      change(value2, status: RxStatus.success());
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
      change(value, status: RxStatus.success());
    print(dataList);
    }, onError: (erorr) {
      change(null, status: RxStatus.error(erorr.toString()));
    });
  }

  void onupdate() {
    update();
  }

  reload() async {
    await Future.delayed(Duration(milliseconds: 200));
    this.fetchData();
  }


  void onTapPlayerList(int regisnum, String name, int age) {
    final result = Get.toNamed("/IP001e02",
        arguments: {"REGISNUM": regisnum, "PLAYERNAME": name, "AGE": age});
    if (result != null) {
      // reload();
    }
  }
}
