import 'package:flutter/material.dart';
import 'package:petAblumMobile/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petAblumMobile/core/theme/font/app_fonts_style_suit.dart';
import 'package:petAblumMobile/core/widgets/common_app_bar_main_scaffold.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/text_edit_button_list_box.dart';import 'package:dotted_border/dotted_border.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/background_template_sheet.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/edit/drawing_tool_sheet.dart';
import 'package:petAblumMobile/features/presentation/pages/album_crud/text_edit/text_style_sheet.dart';


class AlbumEditFormPage extends StatefulWidget {
  final Map<String, String>? album;

  const AlbumEditFormPage({super.key, this.album});

  @override
  State<AlbumEditFormPage> createState() => _AlbumEditFormPageState();
}

class _AlbumEditFormPageState extends State<AlbumEditFormPage> {
  bool _isInitialState = true;
  bool _showBackgroundPanel = false;
  bool _showDrawingPanel = false;
  bool _showModalSheet = false;
  bool _isDrawingMode = false;
  String currentTextFamily = 'Pretendard';
  Color currentTextColor = Colors.black;
  TextAlign currentTextAlign = TextAlign.left;
  bool currentTextUnderline = false;
  int? _selectedTextIndex;
  final List<_CanvasText> _canvasTexts = [];

  EditorState _current = EditorState();
  List<EditorState> _history = [];
  List<EditorState> _redoStack = [];

  List<DrawingPoint?> drawingPoints = [];
  String currentLineStyle = '실선';
  double currentLineWidth = 4;
  Color currentColor = const Color(0xFFBDBDBD);
  Offset? _lastDotPoint;

  void _applyState(EditorState newState) {
    setState(() {
      _history.add(_current);
      _redoStack.clear();
      _current = newState;
      _isInitialState = false;
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _redoStack.add(_current);
      _current = _history.last;
      _history.removeLast();
      _isInitialState = _current.drawingPoints.isEmpty
          && _current.background.color == null
          && _current.background.image == null;
    });
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    setState(() {
      _history.add(_current);
      _current = _redoStack.last;
      _redoStack.removeLast();
      _isInitialState = _current.drawingPoints.isEmpty
          && _current.background.color == null
          && _current.background.image == null;
    });
  }

  void _saveToHistory() {
    _history.add(_current);
    _redoStack.clear();
  }

  final TextEditingController _textInputController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  bool _isTextMode = false;

  void _onTextConfirmed() {
    if (_textInputController.text.isNotEmpty) {
      setState(() {
        _canvasTexts.add(_CanvasText(
          text: _textInputController.text,
          fontFamily: currentTextFamily,
          color: currentTextColor,
          textAlign: currentTextAlign,
          isUnderline: currentTextUnderline,
        ));
        _selectedTextIndex = _canvasTexts.length - 1;
      });
    }
    _textInputController.clear();
    _textFocusNode.unfocus();
    setState(() => _isTextMode = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: SizedBox(
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  widget.album?['title'] ?? '새로운 앨범',
                  style: AppTextStyle.subtitle20M120.copyWith(
                    color: AppColors.f05,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _undo,
                      child: SvgPicture.asset(
                        'assets/system/icons/icon_undo.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.f05,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _redo,
                      child: SvgPicture.asset(
                        'assets/system/icons/icon_redo.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.f05,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 40,
                        child: Text(
                          '취소',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.body16R120.copyWith(
                            color: AppColors.f03,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, {
                          'title': widget.album?['title'] ?? '새로운 앨범',
                          'edited': 'true',
                        });
                      },
                      child: SizedBox(
                        width: 40,
                        child: Text(
                          '완료',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.body16R120.copyWith(
                            color: AppColors.f05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          if (_current.background.color != null || _current.background.image != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: _current.background.color,
                  image: _current.background.image != null
                      ? DecorationImage(
                    image: _current.background.image!,
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
              ),
            ),

          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTextIndex = null),
              behavior: HitTestBehavior.translucent,
              child: SafeArea(child: _first()),
            ),
          ),

          // 그린 획 표시 (항상 렌더 - drawingPoints 비어도 위젯 유지)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: DrawingPainter(
                  drawingPoints: _current.drawingPoints,
                ),
              ),
            ),
          ),

          // 그리기 터치 입력 (드로잉 모드일 때만)
          if (_isDrawingMode)
            Positioned.fill(
              child: GestureDetector(
                onPanStart: (details) {
                  final pos = details.localPosition;
                  _saveToHistory();
                  _lastDotPoint = pos;
                  _isInitialState = false;
                  // 첫 터치부터 즉시 포인트 추가 → 백지에서도 바로 렌더
                  setState(() {
                    DrawingPoint mp(Offset o) => DrawingPoint(
                      offset: o,
                      lineStyle: currentLineStyle,
                      paint: Paint()
                        ..color = currentColor
                        ..strokeWidth = currentLineWidth
                        ..strokeCap = StrokeCap.round
                        ..strokeJoin = StrokeJoin.round,
                    );
                    _current = _current.copyWith(
                      drawingPoints: [
                        ..._current.drawingPoints,
                        null,    // 이전 획과 격리
                        mp(pos), // 시작점
                      ],
                    );
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    final pos = details.localPosition;

                    DrawingPoint mp(Offset o) => DrawingPoint(
                      offset: o,
                      lineStyle: currentLineStyle,
                      paint: Paint()
                        ..color = currentColor
                        ..strokeWidth = currentLineWidth
                        ..strokeCap = StrokeCap.round
                        ..strokeJoin = StrokeJoin.round,
                    );

                    if (currentLineStyle == '실선') {
                      _current = _current.copyWith(
                        drawingPoints: [..._current.drawingPoints, mp(pos)],
                      );
                    } else {
                      final gap = currentLineWidth * 4;
                      final dist = (pos - _lastDotPoint!).distance;
                      if (dist >= gap) {
                        _current = _current.copyWith(
                          drawingPoints: [..._current.drawingPoints, mp(pos)],
                        );
                        _lastDotPoint = pos;
                      }
                    }
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    _current = _current.copyWith(
                      drawingPoints: [..._current.drawingPoints, null],
                    );
                    _lastDotPoint = null;
                  });
                },
                child: CustomPaint(
                  painter: DrawingPainter(
                    drawingPoints: _current.drawingPoints,
                  ),
                ),
              ),
            ),

          // 4. 배경 패널
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0, right: 0,
            bottom: _showBackgroundPanel ? 0 : -400,
            child: BackgroundTabletPanel(
              onClose: () => setState(() => _showBackgroundPanel = false),
              onSave: () {
                setState(() => _showBackgroundPanel = false);
              },
              onColorChanged: (color) {
                _applyState(_current.copyWith(
                  background: BackgroundState(color: color),
                ));
              },
            ),
          ),

          ..._canvasTexts.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = _selectedTextIndex == index;
            const handleSize = 24.0;
            const padding = handleSize / 2;

            return Positioned(
              left: item.x - padding,
              top: item.y - padding,
              child: GestureDetector(
                onTap: () => setState(() {
                  if (_selectedTextIndex == index) {
                    _selectedTextIndex = null;
                  } else {
                    _selectedTextIndex = index;
                  }
                }),
                onPanUpdate: (details) {
                  setState(() {
                    item.x += details.delta.dx;
                    item.y += details.delta.dy;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(padding),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: isSelected
                            ? BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        )
                            : BoxDecoration(
                          border: Border.all(color: Colors.transparent, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.text,
                          textAlign: item.textAlign,
                          style: TextStyle(
                            fontSize: item.fontSize,
                            color: item.color,
                            fontFamily: item.fontFamily,
                            decoration: item.isUnderline
                                ? TextDecoration.underline
                                : TextDecoration.none,
                            decorationColor: item.color,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          right: -padding,
                          bottom: -padding,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                item.fontSize = (item.fontSize + details.delta.dx * 0.3).clamp(8, 80);
                              });
                            },
                            child: Container(
                              width: handleSize,
                              height: handleSize,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      if (isSelected)
                        Positioned(
                          right: -padding,
                          top: -padding,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _canvasTexts.removeAt(index);
                                _selectedTextIndex = null;
                              });
                            },
                            child: Container(
                              width: handleSize,
                              height: handleSize,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // 5. 드로잉 툴 패널
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0, right: 0,
            bottom: _showDrawingPanel ? 0 : -500,
            child: DrawingToolPanel(
              onSettingsChanged: (style, width, color) {
                setState(() {
                  currentLineStyle = style;
                  currentLineWidth = width;
                  currentColor = color;
                });
              },
              onClose: () => setState(() {
                _showDrawingPanel = false;
                _isDrawingMode = false;
              }),
            ),
          ),

          if (_isTextMode)
            Positioned(
              left: 40, right: 40, top: 200,
              child: TextField(
                controller: _textInputController,
                focusNode: _textFocusNode,
                autofocus: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: TextStyle(
                  fontFamily: currentTextFamily,
                  fontSize: 16,
                  color: currentTextColor,
                  decoration: currentTextUnderline
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
                textAlign: currentTextAlign,
                decoration: const InputDecoration(
                  hintText: '텍스트 입력',
                  border: InputBorder.none,
                ),
              ),
            ),

          // 6. 하단 아이콘바
          if (!_showBackgroundPanel && !_showDrawingPanel && !_showModalSheet)
            Positioned(
              left: 0, right: 0,
              bottom: 24 + MediaQuery.of(context).padding.bottom,
              child: Center(
                child: EditorIconBar(
                  isTextMode: _isTextMode,
                  selectedFontFamily: _selectedTextIndex != null && _selectedTextIndex! < _canvasTexts.length
                      ? _canvasTexts[_selectedTextIndex!].fontFamily
                      : currentTextFamily,
                  onBackgroundPressed: () {
                    setState(() {
                      _showBackgroundPanel = !_showBackgroundPanel;
                      if (_showBackgroundPanel) _showDrawingPanel = false;
                    });
                  },
                  onDrawPressed: () {
                    setState(() {
                      _showDrawingPanel = !_showDrawingPanel;
                      if (_showDrawingPanel) {
                        _showBackgroundPanel = false;
                        _isDrawingMode = true;
                      }
                    });
                  },
                  onSheetOpened: () => setState(() => _showModalSheet = true),
                  onSheetClosed: () => setState(() => _showModalSheet = false),
                  onTextPressed: () {
                    setState(() => _isTextMode = true);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _textFocusNode.requestFocus();
                    });
                  },
                  onTextStylePressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.transparent,
                      isDismissible: true,
                      enableDrag: true,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        minChildSize: 0.3,
                        maxChildSize: 0.6,
                        builder: (context, scrollController) => TextStylePanel(
                          selectedFontFamily: currentTextFamily,
                          selectedTextAlign: currentTextAlign,
                          onTextFamilyChanged: (family) {
                            setState(() {
                              currentTextFamily = family;
                              if (_selectedTextIndex != null &&
                                  _selectedTextIndex! < _canvasTexts.length) {
                                _canvasTexts[_selectedTextIndex!].fontFamily = family;
                              }
                            });
                          },
                          onTextAlignChanged: (align) {
                            setState(() {
                              currentTextAlign = align;
                              if (_selectedTextIndex != null &&
                                  _selectedTextIndex! < _canvasTexts.length) {
                                _canvasTexts[_selectedTextIndex!].textAlign = align;
                              }
                            });
                          },
                          onClose: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                  onTextClosed: () {
                    if (_textInputController.text.isNotEmpty) {
                      setState(() {
                        _canvasTexts.add(_CanvasText(
                          text: _textInputController.text,
                          fontFamily: currentTextFamily,
                          color: currentTextColor,
                          textAlign: currentTextAlign,
                          isUnderline: currentTextUnderline,
                        ));
                        _selectedTextIndex = _canvasTexts.length - 1;
                      });
                    }
                    _textInputController.clear();
                    _textFocusNode.unfocus();
                    setState(() {
                      _isTextMode = false;
                    });
                  },
                  onFontFamilyChanged: (family) {
                    setState(() {
                      currentTextFamily = family;
                      if (_selectedTextIndex != null &&
                          _selectedTextIndex! < _canvasTexts.length) {
                        _canvasTexts[_selectedTextIndex!].fontFamily = family;
                      }
                    });
                  },
                  onTextColorChanged: (color) {
                    setState(() {
                      currentTextColor = color;
                      if (_selectedTextIndex != null &&
                          _selectedTextIndex! < _canvasTexts.length) {
                        _canvasTexts[_selectedTextIndex!].color = color;
                      }
                    });
                  },
                  onTextAlignChanged: (align) {
                    setState(() {
                      currentTextAlign = align;
                      if (_selectedTextIndex != null &&
                          _selectedTextIndex! < _canvasTexts.length) {
                        _canvasTexts[_selectedTextIndex!].textAlign = align;
                      }
                    });
                  },
                  onUnderlineChanged: (val) {
                    setState(() {
                      currentTextUnderline = val;
                      if (_selectedTextIndex != null &&
                          _selectedTextIndex! < _canvasTexts.length) {
                        _canvasTexts[_selectedTextIndex!].isUnderline = val;
                      }
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _first() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = width * (457 / 350);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        dashPattern: const [6, 4],
                        strokeWidth: 1,
                        radius: const Radius.circular(16),
                        color: AppColors.gray03,
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: width,
                        height: height,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '표지 영역입니다.\n앨범의 표지를 꾸며주세요!',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.body16M140.copyWith(
                            color: AppColors.f02,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Text(
                        '아래로 스크롤해서 앨범을 꾸며주세요.',
                        style: AppTextStyle.body16M120.copyWith(
                          color: AppColors.f02,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class BackgroundState {
  final Color? color;
  final ImageProvider? image;

  BackgroundState({this.color, this.image});
}

class EditorState {
  final List<DrawingPoint?> drawingPoints;
  final BackgroundState background;

  EditorState({
    this.drawingPoints = const [],
    BackgroundState? background,
  }) : background = background ?? BackgroundState();

  EditorState copyWith({
    List<DrawingPoint?>? drawingPoints,
    BackgroundState? background,
  }) {
    return EditorState(
      drawingPoints: drawingPoints ?? this.drawingPoints,
      background: background ?? this.background,
    );
  }
}

class DrawingPoint {
  final Offset offset;
  final Paint paint;
  final String lineStyle;

  DrawingPoint({
    required this.offset,
    required this.paint,
    this.lineStyle = '실선',
  });
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  @override
  void paint(Canvas canvas, Size size) {
    final List<List<DrawingPoint>> strokes = [];
    List<DrawingPoint> cur = [];
    for (final p in drawingPoints) {
      if (p == null) {
        if (cur.isNotEmpty) { strokes.add(List.from(cur)); cur = []; }
      } else {
        cur.add(p);
      }
    }
    if (cur.isNotEmpty) strokes.add(cur);

    for (final stroke in strokes) {
      if (stroke.isEmpty) continue;
      final style = stroke.first.lineStyle;

      if (style == '점선') {
        for (final p in stroke) {
          canvas.drawCircle(
            p.offset,
            p.paint.strokeWidth / 2,
            Paint()..color = p.paint.color..style = PaintingStyle.fill,
          );
        }
      } else if (style == '파선') {
        if (stroke.length == 1) {
          final p = stroke.first;
          canvas.drawLine(
            p.offset,
            p.offset + Offset(p.paint.strokeWidth * 2.5, 0),
            p.paint,
          );
        } else {
          for (int i = 0; i < stroke.length; i++) {
            final p = stroke[i];
            Offset dir;
            if (i < stroke.length - 1) {
              final d = stroke[i + 1].offset - p.offset;
              dir = d.distance > 0 ? d / d.distance : const Offset(1, 0);
            } else {
              final d = p.offset - stroke[i - 1].offset;
              dir = d.distance > 0 ? d / d.distance : const Offset(1, 0);
            }
            canvas.drawLine(p.offset, p.offset + dir * (p.paint.strokeWidth * 2.5), p.paint);
          }
        }
      } else {
        // 실선: 포인트 1개면 점, 2개 이상이면 선
        if (stroke.length == 1) {
          final p = stroke.first;
          canvas.drawCircle(
            p.offset,
            p.paint.strokeWidth / 2,
            Paint()..color = p.paint.color..style = PaintingStyle.fill,
          );
        } else {
          for (int i = 0; i < stroke.length - 1; i++) {
            canvas.drawLine(stroke[i].offset, stroke[i + 1].offset, stroke[i].paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CanvasText {
  final String text;
  double x;
  double y;
  double fontSize;
  String fontFamily;
  Color color;
  TextAlign textAlign;
  bool isUnderline;

  _CanvasText({
    required this.text,
    this.x = 80,
    this.y = 200,
    this.fontSize = 16,
    this.fontFamily = 'Pretendard',
    this.color = Colors.black,
    this.textAlign = TextAlign.left,
    this.isUnderline = false,
  });
}