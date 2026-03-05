// album_common_actions.dart
import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/widgets/delete_modal.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_menu_board_sheet.dart';

// Mock 데이터
final List<Map<String, String>> mockAlbums = List.generate(
  10,
      (index) => {
    'id': 'pet_$index',
    'title': '우리 강아지 $index',
    'imageUrl': 'assets/system/logo/logo.png',
    'isBookmarked': index == 6 ? 'true' : 'false',
  },
);

// 헬퍼 함수들
void showAlbumMenu({
  required BuildContext context,
  required String petName,
  required String petId,
  required bool isBookmarked,
  required VoidCallback onBookmarkToggle,
  required VoidCallback onDelete,
}) {
  MenuBottomSheet.show(
    context: context,
    petName: petName,
    onEdit: () {},
    isBookmarked: isBookmarked,
    onCopy: () {},
    onShare: () {},
    onBookmark: onBookmarkToggle,
    onDelete: onDelete,
  );
}

void showDeleteAlbumDialog({
  required BuildContext context,
  required String petName,
  required VoidCallback onConfirm,
}) {
  DeleteConfirmDialog.show(
    context: context,
    content: '$petName을(를) 삭제하시겠습니까?',
    onConfirm: onConfirm,
  );
}