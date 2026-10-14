import 'package:brofile/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';

/// Collapses [header] while the [body] scrolls down and reveals it on scroll up.
///
/// The bar slides as a whole. The status-bar region stays covered so content
/// never clips through the notch.
class HideOnScroll extends StatefulWidget {
  const HideOnScroll({
    super.key,
    required this.header,
    required this.body,
    this.pinned,
    this.bottom,
    this.statusBarColor = Colors.white,
  });

  final Widget header;
  final Widget body;
  final Widget? pinned;
  final Widget? bottom;
  final Color statusBarColor;

  @override
  State<HideOnScroll> createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll> with SingleTickerProviderStateMixin {
  double _extent = 0;
  late final AnimationController _hide;

  @override
  void initState() {
    super.initState();
    _hide = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _hide.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _hide.dispose();
    super.dispose();
  }

  double get _topInset => MediaQuery.paddingOf(context).top;

  double get _maxHide {
    final inset = _topInset;
    if (_extent <= inset) return _extent;
    return _extent - inset;
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    if (notification is ScrollStartNotification) {
      _hide.stop();
      return false;
    }

    if (notification is ScrollEndNotification) {
      _snap();
      return false;
    }

    if (notification is! ScrollUpdateNotification) return false;
    if (notification.metrics.outOfRange) return false;
    if (notification.metrics.maxScrollExtent <= 0) return false;
    if (_maxHide <= 0) return false;

    if (notification.metrics.pixels <= 0) {
      _hide.value = 0;
      return false;
    }

    final delta = notification.scrollDelta;
    if (delta == null || delta.abs() < 0.5) return false;

    _hide.value = (_hide.value * _maxHide + delta).clamp(0.0, _maxHide) / _maxHide;
    return false;
  }

  void _snap() {
    if (_hide.value == 0 || _hide.value == 1) return;
    _hide.animateTo(
      _hide.value >= 0.35 ? 1 : 0,
      curve: Curves.easeOutCubic,
    );
  }

  void _captureExtent(Size size) {
    if (size.height <= 0) return;
    if ((size.height - _extent).abs() < 0.5) return;
    setState(() => _extent = size.height);
  }

  @override
  Widget build(BuildContext context) {
    final topInset = _topInset;
    final hiddenPx = _hide.value * _maxHide;
    final headerOffset = _extent == 0 ? 0.0 : hiddenPx;
    final bodyTop = _extent == 0 ? 0.0 : (_extent - hiddenPx).clamp(topInset, double.infinity);

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Padding(
            padding: EdgeInsets.only(top: bodyTop),
            child: Column(
              children: [
                if (widget.pinned != null) widget.pinned!,
                Expanded(child: widget.body),
                if (widget.bottom != null) widget.bottom!,
              ],
            ),
          ),
          Positioned(
            top: -headerOffset,
            left: 0,
            right: 0,
            child: _SizeReporter(
              onSize: _captureExtent,
              child: widget.header,
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeReporter extends StatelessWidget {
  const _SizeReporter({required this.onSize, required this.child});

  final ValueChanged<Size> onSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = context.size;
      if (size != null) onSize(size);
    });
    return child;
  }
}

/// Home / tab header that slides away as a whole bar. Status bar stays covered.
class SlidingHomeHeader extends StatefulWidget {
  const SlidingHomeHeader({
    super.key,
    required this.scrollController,
    this.onLogoTap,
  });

  final ScrollController scrollController;
  final VoidCallback? onLogoTap;

  @override
  State<SlidingHomeHeader> createState() => _SlidingHomeHeaderState();
}

class _SlidingHomeHeaderState extends State<SlidingHomeHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hide;
  double _lastOffset = 0;
  VoidCallback? _idleListener;

  static const _range = 64.0;

  @override
  void initState() {
    super.initState();
    _hide = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _hide.addListener(() => setState(() {}));
    widget.scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _attachIdle());
  }

  @override
  void didUpdateWidget(covariant SlidingHomeHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      _detachIdle();
      oldWidget.scrollController.removeListener(_onScroll);
      widget.scrollController.addListener(_onScroll);
      _attachIdle();
    }
  }

  @override
  void dispose() {
    _detachIdle();
    widget.scrollController.removeListener(_onScroll);
    _hide.dispose();
    super.dispose();
  }

  void _attachIdle() {
    if (!widget.scrollController.hasClients) return;
    if (_idleListener != null) return;
    _idleListener = _onIdle;
    widget.scrollController.position.isScrollingNotifier.addListener(_idleListener!);
  }

  void _detachIdle() {
    if (_idleListener == null) return;
    if (widget.scrollController.hasClients) {
      widget.scrollController.position.isScrollingNotifier.removeListener(_idleListener!);
    }
    _idleListener = null;
  }

  void _onIdle() {
    if (!widget.scrollController.hasClients) return;
    if (widget.scrollController.position.isScrollingNotifier.value) {
      _hide.stop();
      return;
    }
    if (_hide.value == 0 || _hide.value == 1) return;
    _hide.animateTo(_hide.value >= 0.35 ? 1 : 0, curve: Curves.easeOutCubic);
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    _attachIdle();
    final offset = widget.scrollController.offset;
    if (widget.scrollController.position.outOfRange) return;

    if (offset <= 0) {
      _hide.value = 0;
      _lastOffset = offset;
      return;
    }

    final delta = offset - _lastOffset;
    _lastOffset = offset;
    if (_hide.isAnimating) return;
    if (delta.abs() < 0.5) return;
    _hide.value = (_hide.value + delta / _range).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final toolbar = HomeHeader.contentHeight;
    final t = _hide.value;
    final extent = topInset + toolbar;

    if (t >= 1) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      ignoring: t > 0.85,
      child: SizedBox(
        height: extent,
        width: double.infinity,
        child: ClipRect(
          child: Transform.translate(
            offset: Offset(0, -extent * t),
            child: HomeHeader(onLogoTap: widget.onLogoTap),
          ),
        ),
      ),
    );
  }
}
