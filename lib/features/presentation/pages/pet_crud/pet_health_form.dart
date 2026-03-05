import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/app_out_button.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart' show AppColors;
import 'package:petAblumMobile/features/presentation/pages/main/main_shell.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_personality_form.dart';

class PetHealthEditor extends StatefulWidget {
  const PetHealthEditor({super.key});

  @override
  State<PetHealthEditor> createState() => _PetHealthState();
}

class _PetHealthState extends State<PetHealthEditor> {
  final Map<int, String?> _answers = {};

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  bool get _isFormValid =>
      _answers[1] != null &&
          _answers[2] != null &&
          _answers[3] != null;

  void _onAnswerSelected(int questionIndex, String answer) {
    setState(() => _answers[questionIndex] = answer);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
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

                    _QuestionText(1, '현재 반려동물에게 관절 질환이 있나요?'),
                    const SizedBox(height: 16),
                    _AnswerGroup(
                      selectedAnswer: _answers[1],
                      onAnswerSelected: (answer) => _onAnswerSelected(1, answer),
                      controller: _controller1,
                      exampleText: '예) 관절염',
                    ),
                    const SizedBox(height: 32),

                    _QuestionText(2, '현재 반려동물에게 피부 질환이 있나요?'),
                    const SizedBox(height: 16),
                    _AnswerGroup(
                      selectedAnswer: _answers[2],
                      onAnswerSelected: (answer) => _onAnswerSelected(2, answer),
                      controller: _controller2,
                      exampleText: '예) 아토피',
                    ),
                    const SizedBox(height: 32),

                    _QuestionText(3, '산책이나 돌봄 시\n건강상 특별히 주의해야 할 점이 있나요?'),
                    const SizedBox(height: 8),
                    Text(
                      '앞선 내용 외에, 산택이나 돌봄 시 행동, 환경 측면에서\n더 알려주고 싶은 점이 있다면 작성해주세요.',
                      style: AppTextStyle.description14R120.copyWith(
                        color: AppColors.f01,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AnswerGroup(
                      selectedAnswer: _answers[3],
                      onAnswerSelected: (answer) => _onAnswerSelected(3, answer),
                      controller: _controller3,
                      exampleText: '예) 체력이 약해 중간중간 휴식이 필요해요.',
                    ),

                    const SizedBox(height: 80),
                    _QuestionText(4, '산책이나 돌봄 시 행동 / 환경 측면에서\n주의할 점이 있나요?'),
                    const SizedBox(height: 16),
                    _AnswerGroup(
                      selectedAnswer: _answers[4],
                      onAnswerSelected: (answer) => _onAnswerSelected(3, answer),
                      controller: _controller3,
                      exampleText: '예) 간식을 뺏고 있었던 물니다',
                    ),

                    const SizedBox(height: 80),

                  ],
                ),
              ),
            ),
            _BottomActionButton(
              isActive: _isFormValid,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MainShell()));
              },
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
      '반려동물의 성향을\n알려주세요.',
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

class _QuestionText extends StatelessWidget {
  final int number;
  final String text;

  const _QuestionText(this.number, this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$number. $text',
      style: AppTextStyle.body16M120.copyWith(
        color: AppColors.f01,
        height: 1.4,
      ),
    );
  }
}


class _AnswerGroup extends StatelessWidget {
  final String? selectedAnswer;
  final ValueChanged<String> onAnswerSelected;
  final TextEditingController controller;
  final String exampleText;

  const _AnswerGroup({
    required this.selectedAnswer,
    required this.onAnswerSelected,
    required this.controller,
    required this.exampleText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AnswerOption(
          text: '있어요.',
          isSelected: selectedAnswer == '있어요',
          onTap: () => onAnswerSelected('있어요'),
        ),
        const SizedBox(height: 12),

        _InputField(
          controller: controller,
          hint: exampleText,
          enabled: selectedAnswer == '있어요',
        ),
        const SizedBox(height: 12),

        _AnswerOption(
          text: '없어요.',
          isSelected: selectedAnswer == '없어요',
          onTap: () => onAnswerSelected('없어요'),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool enabled;

  const _InputField({
    required this.controller,
    required this.hint,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: enabled ? AppColors.f01 : AppColors.f01,
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

class _AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.f01 : AppColors.f01,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: AppTextStyle.body16M120.copyWith(
                color: isSelected ? AppColors.f01 : AppColors.f01,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.f01,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.f01, width: 1.5),
                  shape: BoxShape.circle,
                ),
              ),
          ],
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