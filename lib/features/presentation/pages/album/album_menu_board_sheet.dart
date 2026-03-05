import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/album_edit_form.dart';

class MenuBottomSheet extends StatelessWidget {
  final String petName;
  final VoidCallback onEdit;
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onBookmark;
  final VoidCallback onDelete;
  final bool isBookmarked;

  const MenuBottomSheet({
    Key? key,
    required this.petName,
    required this.onEdit,
    required this.onCopy,
    required this.isBookmarked,
    required this.onShare,
    required this.onBookmark,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.f01,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  petName,
                  style: AppTextStyle.subtitle20Sb120,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _MenuItem(
              icon: Icons.edit_outlined,
              label: '편집',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AlbumEditFormPage(),
                  ),
                );
              },
            ),
            _MenuItem(
              icon: Icons.copy_outlined,
              label: '복사',
              onTap: () {
                Navigator.pop(context);
                onCopy();
              },
            ),
            _MenuItem(
              icon: Icons.share_outlined,
              label: '공유',
              onTap: () {
                Navigator.pop(context);
                onShare();
              },
            ),
            _MenuItem(
              icon: isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              label: '북마크',
              onTap: () {
                Navigator.pop(context);
                onBookmark();
              },
            ),
            _MenuItem(
              icon: Icons.delete_outline,
              label: '삭제',
              isDelete: true,
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String petName,
    required VoidCallback onEdit,
    required VoidCallback onCopy,
    required bool isBookmarked,
    required VoidCallback onShare,
    required VoidCallback onBookmark,
    required VoidCallback onDelete,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MenuBottomSheet(
        petName: petName,
        onEdit: onEdit,
        onCopy: onCopy,
        onShare: onShare,
        isBookmarked: isBookmarked,
        onBookmark: onBookmark,
        onDelete: onDelete,
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDelete;

  const _MenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDelete = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isDelete ? Colors.red : AppColors.f05,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppTextStyle.body16R120.copyWith(
                color: isDelete ? Colors.red : AppColors.f05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}