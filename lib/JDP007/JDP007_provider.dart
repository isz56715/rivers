import 'package:get/get.dart';
import '/common/common.dart';

class JDP007Provider extends GetConnect {
  // Select
  Future<dynamic> getJDP006() async {
    final response = await get(ServerUrl + 'BIGDATA/JDP007');
    print(ServerUrl2 + 'BIGDATA/JDP007');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Delete
  Future<dynamic> boardDelete(int board_id, int river_type) async {
    final response =
        await delete(ServerUrl + 'BIGDATA/JDP007?board_id=$board_id&river_type=$river_type');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Update
  Future<dynamic> starUpdate(String json) async {
    final response = await put(ServerUrl + 'BIGDATA/JDP007', json);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Update2
  Future<dynamic> boardUpdate(String json) async {
    final response = await put(ServerUrl + 'BIGDATA/JDP007', json);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }
}
