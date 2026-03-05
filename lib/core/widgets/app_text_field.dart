import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 350,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style : AppTextStyle.body16R120.copyWith(
          color: AppColors.f03,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.body16R120.copyWith(
            color: AppColors.f03,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: AppColors.gray01,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}