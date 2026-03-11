// album_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:petAblumMobile/core/theme/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_grid_item.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_common_actions.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_search_page.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/album_edit_form.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late final List<Map<String, String>> albums;
  bool showOnlyBookmarked = false;

  bool _isSelectMode = false;
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    albums = List.from(mockAlbums);
  }

  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) _selectedIds.clear();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  List<Map<String, String>> get filteredAlbums {
    if (!showOnlyBookmarked) return albums;
    return albums.where((album) => album['isBookmarked'] == 'true').toList();
  }

  void _showSelectMenuSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _SelectMenuSheet(
        onCopy: () { Navigator.pop(context); },
        onShare: () { Navigator.pop(context); },
        onBookmark: () { Navigator.pop(context); },
        onDelete: () {
          Navigator.pop(context);
          setState(() {
            albums.removeWhere((a) => _selectedIds.contains(a['id']));
            _selectedIds.clear();
            _isSelectMode = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _isSelectMode ? _buildSelectAppBar() : _buildNormalAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isSelectMode) ...[
              _buildHeader(),
              const SizedBox(height: 20),
            ],
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const int crossAxisCount = 2;
                  const double crossAxisSpacing = 16.0;
                  const double labelHeight = 24.0;
                  const double gap = 8.0;

                  final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
                  final double itemWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
                  final double imageHeight = itemWidth * 4 / 3;
                  final double childAspectRatio = itemWidth / (imageHeight + gap + labelHeight);

                  return GridView.builder(
                    itemCount: filteredAlbums.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: 20,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) {
                      final album = filteredAlbums[index];
                      final id = album['id']!;
                      return AlbumGridItem(
                        title: album['title']!,
                        imageUrl: album['imageUrl']!,
                        isBookmarked: album['isBookmarked'] == 'true',
                        isSelectMode: _isSelectMode,
                        isSelected: _selectedIds.contains(id),
                        onSelectTap: () => _toggleSelection(id),
                        onTap: () => _handleMenuTap(album['title']!, id, album['isBookmarked'] == 'true'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar() {
    return CommonMainAppBar(
      title: '',
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlbumSearch())),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: SvgPicture.asset(
            'assets/system/icons/icon_search.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
          ),
        ),
        TextButton(
          onPressed: _toggleSelectMode,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.f05,
            minimumSize: const Size(44, 44),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
          ),
          child: Text('선택', style: AppTextStyle.body16R120.copyWith(color: AppColors.f05)),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildSelectAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      actionsPadding: const EdgeInsets.only(right: 20),
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _toggleSelectMode,
              child: SvgPicture.asset(
                'assets/system/icons/icon_back.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 4),
            Text('앨범', style: AppTextStyle.subtitle20M120.copyWith(color: AppColors.f05)),
          ],
        ),
      ),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed: _toggleSelectMode,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.f05,
            minimumSize: const Size(44, 44),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
            overlayColor: Colors.transparent,
          ),
          child: Text('취소', style: AppTextStyle.body16R120.copyWith(color: AppColors.f05)),
        ),
        IconButton(
          onPressed: _showSelectMenuSheet,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.more_horiz, color: AppColors.f05, size: 24),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text('나의 앨범', style: AppTextStyle.titlePage28Sb130.copyWith(color: AppColors.f05)),
        const Spacer(),
        IconButton(
          icon: SvgPicture.asset(
            showOnlyBookmarked
                ? 'assets/system/icons/icon_bookmark_add.svg'
                : 'assets/system/icons/icon_bookmark.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(AppColors.f05, BlendMode.srcIn),
          ),
          onPressed: () => setState(() => showOnlyBookmarked = !showOnlyBookmarked),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlbumEditFormPage())),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(color: AppColors.f05, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            'assets/system/icons/icon_add.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  void _handleMenuTap(String petName, String petId, bool isBookmarked) {
    showAlbumMenu(
      context: context,
      petName: petName,
      petId: petId,
      isBookmarked: isBookmarked,
      onBookmarkToggle: () => _toggleBookmark(petId),
      onDelete: () => _handleDelete(petId, petName),
    );
  }

  void _handleDelete(String petId, String petName) {
    showDeleteAlbumDialog(
      context: context,
      petName: petName,
      onConfirm: () => setState(() => albums.removeWhere((album) => album['id'] == petId)),
    );
  }

  void _toggleBookmark(String petId) {
    setState(() {
      final index = albums.indexWhere((a) => a['id'] == petId);
      if (index != -1) {
        albums[index]['isBookmarked'] = albums[index]['isBookmarked'] == 'true' ? 'false' : 'true';
      }
    });
  }
}

class _SelectMenuSheet extends StatelessWidget {
  final VoidCallback onCopy;
  final VoidCallback onShare;
  final VoidCallback onBookmark;
  final VoidCallback onDelete;

  const _SelectMenuSheet({
    required this.onCopy,
    required this.onShare,
    required this.onBookmark,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.gray02, borderRadius: BorderRadius.circular(2)),
            ),
            _SheetItem(svgPath: 'assets/system/icons/icon_copy.svg', label: '복사', onTap: onCopy),
            _SheetItem(svgPath: 'assets/system/icons/icon_share.svg', label: '공유', onTap: onShare),
            _SheetItem(svgPath: 'assets/system/icons/icon_bookmark.svg', label: '북마크', onTap: onBookmark),
            _SheetItem(svgPath: 'assets/system/icons/icon_delete.svg', label: '삭제', isDelete: true, onTap: onDelete),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _SheetItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onTap;
  final bool isDelete;

  const _SheetItem({
    required this.svgPath,
    required this.label,
    required this.onTap,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDelete ? AppColors.red : AppColors.f05;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(svgPath, width: 24, height: 24, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
            const SizedBox(width: 16),
            Text(label, style: AppTextStyle.body16R120.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}