import 'dart:async';

import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Edge an overlay slides in from.
enum OverlayEdge {
  /// Slides down from above the top edge (notification banner).
  top,

  /// Slides up from below (snackbar).
  bottom,
}

/// Handle to a shown overlay.
class TimedOverlayHandle {
  new _(this._dismiss);

  final Future<void> Function() _dismiss;

  /// Animates the overlay out and removes it.
  Future<void> dismiss() => _dismiss();
}

/// Shows [child] in the nearest [Overlay] with a slide + fade entrance, keeps
/// it for [visibleFor] and animates it out. Only one overlay per [edge] is
/// visible at a time; a new one replaces the previous.
TimedOverlayHandle showTimedOverlay({
  required BuildContext context,
  required Widget child,
  required OverlayEdge edge,
  required Duration animation,
  required Duration visibleFor,
  required double offset,
  EdgeInsetsGeometry margin = const EdgeInsets.all(12),
}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  final key = GlobalKey<_TimedOverlayState>();
  late final OverlayEntry entry;
  var removed = false;

  Future<void> dismiss() async {
    if (removed) return;
    await key.currentState?.reverse();
    if (removed) return;
    removed = true;
    entry.remove();
    if (_current[edge] == entry) _current.remove(edge);
  }

  final previous = _current[edge];
  if (previous != null && previous.mounted) previous.remove();

  entry = OverlayEntry(
    builder: (ctx) => _TimedOverlay(
      key: key,
      edge: edge,
      animation: Motion.duration(ctx, animation),
      offset: offset,
      margin: margin,
      onTimeout: dismiss,
      visibleFor: visibleFor,
      child: child,
    ),
  );
  _current[edge] = entry;
  overlay.insert(entry);
  return TimedOverlayHandle._(dismiss);
}

final Map<OverlayEdge, OverlayEntry> _current = <OverlayEdge, OverlayEntry>{};

class _TimedOverlay extends StatefulWidget {
  const new({
    required this.edge,
    required this.animation,
    required this.visibleFor,
    required this.offset,
    required this.margin,
    required this.onTimeout,
    required this.child,
    super.key,
  });

  final OverlayEdge edge;
  final Duration animation;
  final Duration visibleFor;
  final double offset;
  final EdgeInsetsGeometry margin;
  final Future<void> Function() onTimeout;
  final Widget child;

  @override
  State<_TimedOverlay> createState() => _TimedOverlayState();
}

class _TimedOverlayState extends State<_TimedOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.animation,
  )..forward();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.animation + widget.visibleFor, widget.onTimeout);
  }

  Future<void> reverse() async {
    if (!mounted) return;
    await _c.reverse();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = widget.edge == OverlayEdge.top;
    final curved = CurvedAnimation(parent: _c, curve: Motion.emphasized);
    return Positioned.fill(
      child: SafeArea(
        child: Align(
          alignment: top ? Alignment.topCenter : Alignment.bottomCenter,
          child: Padding(
            padding: widget.margin,
            child: AnimatedBuilder(
              animation: curved,
              child: widget.child,
              builder: (context, child) {
                final t = curved.value;
                // Top banner: translateY(-110 %) → 0 (offset < 0 means
                // fraction of own height). Snackbar: translateY(24 px) → 0.
                return Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: top
                      ? FractionalTranslation(
                          translation: Offset(0, widget.offset * (1 - t)),
                          child: child,
                        )
                      : Transform.translate(
                          offset: Offset(0, widget.offset * (1 - t)),
                          child: child,
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
