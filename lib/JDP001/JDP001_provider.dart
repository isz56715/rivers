import 'package:get/get.dart';
import '/common/common.dart';

class JDP001Provider extends GetConnect {


  Future<dynamic> fetchData(today, rtime, x, y) async {
    final response = await get(
        '$apiurl$serviceKey%3D%3D&pageNo=1&numOfRows=100&dataType=json&base_date=$today&base_time=$rtime&nx=$x&ny=$y');
    print(
        '$apiurl$serviceKey%3D%3D&pageNo=1&numOfRows=100&dataType=json&base_date=$today&base_time=$rtime&nx=$x&ny=$y');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Select
  Future<dynamic> getJDP001(rivername) async {
    final response = await get(ServerUrl + 'BIGDATA/JDP001?rivername=$rivername');
    print(ServerUrl2 + 'BIGDATA/JDP001?rivername=$rivername');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

}
