import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

class CommonMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leadingContent;
  final EdgeInsetsGeometry? leadingPadding;
  final bool centerTitle;

  const CommonMainAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leadingContent,
    this.leadingPadding,
    this.centerTitle = false,
  });

  static const double _toolbarHeight = kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.gray00,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      toolbarHeight: _toolbarHeight,
      titleSpacing: 20,
      actionsPadding: const EdgeInsets.only(right: 20),
      leadingWidth: 120,
      automaticallyImplyLeading: false,
      leading: leadingContent == null
          ? null
          : Padding(
        padding: leadingPadding ?? EdgeInsets.zero,
        child: leadingContent,
      ),
      title: Text(
        title,
        style: AppTextStyle.subtitle20M120.copyWith(
          color: AppColors.f05,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);
}