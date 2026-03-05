import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/app_out_button.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart' show AppColors;
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_personality_form.dart';

class PetInfoEditor extends StatefulWidget {
  const PetInfoEditor({super.key});

  @override
  State<PetInfoEditor> createState() => _PetInfoEditorState();
}

class _PetInfoEditorState extends State<PetInfoEditor> {
  late final TextEditingController _nameController;
  late final TextEditingController _birthController;
  late final TextEditingController _breedController;
  late final TextEditingController _weightController;

  String? _selectedGender;

  bool get _isFormValid =>
      _nameController.text.isNotEmpty &&
          _birthController.text.isNotEmpty &&
          _breedController.text.isNotEmpty &&
          _weightController.text.isNotEmpty &&
          _selectedGender != null;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _nameController = TextEditingController()..addListener(_updateState);
    _birthController = TextEditingController()..addListener(_updateState);
    _breedController = TextEditingController()..addListener(_updateState);
    _weightController = TextEditingController()..addListener(_updateState);
  }

  void _updateState() => setState(() {});

  void _onGenderChanged(String? gender) {
    setState(() => _selectedGender = gender);
  }

  void _navigateToPersonalityEditor() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PetPersonalityEditor(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonBackAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const _TitleText(),
                    const SizedBox(height: 40),
                    const _PetImagePicker(),
                    const SizedBox(height: 24),
                    _Label('이름'),
                    const SizedBox(height: 8),
                    _InputField(
                      controller: _nameController,
                      hint: '이름',
                    ),
                    const SizedBox(height: 20),
                    _Label('성별'),
                    const SizedBox(height: 12),
                    _GenderSelector(
                      selectedGender: _selectedGender,
                      onGenderChanged: _onGenderChanged,
                    ),
                    const SizedBox(height: 20),
                    _Label('생일'),
                    const SizedBox(height: 8),
                    _InputField(
                      controller: _birthController,
                      hint: 'YY/MM/DD',
                    ),
                    const SizedBox(height: 20),
                    _Label('품종'),
                    const SizedBox(height: 8),
                    _InputField(
                      controller: _breedController,
                      hint: '예) 말티즈',
                    ),
                    const SizedBox(height: 20),
                    _Label('몸무게'),
                    const SizedBox(height: 8),
                    _InputField(
                      controller: _weightController,
                      hint: '예) 4.2kg',
                    ),
                    const SizedBox(height: 28),
                    const _OptionalSection(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            _BottomActionButton(
              isActive: _isFormValid,
              onPressed: _navigateToPersonalityEditor,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '반려동물의 기본정보를\n알려주세요.',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.42,
        color: AppColors.f01,
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyle.body16M120);
  }
}

class _OptionalSection extends StatelessWidget {
  const _OptionalSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성향 / 건강상태 (선택)',
          style: AppTextStyle.body16M120.copyWith(
            color: AppColors.f01,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '•',
              style: AppTextStyle.description14R120.copyWith(
                color: AppColors.f01,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                '작성하지 않고 넘어가면,\n일부 서비스 이용에 제한이 있을 수 있어요.',
                style: AppTextStyle.description14R120.copyWith(
                  color: AppColors.f01,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PetImagePicker extends StatelessWidget {
  const _PetImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 138,
      height: 145,
      decoration: BoxDecoration(
        color: AppColors.f01,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(
          Icons.camera_alt_outlined,
          color: AppColors.f01,
          size: 32,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputField({
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.f01,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;

  const _GenderSelector({
    required this.selectedGender,
    required this.onGenderChanged,
  });

  void _handleGenderTap(String gender) {
    final newGender = selectedGender == gender ? null : gender;
    onGenderChanged(newGender);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderButton(
            label: '여아',
            icon: Icons.female,
            isSelected: selectedGender == '여아',
            onTap: () => _handleGenderTap('여아'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _GenderButton(
            label: '남아',
            icon: Icons.male,
            isSelected: selectedGender == '남아',
            onTap: () => _handleGenderTap('남아'),
          ),
        ),
      ],
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.f01 : AppColors.f01;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.f01 : AppColors.f01,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyle.body16M120.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;

  const _BottomActionButton({
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: isActive
          ? AppFilledButton(
        text: '다음',
        onTap: onPressed,
      )
          : AppOutlineButton(
        text: '다음',
        onTap: null,
      ),
    );
  }
}