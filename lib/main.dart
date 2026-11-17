import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const ClinicalEdgeApp());
}

/// Root widget of ClinicalEdge.
///
/// Phase 0 placeholder. Phase 1 replaces it with the themed, localised,
/// routed app shell (see docs/REQUIREMENTS.md and CLAUDE.md).
class ClinicalEdgeApp extends StatelessWidget {
  /// Creates the root widget.
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClinicalEdge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A6E73)),
      ),
      home: const Scaffold(body: Center(child: Text('ClinicalEdge'))),
    );
  }
}
