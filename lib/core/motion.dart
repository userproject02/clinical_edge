import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// Motion tokens. Every animation in the app uses these constants.
///
/// All motion is switched off when the platform asks for reduced motion
/// (`MediaQuery.disableAnimations`): use [Motion.duration] or
/// [Motion.enabled] instead of reading the constants directly in widgets.
///
/// Rule: never animate scale on widgets that contain text (it renders
/// blurry). Use opacity and translate.
abstract final class Motion {
  // Curves -----------------------------------------------------------------

  /// Standard ease-out used for tabs, lists, rings and bars.
  static const Curve standard = Cubic(0.2, 0.7, 0.2, 1);

  /// Emphasised ease-out used for pushes, sheets, snackbars and banners.
  static const Curve emphasized = Cubic(0.2, 0.8, 0.2, 1);

  // Durations --------------------------------------------------------------

  /// Tab switch: fade + 8 px upward slide.
  static const Duration tabSwitch = Duration(milliseconds: 360);

  /// Push: shared-axis horizontal slide (36 px) + fade.
  static const Duration push = Duration(milliseconds: 420);

  /// One list item's fade-up.
  static const Duration listItem = Duration(milliseconds: 500);

  /// Delay between consecutive list items.
  static const Duration listStagger = Duration(milliseconds: 50);

  /// Progress ring sweep.
  static const Duration ringSweep = Duration(milliseconds: 1300);

  /// Delay before a ring starts sweeping.
  static const Duration ringDelay = Duration(milliseconds: 100);

  /// Linear meter / bar growth.
  static const Duration barGrow = Duration(milliseconds: 1000);

  /// Delay before a bar starts growing.
  static const Duration barDelay = Duration(milliseconds: 150);

  /// Expiry / notification dot pulse loop.
  static const Duration pulse = Duration(milliseconds: 2200);

  /// ECG heartbeat line loop.
  static const Duration ecg = Duration(milliseconds: 3600);

  /// Skeleton shimmer loop.
  static const Duration shimmer = Duration(milliseconds: 1200);

  /// Bottom sheet enter/exit.
  static const Duration sheet = Duration(milliseconds: 420);

  /// Snackbar enter/exit.
  static const Duration snackbar = Duration(milliseconds: 400);

  /// How long a snackbar stays visible.
  static const Duration snackbarVisible = Duration(milliseconds: 3200);

  /// Notification banner enter/exit.
  static const Duration banner = Duration(milliseconds: 500);

  /// How long a notification banner stays visible.
  static const Duration bannerVisible = Duration(milliseconds: 4000);

  /// Wrong quiz answer shake.
  static const Duration shake = Duration(milliseconds: 400);

  /// Success check mark draw.
  static const Duration checkDraw = Duration(milliseconds: 500);

  // Distances --------------------------------------------------------------

  /// Tab switch upward slide.
  static const double tabSlide = 8;

  /// Push horizontal slide.
  static const double pushSlide = 36;

  /// List item upward slide.
  static const double listSlide = 12;

  /// Snackbar upward slide.
  static const double snackbarSlide = 24;

  /// Shake amplitude.
  static const double shakeOffset = 5;

  // Helpers ----------------------------------------------------------------

  /// Whether animations should run in this context.
  static bool enabled(BuildContext context) =>
      !(MediaQuery.maybeDisableAnimationsOf(context) ?? false);

  /// [d] when motion is enabled, otherwise [Duration.zero].
  static Duration duration(BuildContext context, Duration d) =>
      enabled(context) ? d : Duration.zero;

  /// Delay before item [index] of a staggered list.
  static Duration staggerDelay(int index) => listStagger * index;
}

/// Shared-axis horizontal page transition used for every push.
///
/// The incoming page fades in while sliding [Motion.pushSlide] from the end
/// edge; the outgoing page fades out while sliding towards the start edge.
/// Direction mirrors in RTL.
class SharedAxisPageTransition extends StatelessWidget {
  /// Wraps [child] with the transition driven by the route animations.
  const new({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
    super.key,
  });

  /// Incoming animation (0 → 1 when pushed).
  final Animation<double> animation;

  /// Outgoing animation (0 → 1 when another route is pushed on top).
  final Animation<double> secondaryAnimation;

  /// The page.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dir = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    final inCurve = CurvedAnimation(
      parent: animation,
      curve: Motion.emphasized,
      reverseCurve: Motion.emphasized.flipped,
    );
    final outCurve = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Motion.emphasized,
      reverseCurve: Motion.emphasized.flipped,
    );
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[inCurve, outCurve]),
      child: child,
      builder: (context, child) {
        final dx =
            dir * Motion.pushSlide * (1 - inCurve.value) -
            dir * Motion.pushSlide * outCurve.value;
        final opacity = (inCurve.value * (1 - outCurve.value)).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
    );
  }
}

/// [PageTransitionsBuilder] that applies [SharedAxisPageTransition] to any
/// `MaterialPageRoute` (used by the theme so ad-hoc routes match go_router).
class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates the builder.
  const new();

  @override
  Duration get transitionDuration => Motion.push;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!Motion.enabled(context)) return child;
    return SharedAxisPageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

/// Plays a fade + upward slide each time [switchKey] changes.
///
/// Used by the role shells for tab switches: the indexed stack keeps every
/// tab alive, and this replays the entrance on the newly selected tab.
class TabSwitchTransition extends StatefulWidget {
  /// Creates the transition.
  const new({required this.switchKey, required this.child, super.key});

  /// Changes when the visible tab changes (e.g. the branch index).
  final Object switchKey;

  /// The shell body.
  final Widget child;

  @override
  State<TabSwitchTransition> createState() => _TabSwitchTransitionState();
}

class _TabSwitchTransitionState extends State<TabSwitchTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.tabSwitch,
    value: 1,
  );

  @override
  void didUpdateWidget(TabSwitchTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.switchKey != widget.switchKey && Motion.enabled(context)) {
      _c.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _c, curve: Motion.standard);
    return AnimatedBuilder(
      animation: curved,
      child: widget.child,
      builder: (context, child) => Opacity(
        opacity: curved.value,
        child: Transform.translate(
          offset: Offset(0, Motion.tabSlide * (1 - curved.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Fade-up entrance for one item of a staggered list.
///
/// Item [index] starts after `index × 50 ms` and fades up over 500 ms.
class FadeUpIn extends StatefulWidget {
  /// Creates the entrance.
  const new({required this.child, this.index = 0, super.key});

  /// Position in the list (controls the delay).
  final int index;

  /// The item.
  final Widget child;

  @override
  State<FadeUpIn> createState() => _FadeUpInState();
}

class _FadeUpInState extends State<FadeUpIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.listItem + Motion.staggerDelay(widget.index),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!Motion.enabled(context)) {
      _c.value = 1;
    } else if (!_c.isAnimating && _c.value == 0) {
      _c.forward();
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _c.duration!.inMicroseconds;
    final start = Motion.staggerDelay(widget.index).inMicroseconds / total;
    final curved = CurvedAnimation(
      parent: _c,
      curve: Interval(start, 1, curve: Motion.standard),
    );
    return AnimatedBuilder(
      animation: curved,
      child: widget.child,
      builder: (context, child) => Opacity(
        opacity: curved.value,
        child: Transform.translate(
          offset: Offset(0, Motion.listSlide * (1 - curved.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Horizontal shake (wrong quiz answer). Call [ShakeState.shake] through a
/// `GlobalKey<ShakeState>`, or change [trigger] to shake once.
class Shake extends StatefulWidget {
  /// Creates a shakeable wrapper.
  const new({required this.child, this.trigger = 0, super.key});

  /// Each change of this value plays one shake.
  final int trigger;

  /// The content.
  final Widget child;

  @override
  State<Shake> createState() => ShakeState();
}

/// State of [Shake]; exposes [shake].
class ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: Motion.shake,
  );

  /// Plays one shake (no-op with reduced motion).
  void shake() {
    if (Motion.enabled(context)) _c.forward(from: 0);
  }

  @override
  void didUpdateWidget(Shake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trigger != widget.trigger) shake();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (context, child) {
        // 0 → -5 → +5 → 0, matching the prototype keyframes.
        final dx = math.sin(_c.value * 2 * math.pi) * -Motion.shakeOffset;
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}
