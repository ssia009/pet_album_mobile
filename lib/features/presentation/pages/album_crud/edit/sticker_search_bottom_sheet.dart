import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';

// 스티커 모델
class Sticker {
  final String id;
  final String emoji;
  final String name;

  const Sticker({
    required this.id,
    required this.emoji,
    required this.name,
  });
}

class StickerBottomSheet extends StatefulWidget {
  const StickerBottomSheet({Key? key}) : super(key: key);

  @override
  State<StickerBottomSheet> createState() => _StickerBottomSheetState();

  static Future<Sticker?> show(BuildContext context) {
    return showModalBottomSheet<Sticker>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => const StickerBottomSheet(),
    );
  }
}

class _StickerBottomSheetState extends State<StickerBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = ['전체', '문자', '장난감', '데코', '음식', '자연'];

  final Map<String, List<Sticker>> _stickersByCategory = {
    '전체': [
      Sticker(id: '1', emoji: '😀', name: '웃음'),
      Sticker(id: '2', emoji: '😂', name: '기쁨'),
      Sticker(id: '3', emoji: '😍', name: '사랑'),
      Sticker(id: '4', emoji: '🥰', name: '행복'),
      Sticker(id: '5', emoji: '😎', name: '멋짐'),
      Sticker(id: '6', emoji: '🤔', name: '생각'),
      Sticker(id: '7', emoji: '😭', name: '슬픔'),
      Sticker(id: '8', emoji: '😱', name: '놀람'),
      Sticker(id: '9', emoji: '🐶', name: '강아지'),
      Sticker(id: '10', emoji: '🐱', name: '고양이'),
      Sticker(id: '11', emoji: '🍕', name: '피자'),
      Sticker(id: '12', emoji: '🍔', name: '햄버거'),
    ],
    '문자': [
      Sticker(id: '13', emoji: '👨‍🏫', name: '선생님'),
      Sticker(id: '14', emoji: '📚', name: '책'),
      Sticker(id: '15', emoji: '✏️', name: '연필'),
    ],
    '장난감': [
      Sticker(id: '16', emoji: '🚚', name: '트럭'),
      Sticker(id: '17', emoji: '📦', name: '상자'),
      Sticker(id: '18', emoji: '🏃', name: '달리기'),
    ],
    '데코': [
      Sticker(id: '19', emoji: '🎯', name: '목표'),
      Sticker(id: '20', emoji: '💪', name: '힘'),
      Sticker(id: '21', emoji: '🏆', name: '우승'),
    ],
    '음식': [
      Sticker(id: '22', emoji: '⭐', name: '별'),
      Sticker(id: '23', emoji: '🌙', name: '달'),
      Sticker(id: '24', emoji: '☀️', name: '태양'),
    ],
    '자연': [
      Sticker(id: '25', emoji: '🎨', name: '미술'),
      Sticker(id: '26', emoji: '🎵', name: '음악'),
      Sticker(id: '27', emoji: '💃', name: '춤'),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onStickerTap(Sticker sticker) {
    Navigator.pop(context, sticker);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double initialHeight = 340.0;
    final maxHeight = screenHeight * 0.9;

    return DraggableScrollableSheet(
      initialChildSize: initialHeight / screenHeight,
      minChildSize: initialHeight / screenHeight,
      maxChildSize: maxHeight / screenHeight,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border(
              top: BorderSide(color: AppColors.gray01, width: 1.5),
              left: BorderSide(color: AppColors.gray01, width: 1.5),
              right: BorderSide(color: AppColors.gray01, width: 1.5),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000), // rgba(0,0,0,0.04)
                offset: Offset(0, -4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              // 헤더 영역 (핸들 + 검색 + 탭)
              SingleChildScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 핸들바 (54x4, gray03, radius 30)
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 54,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.gray03,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 검색창
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.gray01,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/system/icons/icon_search.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                AppColors.gray04,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                style: AppTextStyle.description14R120.copyWith(
                                  color: AppColors.f04,
                                ),
                                decoration: InputDecoration(
                                  hintText: '검색어를 입력해주세요.',
                                  hintStyle: AppTextStyle.description14R120.copyWith(
                                    color: AppColors.f04,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: AppColors.gray04,
                                    ),
                                  )
                                      : null,
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 카테고리 탭
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(_categories.length, (index) {
                            final isSelected = _tabController.index == index;
                            return GestureDetector(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: index < _categories.length - 1 ? 8 : 0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.gray02 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _categories[index],
                                  style: AppTextStyle.description14M120.copyWith(
                                    color: isSelected ? AppColors.f05 : AppColors.f02,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // 스티커 그리드
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories.map((category) {
                    final stickers = _stickersByCategory[category] ?? [];

                    if (stickers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported_outlined,
                              size: 64,
                              color: AppColors.gray03,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '스티커가 없습니다',
                              style: AppTextStyle.description14R120.copyWith(
                                color: AppColors.f03,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemCount: stickers.length,
                      itemBuilder: (context, index) {
                        final sticker = stickers[index];
                        return GestureDetector(
                          onTap: () => _onStickerTap(sticker),
                          child: Center(
                            child: Text(
                              sticker.emoji,
                              style: const TextStyle(fontSize: 52),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}