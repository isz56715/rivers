import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/common.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'JDP002_controller.dart';

class JDP002view extends GetView<JDP002Controller> {
  const JDP002view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => JDP002Controller());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.reload();
        },
        child: DefaultLayout(
            child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: SafeArea(
                  child: Column(
                    children: [SearchArea(), bookmarkArea()],
                  ),
                ))),
      ),
    );
  }

  Widget SearchArea() {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: PRIMARY_COLOR, width: 1));
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
      width: double.infinity,
      child: TextFormField(
        cursorColor: PRIMARY_COLOR,
        controller: controller.searchform,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.search,
                size: 30,
                color: PRIMARY_COLOR,
              ),
              onTap: () {
                controller.filterRivers();
              },
            ),
            contentPadding: EdgeInsets.all(20),
            hintStyle: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            ),
            fillColor: INPUT_BG_COLOR,
            filled: true,
            border: baseBorder,
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
                borderSide:
                    baseBorder.borderSide.copyWith(color: PRIMARY_COLOR))),
      ),
    );
  }

  Widget bookmarkArea() {
    return controller.obx((data) => Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          width: double.infinity,
          height: 470,
          color: SECONDARY_COLOR,
          child: ListView.builder(
            itemCount: controller.rivers.length,
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
                        controller.clickButtonInsert(
                            controller.box.read('id'),
                            controller.rivers[index].rivername!,
                            '${controller.rivers[index].city!} ${controller.rivers[index].county!} ${controller.rivers[index].town!} ${controller.rivers[index].dong ?? ''}')
                      ],
                      backgroundColor: ECT_COLOR2,
                      foregroundColor: Colors.white,
                      icon: Icons.star,
                      label: '즐겨찾기',
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ],
                ),
                child: Card(
                  child: ListTile(
                    title: Text(
                      controller.rivers[index].rivername!,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                        '${controller.rivers[index].city!} ${controller.rivers[index].county!} ${controller.rivers[index].town!} ${controller.rivers[index].dong ?? ''}'),
                    trailing: Text(
                      '${controller.rivers[index].km!.toInt()}km',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      controller
                          .onTapGraph(controller.rivers[index].rivername!);
                    },
                  ),
                ),
              );
            },
          ),
        ));
  }
}
