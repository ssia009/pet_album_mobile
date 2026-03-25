/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_info_form.dart';

class PetCharacterGridPage extends StatefulWidget {
  final bool isFromMyPage;
  const PetCharacterGridPage({
    super.key,
    this.isFromMyPage = false,
  });

  @override
  State<PetCharacterGridPage> createState() => _PetCharacterGridPageState();
}

class _PetCharacterGridPageState extends State<PetCharacterGridPage> {
  int _tabIndex = 0;
  String? _selectedDog;
  String? _selectedCat;

  String? get _selectedCharacter => _tabIndex == 0 ? _selectedDog : _selectedCat;

  static const List<Map<String, String>> _dogs = [
    {'name': '아프간하운드', 'file': 'afghan_hound'},
    {'name': '알래스카 말라뮤트', 'file': 'alaskan_malamute'},
    {'name': '바셋하운드', 'file': 'basset_hound'},
    {'name': '비글', 'file': 'beagle'},
    {'name': '베들링턴 테리어', 'file': 'bedlington_terrier'},
    {'name': '버니즈 마운틴', 'file': 'bernese_mountain'},
    {'name': '비숑 프리제', 'file': 'bichon_frise'},
    {'name': '블랙 그레이하운드', 'file': 'black_greyhound'},
    {'name': '보더 콜리', 'file': 'border_collie'},
    {'name': '불 테리어', 'file': 'bull_terrier'},
    {'name': '불독', 'file': 'bulldog'},
    {'name': '카발리에', 'file': 'cavalier_king_charles_spaniel'},
    {'name': '치와와', 'file': 'chihuahua'},
    {'name': '차우차우', 'file': 'chow_chow'},
    {'name': '코커 스패니얼', 'file': 'cocker_spaniel'},
    {'name': '닥스훈트', 'file': 'dachshund'},
    {'name': '달마시안', 'file': 'dalmatian'},
    {'name': '골든 리트리버', 'file': 'golden_retriever'},
    {'name': '그레이하운드', 'file': 'greyhound'},
    {'name': '하바네즈', 'file': 'havanese'},
    {'name': '허스키', 'file': 'husky'},
    {'name': '진도', 'file': 'jindo'},
    {'name': '래브라도 리트리버', 'file': 'labrador_retriever'},
    {'name': '말티즈', 'file': 'maltese'},
    {'name': '파피용', 'file': 'papillon'},
    {'name': '핀셔', 'file': 'pinscher'},
    {'name': '핏불', 'file': 'pitbull'},
    {'name': '포메라니안', 'file': 'pomeranian'},
    {'name': '푸들', 'file': 'poodle'},
    {'name': '퍼그', 'file': 'pug'},
    {'name': '사모예드', 'file': 'samoyed'},
    {'name': '슈나우저', 'file': 'schnauzer'},
    {'name': '샤페이', 'file': 'shar_pei'},
    {'name': '셸티', 'file': 'sheltie'},
    {'name': '셰퍼드', 'file': 'shepherd'},
    {'name': '시바', 'file': 'shiba'},
    {'name': '시츄', 'file': 'shih_tzu'},
    {'name': '비즐라', 'file': 'vizsla'},
    {'name': '웰시코기', 'file': 'welsh_corgi'},
    {'name': '요크셔 테리어', 'file': 'yorkshire_terrier'},
  ];

  static const List<Map<String, String>> _cats = [
    {'name': '아비시니안', 'file': 'abyssinian'},
    {'name': '아메리칸 숏헤어', 'file': 'american_shorthair'},
    {'name': '벵갈', 'file': 'bengal'},
    {'name': '버만', 'file': 'birman'},
    {'name': '봄베이', 'file': 'bombay'},
    {'name': '브리티시 숏헤어', 'file': 'british_shorthair'},
    {'name': '캘리코', 'file': 'calico'},
    {'name': '이그조틱 숏헤어', 'file': 'exotic_shorthair'},
    {'name': '카오 마니', 'file': 'khao_manee'},
    {'name': '코리안 숏헤어', 'file': 'korean_shorthair'},
    {'name': '메인쿤', 'file': 'maine_coon'},
    {'name': '노르웨이 숲', 'file': 'norwegian_forest'},
    {'name': '오렌지 태비', 'file': 'orange_tabby'},
    {'name': '오리엔탈 숏헤어', 'file': 'oriental_shorthair'},
    {'name': '페르시안', 'file': 'persian'},
    {'name': '래그돌', 'file': 'ragdoll'},
    {'name': '사바나', 'file': 'savannah'},
    {'name': '스코티시', 'file': 'scottish'},
    {'name': '스코티시 폴드', 'file': 'scottish_fold'},
    {'name': '샴', 'file': 'siamese'},
    {'name': '스핑크스', 'file': 'sphynx'},
    {'name': '터키시 앙고라', 'file': 'turkish_angora'},
    {'name': '터키시 반', 'file': 'turkish_van'},
    {'name': '턱시도', 'file': 'tuxedo'},
  ];

  List<Map<String, String>> get _currentList {
    final list = _tabIndex == 0 ? _dogs : _cats;
    return [...list]..sort((a, b) => a['name']!.compareTo(b['name']!));
  }

  String get _basePath => _tabIndex == 0
      ? 'assets/system/pet_character/dog/basic_dog'
      : 'assets/system/pet_character/cat/basic_cat';

  @override
  void initState() {
    super.initState();
    final sortedDogs = [..._dogs]..sort((a, b) => a['name']!.compareTo(b['name']!));
    final sortedCats = [..._cats]..sort((a, b) => a['name']!.compareTo(b['name']!));
    _selectedDog = sortedDogs.first['file'];
    _selectedCat = sortedCats.first['file'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.f05, size: 20),
        ),
        title: Text(
          '캐릭터 선택',
          style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _selectedCharacter != null
                ? () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PetInfoEditor(
                  isFromMyPage: widget.isFromMyPage,
                ),
              ),
            )
                : null,
            child: Text(
              '완료',
              style: AppTextStyle.body16M120.copyWith(
                color: _selectedCharacter != null ? AppColors.f05 : AppColors.f03,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 273,
            color: Colors.white,
            child: Center(
              child: _selectedCharacter != null
                  ? SvgPicture.asset(
                '$_basePath/$_selectedCharacter.svg',
                width: 200,
                height: 191,
                fit: BoxFit.contain,
              )
                  : const SizedBox(width: 200, height: 191),
            ),
          ),

          Container(
            color: AppColors.bg,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Row(
              children: [
                _TabButton(
                  label: '강아지',
                  isSelected: _tabIndex == 0,
                  onTap: () => setState(() => _tabIndex = 0),
                ),
                const SizedBox(width: 16),
                _TabButton(
                  label: '고양이',
                  isSelected: _tabIndex == 1,
                  onTap: () => setState(() => _tabIndex = 1),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.white,
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 44),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.06,
                ),
                itemCount: _currentList.length,
                itemBuilder: (context, index) {
                  final item = _currentList[index];
                  final isSelected = _selectedCharacter == item['file'];
                  return _CharacterCard(
                    name: item['name']!,
                    imagePath: '$_basePath/${item['file']}.svg',
                    isSelected: isSelected,
                    onTap: () => setState(() {
                      if (_tabIndex == 0) {
                        _selectedDog = item['file'];
                      } else {
                        _selectedCat = item['file'];
                      }
                    }),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyle.body16M120.copyWith(
          color: isSelected ? AppColors.f05 : AppColors.f02,
        ),
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _CharacterCard({
    required this.name,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 106,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.main : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                imagePath,
                width: 80,
                height: 76,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 0),
              Text(
                name,
                style: AppTextStyle.caption12R120.copyWith(
                  color: AppColors.f05,
                  letterSpacing: -0.18,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  다음 개발떄 사용
 */