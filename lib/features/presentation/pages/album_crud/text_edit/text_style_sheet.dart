import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/font/app_fonts_style_suit.dart';

/// 폰트 정보 모델
class FontItem {
  final String label;       // 박스 안에 표시할 텍스트
  final String fontFamily;  // Flutter fontFamily 이름

  const FontItem({required this.label, required this.fontFamily});
}

/// 폰트 스타일 선택 패널 (토글 방식 — drawing_tool_sheet와 동일 구조)
class TextStylePanel extends StatefulWidget {
  final String selectedFontFamily;
  final TextAlign selectedTextAlign;
  final ValueChanged<String> onTextFamilyChanged;
  final ValueChanged<TextAlign>? onTextAlignChanged;
  final VoidCallback onClose;

  const TextStylePanel({
    Key? key,
    required this.selectedFontFamily,
    this.selectedTextAlign = TextAlign.left,
    required this.onTextFamilyChanged,
    this.onTextAlignChanged,
    required this.onClose,
  }) : super(key: key);

  // 외부에서 TextStylePanel.fonts 로 접근 가능
  static const List<FontItem> fonts = [
    FontItem(label: '프리텐다드',             fontFamily: 'Pretendard'),
    FontItem(label: '프리텐다드',             fontFamily: 'Pretendard'),
    FontItem(label: 'Memoment\nKkukkukk',   fontFamily: 'MemomentKkukkukk'),
    FontItem(label: 'Hubbell',               fontFamily: 'Soap'),
    FontItem(label: 'IMPACT',                fontFamily: 'Impact'),
    FontItem(label: '박다현체',               fontFamily: 'Dahyun'),
    FontItem(label: '김씨손맛',               fontFamily: 'Kimsonmas'),
    FontItem(label: 'BM꾸불림',              fontFamily: 'BMKkubulim'),
    FontItem(label: '북크명조',               fontFamily: 'BookkMyungjo'),
    FontItem(label: 'Cafe24\nPROUP',         fontFamily: 'Cafe24Proup'),
    FontItem(label: 'Caveat',                fontFamily: 'Caveat'),
    FontItem(label: 'Indie\nFlower',         fontFamily: 'IndieFlower'),
    FontItem(label: '태백\n은하수',           fontFamily: 'TAEBAEK'),
    FontItem(label: 'Titan\nOne',            fontFamily: 'TitanOne'),
    FontItem(label: '윤아이',                 fontFamily: 'YoonChild'),
    FontItem(label: 'Zen\nSerif',            fontFamily: 'ZenSerif'),
    FontItem(label: '고령딸기',               fontFamily: 'Goryung'),
    FontItem(label: '만년설체',               fontFamily: 'Mannyunsul'),
  ];

  @override
  State<TextStylePanel> createState() => _FontStylePanelState();
}

class _FontStylePanelState extends State<TextStylePanel> {
  late String _selectedFamily;
  late TextAlign _selectedAlign;

  @override
  void initState() {
    super.initState();
    _selectedFamily = widget.selectedFontFamily;
    _selectedAlign = widget.selectedTextAlign;
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: _buildHandle(),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: _buildFontGrid(),
            ),
          ),
        ],
      ),
    );
  }

  // ── 핸들 바 (x / 폰트 스타일 / v) ──
  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Row(
        children: [
          // ✕ 닫기
          GestureDetector(
            onTap: widget.onClose,
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

          Expanded(
            child: Center(
              child: Text(
                '폰트 스타일',
                style: AppTextStyle.description14R120,
              ),
            ),
          ),

          // ✕ 아이콘과 좌우 대칭을 맞추기 위한 빈 공간
          const SizedBox(width: 24),
        ],
      ),
    );
  }


  // ── 폰트 그리드 (반응형 wrap) ──
  Widget _buildFontGrid() {
    const double gap = 16;
    const int columns = 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - gap * (columns - 1)) / columns;
        final itemHeight = itemWidth * (42 / 75); // 원래 비율 42:75 유지

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: TextStylePanel.fonts.map((font) {
            final isSelected = _selectedFamily == font.fontFamily;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedFamily = font.fontFamily);
                widget.onTextFamilyChanged(font.fontFamily);
                widget.onClose();
              },
              child: Container(
                width: itemWidth,
                height: itemHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected ? AppColors.main : AppColors.gray01,
                    width: isSelected ? 1.5 : 1,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    font.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: font.fontFamily,
                      fontSize: itemWidth * 0.13,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.2,
                      color: const Color(0xFF505050),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}