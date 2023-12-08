import 'package:bigdata_frontend_test/JDP_log/JDP_log_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Radiobutton extends StatelessWidget {
  final String value;
  final String title;


  const Radiobutton({
    required this.value,
    required this.title,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JDPlogController>(builder: (buttoncontroller) {
      return InkWell(
        onTap: () => buttoncontroller.updateSelectedOption(value),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: buttoncontroller.gendertype,
              onChanged: (String? value) {
                buttoncontroller.updateSelectedOption(value!);
              },
              activeColor: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(title),
            const SizedBox(
              width: 5,
            ),
            
          ],
        ),
      );
    });
  }
}
