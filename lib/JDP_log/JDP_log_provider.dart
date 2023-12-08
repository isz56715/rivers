import 'package:get/get.dart';
import '/common/common.dart';

class JDPlogProvider extends GetConnect {

  // Select
  Future<dynamic> getJDPlog(id, password) async {
    final response = await get(ServerUrl + 'BIGDATA/JDPlog?id=$id&password=$password');
    print(ServerUrl2 + 'BIGDATA/JDPlog?id=$id&password=$password');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
