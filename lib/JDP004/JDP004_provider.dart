import 'package:get/get.dart';
import '/common/common.dart';

class JDP004Provider extends GetConnect {

  // Select
  Future<dynamic> getJDP004(String id) async {
    final response = await get(ServerUrl + 'BIGDATA/JDP004?id=$id');
    print(ServerUrl2 + 'BIGDATA/JDP004?id=$id');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
