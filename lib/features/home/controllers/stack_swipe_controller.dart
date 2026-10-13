import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

/// Drives the draggable top card of a stacked gallery post.
class StackSwipeController extends GetxController
    with GetTickerProviderStateMixin {
  StackSwipeController(this.post);

  final PostModel post;

  /// Current offset of the top card from its resting position.
  final drag = Offset.zero.obs;

  /// Opacity of the card that re-enters the back of the stack.
  final backOpacity = 1.0.obs;

  late final AnimationController _moveController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  );
  late final AnimationController _fadeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  )..addListener(() => backOpacity.value = _fadeController.value);

  Animation<Offset>? _moveAnimation;

  /// Distance at which a released card is thrown away and the back cards
  /// have fully moved into their next slots.
  double swipeDistance = 120;

  /// How far off-screen the card travels before it is recycled.
  double flyOutDistance = 600;

  static const double _flingVelocity = 700;

  bool get isAnimating => _moveController.isAnimating;

  /// 0 when resting, 1 once the top card has been dragged far enough.
  double get progress => (drag.value.dx.abs() / swipeDistance).clamp(0.0, 1.0);

  @override
  void onInit() {
    super.onInit();
    _moveController.addListener(() {
      final animation = _moveAnimation;
      if (animation != null) drag.value = animation.value;
    });
  }

  void onDragUpdate(Offset delta) {
    if (isAnimating) return;
    drag.value += Offset(delta.dx, delta.dy * 0.3);
  }

  void onDragEnd(double velocityX) {
    if (isAnimating) return;
    final dx = drag.value.dx;
    final flung = velocityX.abs() > _flingVelocity && velocityX.sign == dx.sign;
    if (dx.abs() >= swipeDistance || flung) {
      _flyOut(dx.sign == 0 ? velocityX.sign : dx.sign);
    } else {
      _animateTo(Offset.zero, Curves.easeOutBack);
    }
  }

  /// Throws the top card to the left, used for taps.
  void swipeLeft() {
    if (!isAnimating) _flyOut(-1);
  }

  Future<void> _flyOut(double direction) async {
    final target = Offset(
      direction * flyOutDistance,
      drag.value.dy + 40 * direction.abs(),
    );
    await _animateTo(target, Curves.easeOut);
    Get.find<HomeController>().nextStackImage(post);
    drag.value = Offset.zero;
    _fadeController.forward(from: 0);
  }

  Future<void> _animateTo(Offset target, Curve curve) {
    _moveAnimation = Tween(begin: drag.value, end: target)
        .chain(CurveTween(curve: curve))
        .animate(_moveController);
    return _moveController.forward(from: 0).orCancel.catchError((_) {});
  }

  @override
  void onClose() {
    _moveController.dispose();
    _fadeController.dispose();
    super.onClose();
  }
}
