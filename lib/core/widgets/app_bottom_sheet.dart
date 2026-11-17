import 'package:clinical_edge/app/theme/app_colors.dart';
import 'package:clinical_edge/app/theme/app_typography.dart';
import 'package:clinical_edge/core/motion.dart';
import 'package:material_ui/material_ui.dart';

/// Modal bottom sheet content: drag handle, optional title and body, with
/// 28 dp top corners. Present it with [showAppBottomSheet].
class AppBottomSheet extends StatelessWidget {
  /// Creates the sheet body.
  const new({required this.child, this.title, super.key});

  /// Sheet title.
  final String? title;

  /// Content under the title.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Material(
      color: c.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.sheet),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(18, 10, 18, 26 + bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: c.outline,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                ),
              ),
              if (title != null) ...<Widget>[
                Semantics(
                  header: true,
                  child: Text(
                    title!,
                    style: context.sectionTitle.copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 14),
              ],
              Flexible(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

/// Presents a modal bottom sheet over a scrim, sliding up over 420 ms.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
}) {
  final c = context.colors;
  final duration = Motion.duration(context, Motion.sheet);
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: useRootNavigator,
    isScrollControlled: true,
    backgroundColor: FixedColors.transparent,
    barrierColor: c.scrim,
    elevation: 0,
    sheetAnimationStyle: AnimationStyle(
      duration: duration,
      reverseDuration: duration,
      curve: Motion.emphasized,
      reverseCurve: Motion.emphasized.flipped,
    ),
    builder: builder,
  );
}

/// go_router-friendly [Page] that shows its child as an app bottom sheet,
/// so routes such as `/certs/upload` deep-link to a sheet.
class BottomSheetPage<T> extends Page<T> {
  /// Creates the page.
  const new({required this.child, super.key, super.name});

  /// Sheet content (usually an [AppBottomSheet]).
  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    final c = context.colors;
    final duration = Motion.duration(context, Motion.sheet);
    return ModalBottomSheetRoute<T>(
      settings: this,
      builder: (_) => child,
      isScrollControlled: true,
      backgroundColor: FixedColors.transparent,
      modalBarrierColor: c.scrim,
      elevation: 0,
      sheetAnimationStyle: AnimationStyle(
        duration: duration,
        reverseDuration: duration,
        curve: Motion.emphasized,
        reverseCurve: Motion.emphasized.flipped,
      ),
    );
  }
}
