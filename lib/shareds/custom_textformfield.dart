import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final void Function(String value)? onChanged;
  const CustomTextFormField({super.key, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: TextFormField(
        style: AppTextStyle.robotoW400s14.copyWith(color: AppColors.grey200),
        onChanged: onChanged,
        cursorHeight: 15,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: const Color.fromARGB(255, 227, 232, 235),
          isDense: true,
          hintText: hintText,
          hintStyle:
              AppTextStyle.robotoW400s14.copyWith(color: AppColors.grey200),
          prefixIcon: const Icon(Icons.search, color: Color(0xff8E98A3)),
          errorStyle: const TextStyle(height: .5),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(4)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
