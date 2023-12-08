import 'package:get/get.dart';
import '/common/common.dart';

class JDP006Provider extends GetConnect {
  // Select
  Future<dynamic> getJDP006(rivername) async {
    final response = await get(ServerUrl + 'BIGDATA/JDP006?rivername=$rivername');
    print(ServerUrl2 + 'BIGDATA/JDP006?rivername=$rivername');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }


  // Insert
  Future<dynamic> boardInsert(String json) async {
    final response = await post(ServerUrl + 'BIGDATA/JDP006', json);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
