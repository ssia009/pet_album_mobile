import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/font/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';

// 스티커 모델
class Sticker {
  final String id;
  final String emoji;
  final String name;
  final String? svgPath;

  const Sticker({
    required this.id,
    required this.emoji,
    required this.name,
    this.svgPath,
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
  final FocusNode _focusNode = FocusNode();
  final DraggableScrollableController _sheetController = DraggableScrollableController();

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
      Sticker(id: '19', emoji: '', name: 'zzz', svgPath: 'assets/system/sticker/deco/데코_zzz.svg'),
      Sticker(id: '20', emoji: '', name: '금', svgPath: 'assets/system/sticker/deco/데코_금.svg'),
      Sticker(id: '21', emoji: '', name: '깜짝', svgPath: 'assets/system/sticker/deco/데코_깜짝.svg'),
      Sticker(id: '41', emoji: '', name: '날개', svgPath: 'assets/system/sticker/deco/데코_날개.svg'),
      Sticker(id: '42', emoji: '', name: '내강아지', svgPath: 'assets/system/sticker/deco/데코_내강아지.svg'),
      Sticker(id: '43', emoji: '', name: '내고양이', svgPath: 'assets/system/sticker/deco/데코_내고양이.svg'),
      Sticker(id: '44', emoji: '', name: '느낌표', svgPath: 'assets/system/sticker/deco/데코_느낌표.svg'),
      Sticker(id: '45', emoji: '', name: '동그라미', svgPath: 'assets/system/sticker/deco/데코_동그라미.svg'),
      Sticker(id: '46', emoji: '', name: '땀1', svgPath: 'assets/system/sticker/deco/데코_땀1.svg'),
      Sticker(id: '47', emoji: '', name: '땀3', svgPath: 'assets/system/sticker/deco/데코_땀3.svg'),
      Sticker(id: '48', emoji: '', name: '목', svgPath: 'assets/system/sticker/deco/데코_목.svg'),
      Sticker(id: '49', emoji: '', name: '발바닥1', svgPath: 'assets/system/sticker/deco/데코_발바닥1.svg'),
      Sticker(id: '50', emoji: '', name: '발바닥2', svgPath: 'assets/system/sticker/deco/데코_발바닥2.svg'),
      Sticker(id: '51', emoji: '', name: '비눗방울', svgPath: 'assets/system/sticker/deco/데코_비눗방울.svg'),
      Sticker(id: '52', emoji: '', name: '선물상자', svgPath: 'assets/system/sticker/deco/데코_선물상자.svg'),
      Sticker(id: '53', emoji: '', name: '수', svgPath: 'assets/system/sticker/deco/데코_수.svg'),
      Sticker(id: '54', emoji: '', name: '시계2', svgPath: 'assets/system/sticker/deco/데코_시계2.svg'),
      Sticker(id: '55', emoji: '', name: '쓰레기통', svgPath: 'assets/system/sticker/deco/데코_쓰레기통.svg'),
      Sticker(id: '56', emoji: '', name: '액자', svgPath: 'assets/system/sticker/deco/데코_액자.svg'),
      Sticker(id: '57', emoji: '', name: '어질', svgPath: 'assets/system/sticker/deco/데코_어질.svg'),
      Sticker(id: '58', emoji: '', name: '엑스', svgPath: 'assets/system/sticker/deco/데코_엑스.svg'),
      Sticker(id: '59', emoji: '', name: '오케이', svgPath: 'assets/system/sticker/deco/데코_오케이.svg'),
      Sticker(id: '60', emoji: '', name: '와이드집게', svgPath: 'assets/system/sticker/deco/데코_와이드집게.svg'),
      Sticker(id: '61', emoji: '', name: '왕관', svgPath: 'assets/system/sticker/deco/데코_왕관.svg'),
      Sticker(id: '62', emoji: '', name: '운동기구', svgPath: 'assets/system/sticker/deco/데코_운동기구.svg'),
      Sticker(id: '63', emoji: '', name: '웃음', svgPath: 'assets/system/sticker/deco/데코_웃음.svg'),
      Sticker(id: '64', emoji: '', name: '월', svgPath: 'assets/system/sticker/deco/데코_월.svg'),
      Sticker(id: '65', emoji: '', name: '일', svgPath: 'assets/system/sticker/deco/데코_일.svg'),
      Sticker(id: '66', emoji: '', name: '집3', svgPath: 'assets/system/sticker/deco/데코_집3.svg'),
      Sticker(id: '67', emoji: '', name: '차', svgPath: 'assets/system/sticker/deco/데코_차.svg'),
      Sticker(id: '68', emoji: '', name: '창문', svgPath: 'assets/system/sticker/deco/데코_창문.svg'),
      Sticker(id: '69', emoji: '', name: '체크', svgPath: 'assets/system/sticker/deco/데코_체크.svg'),
      Sticker(id: '70', emoji: '', name: '클립1', svgPath: 'assets/system/sticker/deco/데코_클립1.svg'),
      Sticker(id: '71', emoji: '', name: '클립2', svgPath: 'assets/system/sticker/deco/데코_클립2.svg'),
      Sticker(id: '72', emoji: '', name: '터짐효과', svgPath: 'assets/system/sticker/deco/데코_터짐효과.svg'),
      Sticker(id: '73', emoji: '', name: '토', svgPath: 'assets/system/sticker/deco/데코_토.svg'),
      Sticker(id: '74', emoji: '', name: '튜브1', svgPath: 'assets/system/sticker/deco/데코_튜브1.svg'),
      Sticker(id: '75', emoji: '', name: '튜브2', svgPath: 'assets/system/sticker/deco/데코_튜브2.svg'),
      Sticker(id: '76', emoji: '', name: '폴라로이드', svgPath: 'assets/system/sticker/deco/데코_폴라로이드.svg'),
      Sticker(id: '77', emoji: '', name: '핀1', svgPath: 'assets/system/sticker/deco/데코_핀1.svg'),
      Sticker(id: '78', emoji: '', name: '핀2', svgPath: 'assets/system/sticker/deco/데코_핀2.svg'),
      Sticker(id: '79', emoji: '', name: '핀3', svgPath: 'assets/system/sticker/deco/데코_핀3.svg'),
      Sticker(id: '80', emoji: '', name: '핀4', svgPath: 'assets/system/sticker/deco/데코_핀4.svg'),
      Sticker(id: '81', emoji: '', name: '핀5', svgPath: 'assets/system/sticker/deco/데코_핀5.svg'),
      Sticker(id: '82', emoji: '', name: '핀6', svgPath: 'assets/system/sticker/deco/데코_핀6.svg'),
      Sticker(id: '83', emoji: '', name: '핀7', svgPath: 'assets/system/sticker/deco/데코_핀7.svg'),
      Sticker(id: '84', emoji: '', name: '하트', svgPath: 'assets/system/sticker/deco/데코_하트.svg'),
      Sticker(id: '85', emoji: '', name: '하트2', svgPath: 'assets/system/sticker/deco/데코_하트2.svg'),
      Sticker(id: '86', emoji: '', name: '하트3', svgPath: 'assets/system/sticker/deco/데코_하트3.svg'),
      Sticker(id: '87', emoji: '', name: '하트4', svgPath: 'assets/system/sticker/deco/데코_하트4.svg'),
      Sticker(id: '88', emoji: '', name: '하트4-1', svgPath: 'assets/system/sticker/deco/데코_하트4-1.svg'),
      Sticker(id: '89', emoji: '', name: '하트5', svgPath: 'assets/system/sticker/deco/데코_하트5.svg'),
      Sticker(id: '90', emoji: '', name: '화', svgPath: 'assets/system/sticker/deco/데코_화.svg'),
    ],
    '음식': [
      Sticker(id: '22', emoji: '', name: '계란', svgPath: 'assets/system/sticker/food/음식_계란.svg'),
      Sticker(id: '23', emoji: '', name: '고구마', svgPath: 'assets/system/sticker/food/음식_고구마.svg'),
      Sticker(id: '24', emoji: '', name: '딸기', svgPath: 'assets/system/sticker/food/음식_딸기.svg'),
      Sticker(id: '25', emoji: '', name: '레몬', svgPath: 'assets/system/sticker/food/음식_레몬.svg'),
      Sticker(id: '26', emoji: '', name: '막대사탕', svgPath: 'assets/system/sticker/food/음식_막대사탕.svg'),
      Sticker(id: '27', emoji: '', name: '물', svgPath: 'assets/system/sticker/food/음식_물.svg'),
      Sticker(id: '28', emoji: '', name: '밥그릇', svgPath: 'assets/system/sticker/food/음식_밥그릇.svg'),
      Sticker(id: '29', emoji: '', name: '사과', svgPath: 'assets/system/sticker/food/음식_사과.svg'),
      Sticker(id: '30', emoji: '', name: '사료', svgPath: 'assets/system/sticker/food/음식_사료.svg'),
      Sticker(id: '31', emoji: '', name: '식빵', svgPath: 'assets/system/sticker/food/음식_식빵.svg'),
      Sticker(id: '32', emoji: '', name: '아보카도', svgPath: 'assets/system/sticker/food/음식_아보카도.svg'),
      Sticker(id: '33', emoji: '', name: '커피', svgPath: 'assets/system/sticker/food/음식_커피.svg'),
      Sticker(id: '34', emoji: '', name: '케이크', svgPath: 'assets/system/sticker/food/음식_케이크.svg'),
      Sticker(id: '35', emoji: '', name: '케이크2', svgPath: 'assets/system/sticker/food/음식_케이크2.svg'),
      Sticker(id: '36', emoji: '', name: '케이크3', svgPath: 'assets/system/sticker/food/음식_케이크3.svg'),
      Sticker(id: '37', emoji: '', name: '쿠키', svgPath: 'assets/system/sticker/food/음식_쿠키.svg'),
      Sticker(id: '38', emoji: '', name: '토마토', svgPath: 'assets/system/sticker/food/음식_토마토.svg'),
      Sticker(id: '39', emoji: '', name: '토마토2', svgPath: 'assets/system/sticker/food/음식_토마토2.svg'),
      Sticker(id: '40', emoji: '', name: '푸딩', svgPath: 'assets/system/sticker/food/음식_푸딩.svg'),
    ],
    '자연': [
      Sticker(id: '25', emoji: '🎨', name: '미술'),
      Sticker(id: '26', emoji: '🎵', name: '음악'),
      Sticker(id: '27', emoji: '💃', name: '춤'),
    ],
  };

  bool get isSearching => _searchController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() => setState(() {}));

    // 검색창 포커스 시 80%로 확장
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _sheetController.animateTo(
          0.8,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  void _onStickerTap(Sticker sticker) {
    Navigator.pop(context, sticker);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double initialHeight = 400.0;

    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: initialHeight / screenHeight,
      minChildSize: initialHeight / screenHeight,
      maxChildSize: 0.8,
      expand: true,
      builder: (context, scrollController) {
        // 스크롤 시작 시 80%로 확장
        scrollController.addListener(() {
          if (scrollController.offset > 0 &&
              _sheetController.size < 0.8) {
            _sheetController.animateTo(
              0.8,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
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
                color: Color(0x0A000000),
                offset: Offset(0, -4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppTextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      hintText: '검색어를 입력해주세요.',
                      prefixIcon: SvgPicture.asset(
                        'assets/system/icons/icon_search.svg',
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.gray03,
                          BlendMode.srcIn,
                        ),
                      ),
                      suffixIcon: isSearching
                          ? IconButton(
                        icon: SvgPicture.asset(
                          'assets/system/icons/icon_close_big.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.gray04,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )                          : null,
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryTabs(),
                  const SizedBox(height: 16),
                ],
              ),

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
                            SvgPicture.asset(
                              'assets/system/icons/icon_image_not_supported.svg',
                              width: 64,
                              height: 64,
                              colorFilter: const ColorFilter.mode(
                                AppColors.gray03,
                                BlendMode.srcIn,
                              ),
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
                            child: sticker.svgPath != null
                                ? SvgPicture.asset(
                              sticker.svgPath!,
                              width: 64,
                              height: 64,
                            )
                                : Text(
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          // ✕ 엑스: Navigator.pop (반환값 없음 = 취소)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/system/icons/icon_close_big.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.f05,
                BlendMode.srcIn,
              ),
            ),
          ),

          // 중앙 "스티커" 텍스트
          Expanded(
            child: Center(
              child: Text('스티커', style: AppTextStyle.description14R120),
            ),
          ),

          // ✓ 체크: Navigator.pop (반환값 없음 = 확인)
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/system/icons/icon_check.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.f05,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _tabController.index == index;
            return GestureDetector(
              onTap: () => _tabController.animateTo(index),
              child: Container(
                margin: EdgeInsets.only(
                  right: index < _categories.length - 1 ? 12 : 0,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isSelected ? AppColors.f05 : AppColors.f02,
                    width: 1.5,
                  ),
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
    );
  }
}