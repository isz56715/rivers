import 'package:get/get.dart';
import '/common/common.dart';

class JDP005Provider extends GetConnect {

  // Select
  Future<dynamic> getJDP005(rivername) async {
    final response = await get(ServerUrl + 'BIGDATA/JDP005?rivername=$rivername');
    print(ServerUrl2 + 'BIGDATA/JDP005?rivername=$rivername');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
