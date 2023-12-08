import 'package:flutter/material.dart';
import '/common/common.dart';
import 'package:get/get.dart';

import 'JDP003_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class JDP003view extends GetView<JDP003Controller> {
  const JDP003view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JDP003Controller());
    return Scaffold(
      body: DefaultLayout(
          child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                child: Column(
                  children: [bookmarkArea()],
                ),
              ))),
    );
  }

  Widget bookmarkArea() {
    return controller.obx((data) => Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: double.infinity,
          height: 500,
          color: SECONDARY_COLOR,
          child: RefreshIndicator(
            onRefresh: () async {
              controller.reload();
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext countext, int index) {
                //
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async => [
                          await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('삭제하시겠습니까?'),
                                  content: selectyesno(data[index]['bdr_id'], data[index]['river_number']),
                                );
                              }),
                        ],
                        backgroundColor: ECT_COLOR,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: '삭제',
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        data[index]['river_name'],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(data[index]['river_address']),
                      onTap: () {
                        controller.onTapGraph(data[index]['river_name']);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget selectyesno(String id, int river_number){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("취소"),
        ),
        const SizedBox(
          width: 30,
        ),
        OutlinedButton(
          onPressed: () async {
            controller.clickButtonDelete(id, river_number);

            Get.back();
          },
          child: Text("삭제"),
        ),
      ],
    );
  }
}
