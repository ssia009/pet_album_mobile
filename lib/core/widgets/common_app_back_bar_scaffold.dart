import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

class CommonBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

  const CommonBackAppBar({
    super.key,
    this.title,
    this.actions,
  });

  static const double _toolbarHeight = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: AppColors.gray00,
      elevation: 0,
      toolbarHeight: _toolbarHeight,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: SvgPicture.asset(
            'assets/system/icons/icon_back.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.f05,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: title == null
          ? null
          : Text(
        title!,
        style: AppTextStyle.subtitle20M120.copyWith(
          color: AppColors.f05,
        ),
      ),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}