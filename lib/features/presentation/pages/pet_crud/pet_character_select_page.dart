/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_custom_button.dart';
import 'package:petAblumMobile/core/widgets/common_app_back_bar_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/main/main_shell.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_character_grid_page.dart';
import 'package:petAblumMobile/features/presentation/pages/pet_crud/pet_list.dart';

class PetCharacterIntroPage extends StatelessWidget {
  final bool isFromMyPage;
  const PetCharacterIntroPage({super.key, this.isFromMyPage = false});

  void _goToDestination(BuildContext context) {
    if (isFromMyPage) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PetListPage()),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonBackAppBar(title: '캐릭터 생성'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '반려동물 캐릭터를\n선택해주세요.',
                      style: AppTextStyle.titlePage28Sb130.copyWith(color: AppColors.f05),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '우리아이와 가장 닮은 캐릭터를 골라보세요!',
                      style: AppTextStyle.body16R120.copyWith(color: AppColors.f04),
                    ),
                    const Spacer(),
                    Center(
                      child: SvgPicture.asset(
                        'assets/system/dumy/main1.svg',
                        width: 270,
                        height: 270,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => SkipDialog.show(
                        context: context,
                        onSkip: () => _goToDestination(context),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.gray02),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 55),
                      ),
                      child: Text(
                        '건너뛰기',
                        style: AppTextStyle.body16M120.copyWith(color: AppColors.f05),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetCharacterGridPage(
                            isFromMyPage: isFromMyPage,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        minimumSize: const Size(double.infinity, 55),
                      ),
                      child: Text(
                        '캐릭터 생성',
                        style: AppTextStyle.body16M120.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

다음 개발때 사용
 */