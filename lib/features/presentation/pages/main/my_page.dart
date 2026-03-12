import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_common_button_styles.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/core/widgets/pet_card.dart';
import 'package:petAblumMobile/features/presentation/pages/main/settings/settings_page.dart';
import 'package:petAblumMobile/features/presentation/pages/auth/guardian_info_page.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final TextEditingController _foodController = TextEditingController();
  int _currentPage = 0;
  bool _isForward = true;
  late final PageController _pageController = PageController(
    viewportFraction: 0.88,
  );

  // 더미 펫 데이터 리스트
  final List<Map<String, dynamic>> _pets = [
    {
      'imageUrl': 'assets/system/logo/logo.png',
      'name': '또또 (2세)',
      'species': '말티즈',
      'personality': ['코지', '예민함', '물어요', '손조심'],
      'favoriteToy': '목욕',
      'sex': '수컷',
      'birth': '2025.01.02',
      'petFamily': '또또네 가족',
      'traits': ['큰소리 주의', '이물질 섭취 주위 필요', '입질경험있음', '분리불안'],
      'health': ['관절문제있음', '슬개골문제 있음', '피부문제있음'],
      'medicine': ['없음'],
    },
    {
      'imageUrl': 'assets/system/logo/logo.png',
      'name': '콩이 (1세)',
      'species': '포메라니안',
      'personality': ['활동가', '애교쟁이', '산책광'],
      'favoriteToy': '공놀이',
      'sex': '암컷',
      'birth': '2024.03.15',
      'petFamily': '또또네 가족',
      'traits': ['낯선사람 주의', '소심한'],
      'health': ['없음'],
      'medicine': ['없음'],
    },
  ];

  @override
  void dispose() {
    _foodController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CommonMainAppBar(
        title: "마이페이지",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/system/icons/icon_settings.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // 반려동물 프로필 사진
              Column(
                children: [
                  Center(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/system/logo/logo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.pets, size: 60, color: AppColors.f01);
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('조혜원', style: AppTextStyle.subtitle20Sb120),
                  const SizedBox(height: 8),
                  Text('또또네 가족', style: AppTextStyle.description14R120.copyWith(color: AppColors.f04)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 99,
                    height: 41,
                    child: ElevatedButton(
                      style: AppButtonStyles.base(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.gray01,
                      ).copyWith(
                        elevation: WidgetStateProperty.all(2),
                        shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(0.08)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        side: WidgetStateProperty.all(BorderSide.none),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GuardianInfoPage()),
                        );
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '내 정보 수정',
                          style: AppTextStyle.description14R120.copyWith(color: AppColors.f05),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 스와이프 가능한 펫 카드 + 반려동물 정보
              // 스와이프 가능한 펫 카드 + 반려동물 정보
              // 스와이프 가능한 펫 카드 + 반려동물 정보
              SizedBox(
                height: _getPetSectionHeight(_currentPage),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pets.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: _buildPetSection(_pets[index], index),
                    );
                  },
                ),
              ),

              // 페이지 인디케이터
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pets.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? AppColors.main : AppColors.gray02,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('반려동물', style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text('내 앨범', style: AppTextStyle.body16M120.copyWith(color: AppColors.f04)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text('라이프케어', style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05)),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('라이프케어란?', style: AppTextStyle.body16M120.copyWith(color: AppColors.f04)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getPetSectionHeight(int index) {
    final pet = _pets[index];
    final traitCount = (pet['traits'] as List).length;
    final healthCount = (pet['health'] as List).length;
    final infoHeight = 80.0 + (traitCount * 36.0) + (healthCount * 36.0) + 100.0;
    return 230.0 + infoHeight;
  }

  Widget _buildPetSection(Map<String, dynamic> pet, int index) {
    return Column(
      key: ValueKey(index),
      children: [
        PetCard(
          imageUrl: pet['imageUrl'],
          name: pet['name'],
          species: pet['species'],
          personality: List<String>.from(pet['personality']),
          favoriteToy: pet['favoriteToy'],
          sex: pet['sex'],
          birth: pet['birth'],
          petFamily: pet['petFamily'],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PetListPage()));
          },
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('반려동물 정보', style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05)),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 60, child: Padding(padding: const EdgeInsets.fromLTRB(4, 7.5, 5, 7.5), child: Text('성향', style: AppTextStyle.caption12R120.copyWith(color: AppColors.f03)))),
                  const SizedBox(width: 12),
                  Expanded(child: Wrap(spacing: 6, runSpacing: 6, children: List<String>.from(pet['traits']).map((t) => _buildChip(t)).toList())),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 60, child: Padding(padding: const EdgeInsets.fromLTRB(4, 7.5, 5, 7.5), child: Text('건강', style: AppTextStyle.caption12R120.copyWith(color: AppColors.f03)))),
                  const SizedBox(width: 12),
                  Expanded(child: Wrap(spacing: 8, runSpacing: 8, children: List<String>.from(pet['health']).map((h) => _buildChip(h)).toList())),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 60, child: Padding(padding: const EdgeInsets.fromLTRB(4, 7.5, 5, 7.5), child: Text('복용약', style: AppTextStyle.caption12R120.copyWith(color: AppColors.f03)))),
                  const SizedBox(width: 12),
                  Expanded(child: Wrap(spacing: 8, runSpacing: 8, children: List<String>.from(pet['medicine']).map((m) => _buildChip(m)).toList())),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.gray01, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: AppTextStyle.description14R120.copyWith(color: AppColors.f05)),
    );
  }
}