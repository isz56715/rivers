import 'package:get/get.dart';
import '/common/common.dart';

class JDP003Provider extends GetConnect {
  // Select
  Future<dynamic> getJDP003(id) async {
    final response = await get(ServerUrl + 'BIGDATA/JDP003?id=$id');
    print(ServerUrl2 + 'BIGDATA/JDP003?id=$id');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Delete
  Future<dynamic> bookMarkDelete(String bdr_id, int river_number) async {
    final response =
        await delete(ServerUrl + 'BIGDATA/JDP003?bdr_id=$bdr_id&river_number=$river_number');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
