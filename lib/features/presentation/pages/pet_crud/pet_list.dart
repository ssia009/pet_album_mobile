import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/core/widgets/delete_modal.dart';
import 'package:petAblumMobile/core/widgets/pet_card.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_type_create.dart';

class PetListPage extends StatefulWidget {
  const PetListPage({super.key});

  @override
  State<PetListPage> createState() => _PetListPageState();
}

class _PetListPageState extends State<PetListPage> {
  bool _isDeleteMode = false;
  final Set<int> _selectedPets = {};

  final List<Map<String, dynamic>> _pets = [
    {
      'imageUrl': 'assets/system/logo/logo.png',
      'name': '    또또',
      'species': '말티즈',
      'personality': ['코지', '예민함', '물어요', '손조심'],
      'favoriteToy': '2세',
      'sex': '여아',
      'birth': '2025.01.02',
      'petFamily': '또또네 가족',
      'cardSvg': 'assets/system/pet_card/dog_pet_card.svg',
    },
    {
      'imageUrl': 'assets/system/logo/logo.png',
      'name': '    망고',
      'species': '치즈',
      'personality': ['활동가', '애교쟁이', '산책광'],
      'favoriteToy': '2세',
      'sex': '남아',
      'birth': '2024.03.15',
      'petFamily': '또또네 가족',
      'cardSvg': 'assets/system/pet_card/cat_pet_card.svg',
    },
    {
      'imageUrl': 'assets/system/logo/logo.png',
      'name': '    모모',
      'species': '비숑',
      'personality': ['순둥이', '먹보', '잠꾸러기'],
      'favoriteToy': '3세',
      'sex': '남아',
      'birth': '2023.06.10',
      'petFamily': '또또네 가족',
      'cardSvg': 'assets/system/pet_card/dog_pet_card.svg',
    },
  ];

  void _toggleDeleteMode() {
    setState(() {
      _isDeleteMode = !_isDeleteMode;
      if (!_isDeleteMode) {
        _selectedPets.clear();
      }
    });
  }

  void _togglePetSelection(int index) {
    setState(() {
      if (_selectedPets.contains(index)) {
        _selectedPets.remove(index);
      } else {
        _selectedPets.add(index);
      }
    });
  }

  void _deleteSelectedPets() {
    DeleteConfirmDialog.show(
      context: context,
      content: '${_selectedPets.length}개의 반려동물을 삭제합니다.',
      onConfirm: () {
        setState(() {
          // 나중에 백 연동 시 실제 삭제 처리
          _selectedPets.clear();
          _isDeleteMode = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBackAppBar(
        title: '반려동물 캐릭터 관리',
        actions: _isDeleteMode
            ? [
          TextButton(
            onPressed: _selectedPets.isEmpty ? null : _deleteSelectedPets,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '삭제',
              style: AppTextStyle.description14R120.copyWith(
                color: _selectedPets.isEmpty ? AppColors.gray03 : AppColors.red,
              ),
            ),
          ),
          TextButton(
            onPressed: _toggleDeleteMode,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.only(left: 8, right: 20),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '닫기',
              style: AppTextStyle.description14R120.copyWith(color: AppColors.f05),
            ),
          ),
        ]
            : [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: _toggleDeleteMode,
              icon: SvgPicture.asset(
                'assets/system/icons/icon_delete.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.bg,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ...List.generate(_pets.length, (index) {
            final pet = _pets[index];
            final isSelected = _selectedPets.contains(index);
            return Column(
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
                  cardSvg: pet['cardSvg'] ?? 'assets/system/pet_card/dog_pet_card.svg',
                  isSelected: isSelected,
                  isDeleteMode: _isDeleteMode,
                  onTap: _isDeleteMode ? () => _togglePetSelection(index) : null,
                ),
                if (index < _pets.length - 1) const SizedBox(height: 12),
              ],
            );
          }),
          const SizedBox(height: 24),
          if (!_isDeleteMode) const _AddPetButton(),
        ],
      ),
    );
  }
}

class _AddPetButton extends StatelessWidget {
  const _AddPetButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PetTypCreatePage()),
        );
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/system/icons/icon_add.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}