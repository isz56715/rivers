import 'package:get/get.dart';
import '/common/common.dart';

class JDP002Provider extends GetConnect {
  

  // Select
  Future<dynamic> getJDP002() async {
    final response = await get(ServerUrl + 'BIGDATA/JDP002');
    print(ServerUrl2 + 'BIGDATA/JDP002');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

    // Select
  Future<dynamic> getJDP002Q() async {
    final response = await get(ServerUrl + 'BIGDATA/JDP002');
    print(ServerUrl + 'BIGDATA/JDP002');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Delete
  Future<dynamic> setIP001e01Delete(int regisnum) async {
    final response =
        await delete(ServerUrl + 'BIGDATA/JDP002?regisnum=$regisnum');

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

  // Insert
  Future<dynamic> bookmarkInsert(String json) async {
    final response = await post(ServerUrl + 'BIGDATA/JDP002', json);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body;
    }
  }

}
