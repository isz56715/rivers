import 'package:get/get.dart';
import '/common/common.dart';

class JDPmainProvider extends GetConnect {
  String serviceKey =
      'IPf54zOQu0tuMmxlo4iYCwUPb4QxuPZKvZxx385ZWhIxWYe7Zbiwi6P/usrY/CP5c9iLKUApWcdBsCdsEp0P2w';
  String apiurl =
      'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=';
  //

  Future<dynamic> fetchData() async {
    final response = await get(
        '$apiurl$serviceKey%3D%3D&pageNo=1&numOfRows=100&dataType=json&base_date=20230618&base_time=0600&nx=55&ny=127');
    print(
        '$apiurl$serviceKey%3D%3D&pageNo=1&numOfRows=100&dataType=json&base_date=20230618&base_time=0600&nx=55&ny=127');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Select
  Future<dynamic> getJDPmain() async {
    final response = await get(ServerUrl + 'BIGDATA/JDPMAIN');
    print(ServerUrl + 'BIGDATA/JDPMAIN');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
