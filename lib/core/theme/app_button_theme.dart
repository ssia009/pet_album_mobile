import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_common_button_styles.dart';
import 'app_colors.dart';

class AppButtonTheme {
  static final  elevated = ElevatedButtonThemeData(
    style: AppButtonStyles.base(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.f01,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.02),
      // 그림자 위치 값 (0,4,0)
    ),
  );

  static final gray = ElevatedButtonThemeData(
    style: AppButtonStyles.base(
      backgroundColor: AppColors.f01,
      foregroundColor: AppColors.f01,
    ),
  );

  static final inactive_btn = ElevatedButtonThemeData(
    style: AppButtonStyles.base(
      backgroundColor: AppColors.gray02,
      foregroundColor: AppColors.f04 ,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.04),
    ),
  );
}
