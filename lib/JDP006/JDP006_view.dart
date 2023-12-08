import 'package:flutter/material.dart';
import '/common/common.dart';
import 'package:get/get.dart';
import 'JDP006_controller.dart';

class JDP006view extends GetView<JDP006Controller> {
  const JDP006view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout2(
        title: '하천 관리',
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              child: Column(
                children: [boardArea(), buttonpage(context)],
              ),
            )));
  }

  Widget boardArea() {
    return controller.obx((data) => Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: double.infinity,
          height: 500,
          color: SECONDARY_COLOR,
          child: RefreshIndicator(
            onRefresh: () async {
              controller.update();
            },
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext countext, int index) {
                //
                return Card(
                  child: ListTile(
                    leading: Text(
                      data[index]['type'],
                      style: TextStyle(
                          color: data[index]['type'] == '공지'
                              ? Colors.red
                              : Colors.black,
                          fontSize: 25),
                    ),
                    title: Text(
                      data[index]['title'],
                      style: TextStyle(fontSize: 25),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      data[index]['content'],
                      style: TextStyle(fontSize: 20),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      data[index]['regdate'],
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      controller.onTapList(
                          data[index]['board_id'],
                          data[index]['writer'],
                          data[index]['title'],
                          data[index]['content'],
                          data[index]['type'],
                          data[index]['river_type'],
                          data[index]['starpoint']);
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget buttonpage(context) {
    return controller.obx((data) => Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('글쓰기'),
                          content: boardContainer(),
                        );
                      });
                },
                style: TextButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: const Text(
                  "글쓰기",
                  style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ));
  }

  Widget boardContainer() {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return controller.obx((data) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: 500.0,
              width: 400.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  () {
                    if (controller.box.read('rivername') == 'normal') {
                      return Row(
                        children: [
                          Text('유형 : 일반', style: TextStyle(fontSize: 25)),
                          SizedBox(
                            width: 30,
                          ),
                          Text('작성자 : ${controller.box.read('name')}',
                              style: TextStyle(fontSize: 25)),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Text(
                            '공지',
                            style: TextStyle(fontSize: 25),
                          ),
                          Text('작성자 : ${controller.box.read('name')}',
                              style: TextStyle(fontSize: 25)),
                        ],
                      );
                    }
                  }(),
                  TextFormField(
                      controller: controller.titleform,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '제목',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return '비어있음';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 7,
                    controller: controller.contentform,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '내용',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "닫기",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (controller.box.read('rivername') ==
                                  'normal') {
                                controller.clickButtonInsert(
                                    controller.box.read('name'),
                                    1,
                                    controller.titleform.text,
                                    controller.contentform.text,
                                    controller.rivername.value);
                                Get.back();
                              } else {
                                controller.clickButtonInsert(
                                    controller.box.read('name'),
                                    0,
                                    controller.titleform.text,
                                    controller.contentform.text,
                                    controller.rivername.value);
                                Get.back();
                              }
                            }
                          },
                          child: Text(
                            "완료",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
