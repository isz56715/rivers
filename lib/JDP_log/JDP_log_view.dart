import 'package:bigdata_frontend_test/JDP_log/JDP_log_controller.dart';
import 'package:bigdata_frontend_test/common/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/common.dart';

// ignore: must_be_immutable
class JdplogView extends GetView<JDPlogController> {
  JdplogView({Key? key}) : super(key: key);

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: Color.fromARGB(255, 243, 241, 241),
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    title(context),
                    const SizedBox(
                      height: 10,
                    ),
                    subtitle(context),
                    Image.asset(
                      'asset/img/rive2.png',
                      width: MediaQuery.of(context).size.width / 3 * 2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    mainlog(context)
                  ],
                ),
              ),
            )));
  }

  Widget title(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }

  Widget subtitle(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!\n깨끗한 하천을 만들기 위해 노력해봐요 :)',
      style: TextStyle(fontSize: 25, color: BODY_TEXT_COLOR),
    );
  }

  Widget mainlog(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
                controller: controller.idform,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '아이디',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '비어있음';
                  }
                  return null;
                }),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
                controller: controller.passwordform,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호',
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return '비어있음';
                  }
                  return null;
                }),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await controller.getJDPlog();

                    if (controller.dataList.length == 1) {
                      controller.onLogin();

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => RootTab()));
                    } else if (controller.dataList.length != 1) {
                      Get.defaultDialog(
                        title: '로그인 오류',
                        titleStyle: TextStyle(fontSize: 30),
                        content: const Text(
                          '아이디 또는 비밀번호가 일치하지 않습니다.',
                          style: TextStyle(fontSize: 25),
                        ),
                        textConfirm: '확인',
                        confirmTextColor: Colors.white,
                        onConfirm: Get.back,
                      );
                    }
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                )),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('회원가입'),
                                content: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: insertContainer()),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text(
                        '일반 회원가입',
                        style:
                            TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                      )),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('회원가입'),
                                content: insert2Container(),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text(
                        '관리자 회원가입',
                        style:
                            TextStyle(color: PRIMARY_TEXT_COLOR, fontSize: 20),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget insertContainer() {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Form(
          key: _formKey,
          child: SizedBox(
            height: 400.0,
            width: 400.0,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '아이디',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '비밀번호',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.birthdayform,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '생년월일 6자리',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.phoneform,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '전화번호',
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Radiobutton(value: '남', title: '남'),
                    Radiobutton(value: '여', title: '여'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "취소",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      onPressed: () async {},
                      child: const Text(
                        "가입",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }

  Widget insert2Container() {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Form(
          key: _formKey,
          child: SizedBox(
            height: 400.0,
            width: 400.0,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Radiobutton(value: '남', title: '남'),
                    Radiobutton(value: '여', title: '여'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "취소",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "가입",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
