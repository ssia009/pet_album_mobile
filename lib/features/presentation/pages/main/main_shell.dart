import 'package:flutter/cupertino.dart';
import 'package:petAblumMobile/core/widgets/common_navigation_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/album/album_page.dart';
import 'package:petAblumMobile/features/presentation/pages/main/home_page.dart';
import 'package:petAblumMobile/features/presentation/pages/main/my_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  static final GlobalKey<_MainShellState> navigatorKey = GlobalKey<_MainShellState>();

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void setTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return CommonNavigationScaffold(
      key: MainShell.navigatorKey,
      currentIndex: _index,
      onTap: (i) => setState(() => _index = i),
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          AlbumPage(),
          MyPage(),
        ],
      ),
    );
  }
}