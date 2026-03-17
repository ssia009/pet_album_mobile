import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

class AppCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final double borderWidth;
  final double height;
  final double borderRadius;

  const AppCustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor = AppColors.black,
    this.textColor = AppColors.f01,
    this.borderColor = AppColors.black,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.borderWidth = 1.5,
    this.height = 55,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledBackgroundColor ?? AppColors.bg;
            }
            return backgroundColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledTextColor ?? AppColors.f03;
            }
            return textColor;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(
                color: disabledBackgroundColor ?? AppColors.bg,
                width: borderWidth,
              );
            }
            return BorderSide(color: borderColor, width: borderWidth);
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          elevation: WidgetStateProperty.all(0),
        ),
        child: Text(
          text,
          style: AppTextStyle.body16R120,
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 건너뛰기 다이얼로그
////////////////////////////////////////////////////////////

class SkipDialog {
  static void show({
    required BuildContext context,
    required VoidCallback onSkip,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '건너뛰시겠습니까?',
                    style: AppTextStyle.subtitle20M120.copyWith(
                      color: AppColors.f05,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '미작성 시 다른 서비스 이용이 제한됩니다.\n입력한 내용은 자동저장됩니다.',
                    style: AppTextStyle.description14R120.copyWith(
                      color: AppColors.f04,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AppCustomButton(
                          text: '취소',
                          onTap: () => Navigator.of(context).pop(),
                          backgroundColor: AppColors.gray02,
                          textColor: AppColors.f05,
                          borderColor: AppColors.gray02,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppCustomButton(
                          text: '건너뛰기',
                          onTap: () {
                            Navigator.of(context).pop();
                            onSkip();
                          },
                          backgroundColor: AppColors.black,
                          textColor: AppColors.f01,
                          borderColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}