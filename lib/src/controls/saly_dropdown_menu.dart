import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

///Model for configuration DropDownMenu
abstract interface class SalyDropDownMenuItem {
  abstract final int menuId;
  abstract final String title;
}

class SalyDropDownMenu<T extends SalyDropDownMenuItem> extends StatefulWidget {
  const SalyDropDownMenu({
    required this.items,
    required this.onChange,
    required this.initValue,
    this.isDisable = false,
    this.contentHeight = _defaultHeight,
    super.key,
  });

  static const _defaultHeight = 300.0;

  final SalyDropDownMenuItem initValue;
  final List<SalyDropDownMenuItem> items;
  final void Function(T value) onChange;
  final bool isDisable;
  final double contentHeight;

  @override
  State<SalyDropDownMenu> createState() => _SalyDropDownMenuState<T>();
}

abstract interface class _ScrollUpdatingDelegate {
  void scrollPosition(double offset);
}

class _SalyDropDownMenuState<T extends SalyDropDownMenuItem> extends State<SalyDropDownMenu<T>>
    implements _ScrollUpdatingDelegate {
  late final LayerLink _layerLink = LayerLink();
  OverlayEntry? _entry;
  SalyDropDownMenuItem? _selectedItem;
  double _previousScrollOffset = 0.0;

  bool get _isActive => _entry != null;

  @override
  void scrollPosition(double offset) => _previousScrollOffset = offset;

  void _show() {
    if (_isActive) return;

    setState(() {
      _entry = OverlayEntry(
        builder: (context) {
          return Positioned(
            left: 20,
            right: 20,
            height: 300,
            child: CompositedTransformFollower(
              offset: const Offset(0, 4),
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              link: _layerLink,
              child: _DropDownMenuContent<T>(
                initValue: _selectedItem ?? widget.initValue,
                scrollController: ScrollController(initialScrollOffset: _previousScrollOffset),
                onTapOutside: () => _close(),
                items: widget.items,
                scrollUpdatingDelegate: this,
                onSelect: (value) {
                  widget.onChange(value);
                  setState(() => _selectedItem = value);
                  _close();
                },
              ),
            ),
          );
        },
      );
    });

    Overlay.of(context).insert(_entry!);
  }

  void _close() {
    _entry?.remove();
    setState(() => _entry = null);
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _layerLink,
    child: GestureDetector(
      onTap: widget.isDisable ? null : _show,
      child: Opacity(
        opacity: widget.isDisable ? 0.4 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            border: Border.all(color: _isActive ? context.colors.statusInfoS1 : context.colors.neutralSecondaryS3),
            borderRadius: BorderRadius.circular(16),
            color: _isActive ? context.colors.statusInfoS2 : context.colors.neutralPrimaryS1,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedItem?.title ?? widget.initValue.title,
                    style: context.fonts.body,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                SalyAssets.icons.sort.svg(
                  colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS2, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  @override
  void dispose() {
    _close();
    super.dispose();
  }
}

class _DropDownMenuContent<T extends SalyDropDownMenuItem> extends StatefulWidget {
  const _DropDownMenuContent({
    required this.initValue,
    required this.items,
    required this.onSelect,
    this.scrollUpdatingDelegate,
    this.onTapOutside,
    this.scrollController,
  });

  final SalyDropDownMenuItem initValue;
  final List<SalyDropDownMenuItem> items;
  final VoidCallback? onTapOutside;
  final ScrollController? scrollController;
  final _ScrollUpdatingDelegate? scrollUpdatingDelegate;
  final void Function(T value) onSelect;

  @override
  State<_DropDownMenuContent> createState() => _DropDownMenuContentState<T>();
}

class _DropDownMenuContentState<T extends SalyDropDownMenuItem> extends State<_DropDownMenuContent<T>> {
  final _animationDuration = const Duration(milliseconds: 170);
  CrossFadeState _state = CrossFadeState.showSecond;

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      widget.scrollController?.jumpTo(widget.scrollController?.initialScrollOffset ?? .0);
      setState(() => _state = CrossFadeState.showFirst);
    });

    widget.scrollController?.addListener(() {
      if (widget.scrollController != null) {
        widget.scrollUpdatingDelegate?.scrollPosition(widget.scrollController!.offset);
      }
    });
  }

  Future<void> _onTapOutside(PointerDownEvent _) async {
    setState(() => _state = CrossFadeState.showSecond);
    await Future.delayed(_animationDuration);
    widget.onTapOutside?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      sizeCurve: Curves.easeInOut,
      duration: _animationDuration,
      crossFadeState: _state,
      secondChild: const SizedBox.shrink(),
      firstChild: TapRegion(
        onTapOutside: _onTapOutside,
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.statusInfoS1),
              borderRadius: BorderRadius.circular(16),
              color: context.colors.neutralPrimaryS1,
              boxShadow: [BoxShadow(color: const Color(0xFF7AA6D9).withValues(alpha: .1), blurRadius: 16)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final (i, item) in widget.items.indexed) ...[
                        _DropDownMenuItemWidget(
                          isActive: item.menuId == widget.initValue.menuId,
                          title: item.title,
                          onChange: (_) async {
                            await Future.delayed(const Duration(milliseconds: 150));
                            widget.onSelect.call(item as T);
                          },
                        ),
                        if (i != widget.items.length - 1) Divider(color: context.colors.neutralSecondaryS3, height: 1),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController?.dispose();
    super.dispose();
  }
}

class _DropDownMenuItemWidget extends StatelessWidget {
  const _DropDownMenuItemWidget({required this.isActive, required this.title, this.onChange});

  final String title;
  final bool isActive;
  final void Function(bool value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChange?.call(!isActive),
        splashColor: context.colors.neutralSecondaryS3.withValues(alpha: .4),
        highlightColor: context.colors.neutralSecondaryS3.withValues(alpha: .4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: context.fonts.body, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 170),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                child: isActive
                    ? SalyAssets.icons.statusOk.svg(
                        key: const ValueKey(1),
                        colorFilter: ColorFilter.mode(context.colors.statusInfoS1, BlendMode.srcIn),
                        height: 26,
                        width: 26,
                      )
                    : SizedBox.square(
                        dimension: 26,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: context.colors.neutralSecondaryS3),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
