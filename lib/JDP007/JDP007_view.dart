import 'package:flutter/material.dart';
import '/common/common.dart';
import 'package:get/get.dart';
import 'JDP007_controller.dart';

class JDP007view extends GetView<JDP007Controller> {
  const JDP007view({Key? key}) : super(key: key);

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
    return Obx(() => Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          width: double.infinity,
          height: 500,
          color: SECONDARY_COLOR,
          child: RefreshIndicator(
            onRefresh: () async {
              controller.update();
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Expanded(
                  child: Container(
                margin: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              controller.type.toString(),
                              style: TextStyle(
                                  color: controller.type.toString() == '공지'
                                      ? Colors.red
                                      : Colors.black,
                                  fontSize: 30),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '작성자 : ${controller.writer.toString()}',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          () {
                            if (controller.type.toString() == '공지' ||
                                controller.box.read('rivername') == 'normal') {
                              return const Text('');
                            } else if (controller.starpoint == 0) {
                              return IconButton(
                                icon: Icon(Icons.star_border),
                                color: PRIMARY_COLOR,
                                iconSize: 30,
                                onPressed: () {
                                  controller.starpoint.value = 1;
                                  controller.starUpdate(
                                      controller.board_id.value,
                                      controller.river_type.value,
                                      controller.starpoint.value);
                                },
                              );
                            } else {
                              return IconButton(
                                icon: Icon(Icons.star),
                                color: PRIMARY_COLOR,
                                iconSize: 30,
                                onPressed: () {
                                  controller.starpoint.value = 0;
                                  controller.starUpdate(
                                      controller.board_id.value,
                                      controller.river_type.value,
                                      controller.starpoint.value);
                                },
                              );
                            }
                          }(),
                        ],
                      ),
                      Divider(),
                      Container(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '제목 : ',
                                style: TextStyle(fontSize: 30),
                              ),
                              Flexible(
                                  child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                strutStyle: StrutStyle(fontSize: 16.0),
                                text: TextSpan(
                                    text: '${controller.title.toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        height: 1.4,
                                        fontSize: 16.0,
                                        fontFamily: 'NanumSquareRegular')),
                              )),
                            ],
                          )),
                      Divider(),
                      Text(
                        '내용 : ',
                        style: TextStyle(fontSize: 30),
                      ),
                      Container(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                  child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 14,
                                strutStyle: StrutStyle(fontSize: 16.0),
                                text: TextSpan(
                                    text: '${controller.content.toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        height: 1.4,
                                        fontSize: 16.0,
                                        fontFamily: 'NanumSquareRegular')),
                              )),
                            ],
                          ))
                    ],
                  ),
                ),
              )),
            ),
          ),
        ));
  }

  Widget buttonpage(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              print(
                  '${controller.box.read('name')} == ${controller.writer.toString()}, 일치시 수정 가능');
              if (controller.box.read('name') == controller.writer.toString()) {
                controller.titleform.text = controller.title.toString();
                controller.contentform.text = controller.content.toString();
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text('수정'),
                          content: updateboardContainer(
                            controller.type.toString(),
                            controller.writer.toString(),
                          ));
                    });
              } else {
                Get.defaultDialog(
                  title: '작성자 불일치',
                  titleStyle: TextStyle(fontSize: 25),
                  content: const Text(
                    '작성자가 일치하지 않습니다.',
                    style: TextStyle(fontSize: 25),
                  ),
                  textConfirm: '확인',
                  confirmTextColor: Colors.white,
                  onConfirm: Get.back,
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: const Text(
              "수정",
              style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                title: '게시글 삭제',
                titleStyle: TextStyle(fontSize: 25),
                content: const Text(
                  '삭제하시겠습니까?',
                  style: TextStyle(fontSize: 25),
                ),
                textConfirm: '확인',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  if (controller.box.read('name') ==
                      controller.writer.toString()) {
                    controller.clickButtonDelete(
                        controller.board_id.value, controller.river_type.value);
                    controller.update();
                    Get.back();
                  } else {
                    Get.defaultDialog(
                      title: '작성자 불일치',
                      titleStyle: TextStyle(fontSize: 25),
                      content: const Text(
                        '작성자가 일치하지 않습니다.',
                        style: TextStyle(fontSize: 25),
                      ),
                      textConfirm: '확인',
                      confirmTextColor: Colors.white,
                      onConfirm: Get.back,
                    );
                  }
                },
                textCancel: '취소',
                onCancel: Get.back,
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
            ),
            child: const Text(
              "삭제",
              style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget updateboardContainer(type, writer) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: 400.0,
          width: 400.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text('유형 : $type', style: TextStyle(fontSize: 25)),
                  SizedBox(
                    width: 30,
                  ),
                  Text('작성자 : $writer', style: TextStyle(fontSize: 25)),
                ],
              ),
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
                      onPressed: () {
                        controller.boardUpdate(
                            controller.board_id.value,
                            controller.river_type.value,
                            controller.titleform.text,
                            controller.contentform.text);
                        controller.update();
                        Get.back();
                      },
                      child: Text(
                        "수정",
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
    );
  }
}
