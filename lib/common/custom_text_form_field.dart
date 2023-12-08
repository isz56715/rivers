import 'package:bigdata_frontend_test/common/colors.dart';
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {

  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final bool? autofocus;
  final ValueChanged<String>? onChanged;
  const CustomTextFormField({
    required this.onChanged,
    this.autofocus = false,
    this.obscureText = false,
    this.hintText,
    this.errorText,
    Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1
      )
    );
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력시
      obscureText: false,
      autofocus: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 20,
        ),
        fillColor: INPUT_BG_COLOR,
        // false - 배경색 없음
        // true - 배경색 있음
        filled: true,
        // 모든 input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR
          )
        )
      ),
    );
  }
}
