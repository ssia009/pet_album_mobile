import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_button_theme.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_text_semantic.dart';
import 'package:petAblumMobile/core/widgets/app_text_field.dart';
import 'package:petAblumMobile/features/presentation/pages/auth/guardian_info_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // 생년월일
  int _yearIndex = 40; // 1950+40 = 1990 기본값
  int _monthIndex = 0;
  int _dayIndex = 0;
  bool _showBirthPicker = false;
  bool _birthConfirmed = false;

  static const int _startYear = 1950;
  static const int _endYear = 2026;

  final List<String> _years = List.generate(
      _endYear - _startYear + 1, (i) => '${_startYear + i}');
  final List<String> _months =
  List.generate(12, (i) => '${(i + 1).toString().padLeft(2, '0')}');

  List<String> get _days {
    final year = _startYear + _yearIndex;
    final month = _monthIndex + 1;
    final count = DateTime(year, month + 1, 0).day;
    return List.generate(count, (i) => '${(i + 1).toString().padLeft(2, '0')}');
  }

  String get _birthDisplayText {
    if (!_birthConfirmed) return '생년월일을 선택해주세요.';
    final year = _startYear + _yearIndex;
    final month = (_monthIndex + 1).toString().padLeft(2, '0');
    final day = (_dayIndex + 1).toString().padLeft(2, '0');
    return '$year년 $month월 $day일';
  }

  bool get _isFormFilled =>
      _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _birthConfirmed;

  @override
  void initState() {
    super.initState();
    _idController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _isFormFilled;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('회원가입',
            style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05)),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: SvgPicture.asset(
              'assets/system/icons/icon_chevron_right.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final hPad = width * 0.06;
            final btnSmallWidth = width * 0.27;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // 아이디
                        Text('아이디', style: AppText.body12m),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: _idController,
                                hintText: '아이디를 입력하세요.',
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: btnSmallWidth,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: AppButtonTheme.elevated.style,
                                child: const Text('중복확인'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '사용가능한 아이디입니다.',
                            style: AppTextStyle.caption12R120
                                .copyWith(color: AppColors.f05),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // 비밀번호
                        Text('비밀번호', style: AppText.body12m),
                        const SizedBox(height: 8),
                        AppTextField(
                          controller: _passwordController,
                          hintText: '비밀번호를 입력해 주세요.',
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              _obscurePassword
                                  ? 'assets/system/icons/icon_visibility_off.svg'
                                  : 'assets/system/icons/icon_visibility.svg',
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.f03, BlendMode.srcIn),
                            ),
                            onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 이름
                        Text('이름', style: AppText.body12m),
                        const SizedBox(height: 8),
                        AppTextField(
                            controller: _nameController,
                            hintText: '이름을 작성해 주세요.'),
                        const SizedBox(height: 20),

                        // 이메일
                        Text('이메일', style: AppText.body12m),
                        const SizedBox(height: 8),
                        AppTextField(
                            controller: _emailController,
                            hintText: '이메일을 입력해주세요.'),
                        const SizedBox(height: 20),

                        // 생년월일
                        Text('생년월일', style: AppText.body12m),
                        const SizedBox(height: 8),
                        _BirthPickerField(
                          displayText: _birthDisplayText,
                          isConfirmed: _birthConfirmed,
                          isOpen: _showBirthPicker,
                          years: _years,
                          months: _months,
                          days: _days,
                          yearIndex: _yearIndex,
                          monthIndex: _monthIndex,
                          dayIndex: _dayIndex,
                          onToggle: () =>
                              setState(() => _showBirthPicker = !_showBirthPicker),
                          onYearChanged: (i) => setState(() {
                            _yearIndex = i;
                            // 일 범위 초과 보정
                            if (_dayIndex >= _days.length) {
                              _dayIndex = _days.length - 1;
                            }
                          }),
                          onMonthChanged: (i) => setState(() {
                            _monthIndex = i;
                            if (_dayIndex >= _days.length) {
                              _dayIndex = _days.length - 1;
                            }
                          }),
                          onDayChanged: (i) => setState(() => _dayIndex = i),
                          onConfirm: () => setState(() {
                            _birthConfirmed = true;
                            _showBirthPicker = false;
                          }),
                        ),
                        const SizedBox(height: 20),

                        // 전화번호
                        Text('전화번호', style: AppText.body12m),
                        const SizedBox(height: 8),
                        Container(
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.gray01,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [_PhoneNumberFormatter()],
                            style: AppTextStyle.body16M120.copyWith(color: AppColors.f05),
                            decoration: InputDecoration(
                              hintText: '전화번호를 입력해주세요.',
                              hintStyle: AppTextStyle.body16M120.copyWith(color: AppColors.f03),
                              border: InputBorder.none,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // 하단 버튼
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: isActive
                          ? AppButtonTheme.elevated.style
                          : AppButtonTheme.inactive_btn.style,
                      onPressed: isActive
                          ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const GuardianInfoPage()))
                          : null,
                      child: const Text('회원가입'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// 생년월일 필드 + 인라인 드럼롤 피커
// ─────────────────────────────────────────────────

class _BirthPickerField extends StatelessWidget {
  final String displayText;
  final bool isConfirmed;
  final bool isOpen;
  final List<String> years;
  final List<String> months;
  final List<String> days;
  final int yearIndex;
  final int monthIndex;
  final int dayIndex;
  final VoidCallback onToggle;
  final ValueChanged<int> onYearChanged;
  final ValueChanged<int> onMonthChanged;
  final ValueChanged<int> onDayChanged;
  final VoidCallback onConfirm;

  const _BirthPickerField({
    required this.displayText,
    required this.isConfirmed,
    required this.isOpen,
    required this.years,
    required this.months,
    required this.days,
    required this.yearIndex,
    required this.monthIndex,
    required this.dayIndex,
    required this.onToggle,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.onDayChanged,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 텍스트 표시 행 (탭하면 피커 토글) — 어디 눌러도 열림
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.gray01,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                displayText,
                style: AppTextStyle.body16M120.copyWith(
                  color: isConfirmed ? AppColors.f05 : AppColors.f03,
                ),
              ),
            ),
          ),
        ),

        // 드럼롤 피커 (isOpen 시 노출)
        if (isOpen)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 선택 강조 배경
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 44,
                          color: AppColors.gray02.withOpacity(0.4),
                        ),
                      ),
                      Row(
                        children: [
                          // 년
                          Expanded(
                            flex: 3,
                            child: _DrumrollPicker(
                              key: ValueKey('year_$yearIndex'),
                              items: years,
                              selectedIndex: yearIndex,
                              onChanged: onYearChanged,
                              suffix: '년',
                            ),
                          ),
                          // 월
                          Expanded(
                            flex: 2,
                            child: _DrumrollPicker(
                              key: const ValueKey('month'),
                              items: months,
                              selectedIndex: monthIndex,
                              onChanged: onMonthChanged,
                              suffix: '월',
                            ),
                          ),
                          // 일
                          Expanded(
                            flex: 2,
                            child: _DrumrollPicker(
                              key: ValueKey('day_${days.length}'),
                              items: days,
                              selectedIndex: dayIndex.clamp(0, days.length - 1),
                              onChanged: onDayChanged,
                              suffix: '일',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 완료 버튼
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.gray02, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          '완료',
                          style: AppTextStyle.body16M120
                              .copyWith(color: AppColors.f05),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────
// _DrumrollPicker (pet_health_form.dart 와 동일 구조)
// ─────────────────────────────────────────────────

class _DrumrollPicker extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final String suffix;

  const _DrumrollPicker({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.suffix = '',
  });

  @override
  State<_DrumrollPicker> createState() => _DrumrollPickerState();
}

class _DrumrollPickerState extends State<_DrumrollPicker> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        FixedExtentScrollController(initialItem: widget.selectedIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: _controller,
      itemExtent: 44,
      onSelectedItemChanged: widget.onChanged,
      selectionOverlay: const SizedBox.shrink(),
      children: widget.items.map((item) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item,
                style: AppTextStyle.subtitle20M120.copyWith(
                  color: AppColors.f05,
                ),
              ),
              if (widget.suffix.isNotEmpty) ...[
                const SizedBox(width: 2),
                Text(
                  widget.suffix,
                  style: AppTextStyle.subtitle20M120.copyWith(
                    color: AppColors.f05,
                  ),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────────
// 전화번호 자동 하이픈 포매터
// 010-1234-5678 / 02-123-4567 형식 지원
// ─────────────────────────────────────────────────

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll('-', '');

    if (digits.length > 11) {
      return oldValue;
    }

    final buffer = StringBuffer();

    if (digits.startsWith('02')) {
      // 서울 지역번호: 02-XXX-XXXX or 02-XXXX-XXXX
      if (digits.length <= 2) {
        buffer.write(digits);
      } else if (digits.length <= 5) {
        buffer.write('${digits.substring(0, 2)}-${digits.substring(2)}');
      } else if (digits.length <= 9) {
        buffer.write('${digits.substring(0, 2)}-${digits.substring(2, 5)}-${digits.substring(5)}');
      } else {
        buffer.write('${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6)}');
      }
    } else {
      // 010, 011, 016 등 3자리 국번
      if (digits.length <= 3) {
        buffer.write(digits);
      } else if (digits.length <= 7) {
        buffer.write('${digits.substring(0, 3)}-${digits.substring(3)}');
      } else {
        buffer.write('${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}