import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_menu_board_sheet.dart';

class AlbumViewPage extends StatefulWidget {
  const AlbumViewPage({super.key});

  @override
  State<AlbumViewPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumViewPage> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/system/dumy/dumy01.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 상단 앱바 (높이 106px)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 64,
              color: Colors.white,
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 56,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 정중앙 타이틀 (텍스트 길이 상관없이 항상 중앙)
                      Text(
                        '산책 모음집',
                        style: AppTextStyle.subtitle20M120.copyWith(
                          color: AppColors.f05,
                        ),
                      ),

                      // 왼쪽 닫기 버튼 (20px 여백)
                      Positioned(
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/system/icons/icon_close_big.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              AppColors.f05,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      // 오른쪽 더보기 버튼 (20px 여백)
                      Positioned(
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            MenuBottomSheet.show(
                              context: context,
                              petName: '산책 모음집',
                              onEdit: () {},
                              onCopy: () {},
                              onShare: () {},
                              isBookmarked: _isBookmarked,
                              onBookmark: () {
                                setState(() {
                                  _isBookmarked = !_isBookmarked;
                                });
                              },
                              onDelete: () {},
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/system/icons/icon_more.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              AppColors.f05,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 편집 버튼 (오른쪽 20px, 아래 56px)
          Positioned(
            right: 20,
            bottom: 56,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/system/icons/icon_edit.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}